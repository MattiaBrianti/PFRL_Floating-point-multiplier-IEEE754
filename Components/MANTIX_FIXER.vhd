library ieee;
use ieee.std_logic_1164.all;

entity MANTIX_FIXER is
    port (
        MANT_X : in STD_LOGIC_VECTOR (22 downto 0);
        MANT_Y : in STD_LOGIC_VECTOR (22 downto 0);
        EXP_X : in STD_LOGIC_VECTOR (7 downto 0);
        EXP_Y : in STD_LOGIC_VECTOR (7 downto 0);

        FIXED_MANT_X : out STD_LOGIC_VECTOR (23 downto 0);
        FIXED_MANT_Y : out STD_LOGIC_VECTOR (23 downto 0)
    );
end MANTIX_FIXER;

-- Ritardo stimato 18 ns (12,804 ns exactly)

architecture RTL of MANTIX_FIXER is

    signal T1_X : STD_LOGIC;
    signal T1_Y : STD_LOGIC;

begin
    T1_X <= EXP_X(7) or EXP_X(6) or EXP_X(5) or EXP_X(4) or EXP_X(3) or EXP_X(2) or EXP_X(1) or EXP_X(0);
    T1_Y <= EXP_Y(7) or EXP_Y(6) or EXP_Y(5) or EXP_Y(4) or EXP_Y(3) or EXP_Y(2) or EXP_Y(1) or EXP_Y(0);

    FIXED_MANT_X <= T1_X & MANT_X;
    FIXED_MANT_Y <= T1_Y & MANT_Y;
end RTL;