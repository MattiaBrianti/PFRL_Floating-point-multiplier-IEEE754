-- Finished

library ieee;
use ieee.std_logic_1164.all;

entity MANTIX_FIXER is
    port (
        MANT_X : in STD_LOGIC_VECTOR (22 downto 0); -- 23-bit mantissa
        MANT_Y : in STD_LOGIC_VECTOR (22 downto 0); -- 23-bit mantissa
        EXP_X : in STD_LOGIC_VECTOR (7 downto 0); -- 8-bit exponent
        EXP_Y : in STD_LOGIC_VECTOR (7 downto 0); -- 8-bit exponent

        FIXED_MANT_X : out STD_LOGIC_VECTOR (23 downto 0) -- 24-bit mantissa
        FIXED_MANT_Y : out STD_LOGIC_VECTOR (23 downto 0) -- 24-bit mantissa
    );
end MANTIX_FIXER;

architecture RTL of MANTIX_FIXER is

    signal T1_X : STD_LOGIC;
    signal T1_Y : STD_LOGIC;

begin
    T1_X <= EXP_X(7) or EXP_X(6) or EXP_X(5) or EXP_X(4) or EXP_X(3) or EXP_X(2) or EXP_X(1) or EXP_X(0); -- OR operation of the 8-bit exponent
    T1_Y <= EXP_Y(7) or EXP_Y(6) or EXP_Y(5) or EXP_Y(4) or EXP_Y(3) or EXP_Y(2) or EXP_Y(1) or EXP_Y(0); -- OR operation of the 8-bit exponent 

    FIXED_MANT_X <= T1_X & MANT_X; -- Concatenation of the most significant bit of the mantissa and the mantissa itself
    FIXED_MANT_Y <= T1_Y & MANT_Y; -- Concatenation of the most significant bit of the mantissa and the mantissa itself

end RTL;