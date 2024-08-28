library ieee;
use ieee.std_logic_1164.all;

entity MULTIPLIER_IEEE754 is
    port (
        X : in STD_LOGIC_VECTOR(31 downto 0);
        Y : in STD_LOGIC_VECTOR(31 downto 0);
        RESULT : out STD_LOGIC_VECTOR(31 downto 0);
        INVALID : out STD_LOGIC
    );
end entity MULTIPLIER_IEEE754;

architecture RTL of MULTIPLIER_IEEE754 is

    signal FLAG : STD_LOGIC_VECTOR (1 downto 0);
    signal S : STD_LOGIC;
    signal EXP_X : STD_LOGIC_VECTOR (7 downto 0);
    signal EXP_Y : STD_LOGIC_VECTOR (7 downto 0);
    signal FIXED_MANT_X : STD_LOGIC_VECTOR (23 downto 0);
    signal FIXED_MANT_Y : STD_LOGIC_VECTOR (23 downto 0);
    signal S_OUT : STD_LOGIC;
    signal FLAG_OUT : STD_LOGIC_VECTOR (1 downto 0);
    signal P : STD_LOGIC_VECTOR(47 downto 0);
    signal exp_out : STD_LOGIC_VECTOR(9 downto 0);
    component PREP_STAGE is
        port (
            X : in STD_LOGIC_VECTOR(31 downto 0);
            Y : in STD_LOGIC_VECTOR(31 downto 0);
            FLAG : out STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            S : out STD_LOGIC;
            EXP_X : out STD_LOGIC_VECTOR (7 downto 0);
            EXP_Y : out STD_LOGIC_VECTOR (7 downto 0);
            FIXED_MANT_X : out STD_LOGIC_VECTOR (23 downto 0); -- 24-bit mantissa
            FIXED_MANT_Y : out STD_LOGIC_VECTOR (23 downto 0) -- 24-bit mantissa
        );
    end component;

    component CALC_STAGE is
        port (
            FLAG : in STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            S : in STD_LOGIC;
            EXP_X : in STD_LOGIC_VECTOR (7 downto 0);
            EXP_Y : in STD_LOGIC_VECTOR (7 downto 0);
            FIXED_MANT_X : in STD_LOGIC_VECTOR (23 downto 0); -- 24-bit mantissa
            FIXED_MANT_Y : in STD_LOGIC_VECTOR (23 downto 0); -- 24-bit mantissa
            S_OUT : out STD_LOGIC;
            FLAG_OUT : out STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            P : out STD_LOGIC_VECTOR(47 downto 0);
            exp_out : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;

    component OUTPUT_STAGE is
        port (
            FLAG : in STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            S : in STD_LOGIC;
            exp_out : in STD_LOGIC_VECTOR(9 downto 0);
            P : in STD_LOGIC_VECTOR(47 downto 0);
            RES_FINAL : out STD_LOGIC_VECTOR (31 downto 0);
            INVALID : out STD_LOGIC
        );
    end component;

begin

    U0 : PREP_STAGE port map(
        X => X,
        Y => Y,
        FLAG => FLAG,
        S => S,
        EXP_X => EXP_X,
        EXP_Y => EXP_Y,
        FIXED_MANT_X => FIXED_MANT_X,
        FIXED_MANT_Y => FIXED_MANT_Y
    );

    U1 : CALC_STAGE port map(
        FLAG => FLAG,
        S => S,
        EXP_X => EXP_X,
        EXP_Y => EXP_Y,
        FIXED_MANT_X => FIXED_MANT_X,
        FIXED_MANT_Y => FIXED_MANT_Y,
        S_OUT => S_OUT,
        FLAG_OUT => FLAG_OUT,
        P => P,
        exp_out => exp_out
    );

    U2 : OUTPUT_STAGE port map(
        FLAG => FLAG_OUT,
        S => S_OUT,
        exp_out => exp_out,
        P => P,
        RES_FINAL => RESULT,
        INVALID => INVALID
    );

end architecture RTL;