library ieee;
use ieee.std_logic_1164.all;

entity OUTPUT_STAGE is
    port (
        FLAG_OUT : in STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
        S_OUT : in STD_LOGIC;
        MANT_OUT: in STD_LOGIC_VECTOR(22 downto 0);
        RES_FINAL_1: in STD_LOGIC_VECTOR(9 downto 0);
        RES_FINAL : out STD_LOGIC_VECTOR (31 downto 0);
        INVALID : out STD_LOGIC
    );
    end entity OUTPUT_STAGE;

architecture RTL of OUTPUT_STAGE is
    signal EXP_OUT_1 : STD_LOGIC_VECTOR(7 downto 0);
    signal MANT_OUT_1 : STD_LOGIC_VECTOR(22 downto 0);

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
            INVALID : out STD_LOGIC
        );
    end component;

    begin

    U1 : RES_FIX
    port map(
        EXP_IN => RES_FINAL_1(9 downto 0),
        MANT_IN => MANT_OUT(22 downto 0),
        EXP_OUT => EXP_OUT_1(7 downto 0),
        MANT_OUT => MANT_OUT_1(22 downto 0)
    );

    U2 : FLAG_DETECTOR
    port map(
        FLAG => FLAG_OUT,
        S => S_OUT,
        MANT_IN => MANT_OUT_1,
        EXP_IN => EXP_OUT_1,
        RES_FINAL => RES_FINAL,
        INVALID => INVALID
    );
end architecture RTL;