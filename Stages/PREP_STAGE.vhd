library ieee;
use ieee.std_logic_1164.all;

entity PREP_STAGE is
    port (
        X : in std_logic_vector(31 downto 0);
        Y : in std_logic_vector(31 downto 0);
        FLAG : out std_logic_vector (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
        S : out std_logic;
        EXP_X : out std_logic_vector (7 downto 0);
        EXP_Y : out std_logic_vector (7 downto 0);
        FIXED_MANT_X : out std_logic_vector (23 downto 0); -- 24-bit mantissa
        FIXED_MANT_Y : out std_logic_vector (23 downto 0) -- 24-bit mantissa
        --
        CLK : in std_logic;
        RST : in std_logic;
    );
end entity PREP_STAGE;

architecture RTL of PREP_STAGE is

    signal T_X : std_logic_vector(31 downto 0);
    signal T_Y : std_logic_vector(31 downto 0);
    signal S_X : std_logic;
    signal S_Y : std_logic;
    signal MANT_X : std_logic_vector(22 downto 0);
    signal MANT_Y : std_logic_vector(22 downto 0);
    signal S_EXP_X : std_logic_vector(7 downto 0);
    signal S_EXP_Y : std_logic_vector(7 downto 0);

    component EDGE_CASES_CHECK is
        port (
            EXP_X : in std_logic_vector (7 downto 0); -- 8-bit exponent
            EXP_Y : in std_logic_vector (7 downto 0); -- 8-bit exponent
            MANT_X : in std_logic_vector (22 downto 0); -- 23-bit mantissa
            MANT_Y : in std_logic_vector (22 downto 0); -- 23-bit mantissa
            FLAG : out std_logic_vector (1 downto 0) -- 2-bit flag for INF, NAN, ZERO and DENORM
        );
    end component;

    component OPERANDS_SPLITTER is
        port (
            X : in std_logic_vector (31 downto 0);
            Y : in std_logic_vector (31 downto 0);
            S_X : out std_logic;
            S_Y : out std_logic;
            EXP_X : out std_logic_vector (7 downto 0);
            EXP_Y : out std_logic_vector (7 downto 0);
            MANT_X : out std_logic_vector (22 downto 0);
            MANT_Y : out std_logic_vector (22 downto 0)
        );
    end component;

    component MANTIX_FIXER is
        port (
            MANT_X : in std_logic_vector (22 downto 0); -- 23-bit mantissa
            MANT_Y : in std_logic_vector (22 downto 0); -- 23-bit mantissa
            EXP_X : in std_logic_vector (7 downto 0); -- 8-bit exponent
            EXP_Y : in std_logic_vector (7 downto 0); -- 8-bit exponent

            FIXED_MANT_X : out std_logic_vector (23 downto 0); -- 24-bit mantissa
            FIXED_MANT_Y : out std_logic_vector (23 downto 0) -- 24-bit mantissa
        );
    end component;

begin

    U1 : OPERANDS_SPLITTER
    port map(
        X => X,
        Y => Y,
        S_X => S_X,
        S_Y => S_Y,
        EXP_X => S_EXP_X,
        EXP_Y => S_EXP_Y,
        MANT_X => MANT_X,
        MANT_Y => MANT_Y
    );

    U2 : MANTIX_FIXER
    port map(
        MANT_X => MANT_X,
        MANT_Y => MANT_Y,
        EXP_X => S_EXP_X,
        EXP_Y => S_EXP_Y,
        FIXED_MANT_X => FIXED_MANT_X,
        FIXED_MANT_Y => FIXED_MANT_Y
    );

    U3 : EDGE_CASES_CHECK
    port map(
        EXP_X => S_EXP_X,
        EXP_Y => S_EXP_Y,
        MANT_X => MANT_X,
        MANT_Y => MANT_Y,
        FLAG => FLAG
    );

    S <= S_X xor S_Y;
    EXP_X <= S_EXP_X;
    EXP_Y <= S_EXP_Y;

end RTL;