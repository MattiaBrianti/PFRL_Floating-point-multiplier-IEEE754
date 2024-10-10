library ieee;
use ieee.std_logic_1164.all;

entity ROUNDER_STAGE is
    port (
        FLAG : in STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
        S : in STD_LOGIC;
        exp_out : in STD_LOGIC_VECTOR(9 downto 0);
        P : in STD_LOGIC_VECTOR(47 downto 0);
        MANT_OUT: out STD_LOGIC_VECTOR(22 downto 0);
        RES_FINAL_1: out STD_LOGIC_VECTOR(9 downto 0);
        FLAG_OUT : out STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
        S_OUT : out STD_LOGIC
    );
    end entity ROUNDER_STAGE;
    
    architecture RTL of ROUNDER_STAGE is
    signal OFFSET : STD_LOGIC_VECTOR(4 downto 0);
    signal SUB : STD_LOGIC;

    component ROUND is
        port (
            MANT_EXT : in STD_LOGIC_VECTOR (47 downto 0);
            MANT_SHIFT : out STD_LOGIC_VECTOR (22 downto 0);
            OFFSET : out STD_LOGIC_VECTOR (4 downto 0);
            SUB : out STD_LOGIC
        );
    end component;

    component FINAL_EXP_CALC is
        generic (N : INTEGER := 24);
        port (
            EXP : in STD_LOGIC_VECTOR(9 downto 0); -- è un numero con segno
            OFFSET : in STD_LOGIC_VECTOR(4 downto 0);
            SUB : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;

    begin
    
    S_OUT <= S;
    FLAG_OUT <= FLAG;
    
    U1 : ROUND
    port map(
        MANT_EXT => P,
        MANT_SHIFT => MANT_OUT,
        OFFSET => OFFSET,
        SUB => SUB
    );

    U2 : FINAL_EXP_CALC
    generic map(N => 24)
    port map(
        EXP => exp_out(9 downto 0),
        OFFSET => OFFSET(4 downto 0),
        SUB => SUB,
        S => RES_FINAL_1(9 downto 0)
    );
    
    end architecture RTL;