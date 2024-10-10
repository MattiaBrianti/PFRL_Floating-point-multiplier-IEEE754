library ieee;
use ieee.std_logic_1164.all;

entity CALC_STAGE is
    port (
        FLAG : in STD_LOGIC_VECTOR (1 downto 0);
        S : in STD_LOGIC;
        EXP_X : in STD_LOGIC_VECTOR (7 downto 0);
        EXP_Y : in STD_LOGIC_VECTOR (7 downto 0);
        FIXED_MANT_X : in STD_LOGIC_VECTOR (23 downto 0);
        FIXED_MANT_Y : in STD_LOGIC_VECTOR (23 downto 0);
        S_OUT : out STD_LOGIC;
        FLAG_OUT : out STD_LOGIC_VECTOR (1 downto 0);
        P : out STD_LOGIC_VECTOR(47 downto 0);
        exp_out : out STD_LOGIC_VECTOR(9 downto 0)
    );
end entity CALC_STAGE;

architecture RTL of CALC_STAGE is

    signal exp_sum : STD_LOGIC_VECTOR(8 downto 0);

    component EXP_ADDER is
        port (
            EXP_X : in STD_LOGIC_VECTOR (7 downto 0);
            EXP_Y : in STD_LOGIC_VECTOR (7 downto 0);
            SUM : out STD_LOGIC_VECTOR (8 downto 0)
        );
    end component;

    component MANTIX_MULTIPLIER is
        generic (
            N : POSITIVE := 24
        );
        port (
            A, B : in STD_LOGIC_VECTOR(N - 1 downto 0);
            P : out STD_LOGIC_VECTOR(2 * N - 1 downto 0)
        );
    end component;

    component BIAS_SUBTRACTOR is
        generic (N : INTEGER := 10);
        port (
            exp_sum : in STD_LOGIC_VECTOR(8 downto 0);
            exp_out : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;

begin

    U1 : EXP_ADDER
    port map(
        EXP_X => EXP_X,
        EXP_Y => EXP_Y,
        SUM => exp_sum
    );

    U2 : MANTIX_MULTIPLIER
    generic map(N => 24)
    port map(
        A => FIXED_MANT_X,
        B => FIXED_MANT_Y,
        P => P
    );

    U3 : BIAS_SUBTRACTOR
    generic map(N => 10)
    port map(
        exp_sum => exp_sum,
        exp_out => exp_out
    );

    S_OUT <= S;
    FLAG_OUT <= FLAG;

end architecture RTL;