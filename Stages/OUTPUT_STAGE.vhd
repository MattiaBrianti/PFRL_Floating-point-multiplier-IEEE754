library ieee;
use ieee.std_logic_1164.all;

entity OUTPUT_STAGE is
    port (
        FLAG : in STD_LOGIC_VECTOR (1 downto 0);
        S : in STD_LOGIC;
        exp_out : in STD_LOGIC_VECTOR(9 downto 0);
        P : in STD_LOGIC_VECTOR(47 downto 0);
        RES_FINAL : out STD_LOGIC_VECTOR (31 downto 0);
        NaN_flag : out std_logic;
        zero_flag : out std_logic;
        inf_flag : out std_logic
    );
    end entity OUTPUT_STAGE;
    
    architecture RTL of OUTPUT_STAGE is

    signal OFFSET : STD_LOGIC_VECTOR(4 downto 0);
    signal SUB : STD_LOGIC;

    signal MANT_OUT : STD_LOGIC_VECTOR(22 downto 0);
    signal RES_FINAL_1: STD_LOGIC_VECTOR(9 downto 0);

    signal EXP_OUT_1 : STD_LOGIC_VECTOR(7 downto 0);
    signal MANT_OUT_1 : STD_LOGIC_VECTOR(22 downto 0);

    component ROUND is
        port (
            MANT_MULT : in STD_LOGIC_VECTOR (47 downto 0);
            MANT_SHIFT : out STD_LOGIC_VECTOR (22 downto 0);
            OFFSET : out STD_LOGIC_VECTOR (4 downto 0);
            SUB : out STD_LOGIC
        );
    end component;

    component FINAL_EXP_CALC is
        port (
            EXP : in STD_LOGIC_VECTOR(9 downto 0);
            OFFSET : in STD_LOGIC_VECTOR(4 downto 0);
            SUB : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;

    component RES_FIX is
        port (
            EXP_IN : in STD_LOGIC_VECTOR(9 downto 0);
            MANT_IN : in STD_LOGIC_VECTOR(22 downto 0);
            EXP_OUT : out STD_LOGIC_VECTOR(7 downto 0);
            MANT_OUT : out STD_LOGIC_VECTOR(22 downto 0)
        );
    end component;

    component FLAG_DETECTOR is
        port (
            FLAG : in STD_LOGIC_VECTOR (1 downto 0);
            S : in STD_LOGIC;
            MANT_IN : in STD_LOGIC_VECTOR (22 downto 0);
            EXP_IN : in STD_LOGIC_VECTOR (7 downto 0);
            RES_FINAL : out STD_LOGIC_VECTOR (31 downto 0);
            NaN_flag : out std_logic;
            zero_flag : out std_logic;
            inf_flag : out std_logic
        );
    end component;

    begin

    
    U1 : ROUND
    port map(
        MANT_MULT => P,
        MANT_SHIFT => MANT_OUT,
        OFFSET => OFFSET,
        SUB => SUB
    );

    U2 : FINAL_EXP_CALC
    port map(
        EXP => exp_out(9 downto 0),
        OFFSET => OFFSET(4 downto 0),
        SUB => SUB,
        S => RES_FINAL_1(9 downto 0)
    );

    U3 : RES_FIX
    port map(
        EXP_IN => RES_FINAL_1(9 downto 0),
        MANT_IN => MANT_OUT(22 downto 0),
        EXP_OUT => EXP_OUT_1(7 downto 0),
        MANT_OUT => MANT_OUT_1(22 downto 0)
    );

    U4 : FLAG_DETECTOR
    port map(
        FLAG => FLAG,
        S => S,
        MANT_IN => MANT_OUT_1,
        EXP_IN => EXP_OUT_1,
        RES_FINAL => RES_FINAL,
        NaN_flag => NaN_flag,
        zero_flag => zero_flag,
        inf_flag => inf_flag
    );
    
    end architecture RTL;