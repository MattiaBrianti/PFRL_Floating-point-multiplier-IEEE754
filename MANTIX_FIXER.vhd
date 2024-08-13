
library ieee;
use ieee.std_logic_1164.all;

entity MANTIX_FIXER is
    port(
        MANT_X    : in  std_logic_vector (22 downto 0); -- 23-bit mantissa
        FIXED_MANT_X: out std_logic_vector (23 downto 0)  -- 24-bit mantissa
        MANT_Y    : in  std_logic_vector (22 downto 0); -- 23-bit mantissa
        FIXED_MANT_Y: out std_logic_vector (23 downto 0)  -- 24-bit mantissa
    );
end MANTIX_FIXER;

architecture RTL of MANTIX_FIXER is

    signal T1_X : std_logic;
    signal T1_Y : std_logic;

begin
    T1_X <= MANT_X(22) or MANT_X(21) or MANT_X(20) or MANT_X(19) or MANT_X(18) or MANT_X(17) or MANT_X(16) or MANT_X(15) or MANT_X(14) or MANT_X(13) or MANT_X(12) or MANT_X(11) or MANT_X(10) or MANT_X(9) or MANT_X(8) or MANT_X(7) or MANT_X(6) or MANT_X(5) or MANT_X(4) or MANT_X(3) or MANT_X(2) or MANT_X(1) or MANT_X(0);
    T1_Y <= MANT_Y(22) or MANT_Y(21) or MANT_Y(20) or MANT_Y(19) or MANT_Y(18) or MANT_Y(17) or MANT_Y(16) or MANT_Y(15) or MANT_Y(14) or MANT_Y(13) or MANT_Y(12) or MANT_Y(11) or MANT_Y(10) or MANT_Y(9) or MANT_Y(8) or MANT_Y(7) or MANT_Y(6) or MANT_Y(5) or MANT_Y(4) or MANT_Y(3) or MANT_Y(2) or MANT_Y(1) or MANT_Y(0);
    
    FIXED_MANT_X <= T1_X & MANT_X; -- Concatenation of the most significant bit of the mantissa and the mantissa itself
    FIXED_MANT_Y <= T1_Y & MANT_Y; -- Concatenation of the most significant bit of the mantissa and the mantissa itself

end RTL;