
library ieee;
use ieee.std_logic_1164.all;

entity ROUND is
    port (
        MANT_EXT : in STD_LOGIC_VECTOR (47 downto 0);
        MANT_SHIFT : out STD_LOGIC_VECTOR (22 downto 0);
        OFFSET : out STD_LOGIC_VECTOR (4 downto 0);
        SUB : out STD_LOGIC
    );
end ROUND;

architecture RTL of ROUND is
begin

    SUB <= '0' when (MANT_EXT(47) = '1') or
        (MANT_EXT(46) = '1') else
        '1';

    OFFSET <= "00001" when (MANT_EXT(47) = '1') else
        "00000" when (MANT_EXT(46) = '1') else
        "00001" when (MANT_EXT(45) = '1') else
        "00010" when (MANT_EXT(44) = '1') else
        "00011" when (MANT_EXT(43) = '1') else
        "00100" when (MANT_EXT(42) = '1') else
        "00101" when (MANT_EXT(41) = '1') else
        "00110" when (MANT_EXT(40) = '1') else
        "00111" when (MANT_EXT(39) = '1') else
        "01000" when (MANT_EXT(38) = '1') else
        "01001" when (MANT_EXT(37) = '1') else
        "01010" when (MANT_EXT(36) = '1') else
        "01011" when (MANT_EXT(35) = '1') else
        "01100" when (MANT_EXT(34) = '1') else
        "01101" when (MANT_EXT(33) = '1') else
        "01110" when (MANT_EXT(32) = '1') else
        "01111" when (MANT_EXT(31) = '1') else
        "10000" when (MANT_EXT(30) = '1') else
        "10001" when (MANT_EXT(29) = '1') else
        "10010" when (MANT_EXT(28) = '1') else
        "10011" when (MANT_EXT(27) = '1') else
        "10100" when (MANT_EXT(26) = '1') else
        "10101" when (MANT_EXT(25) = '1') else
        "10110" when (MANT_EXT(24) = '1') else
        "10111" when (MANT_EXT(23) = '1') else
        "11111";

    MANT_SHIFT <= MANT_EXT(46 downto 24) when (MANT_EXT(47) = '1') else
        MANT_EXT(45 downto 23) when (MANT_EXT(46) = '1') else
        MANT_EXT(44 downto 22) when (MANT_EXT(45) = '1') else
        MANT_EXT(43 downto 21) when (MANT_EXT(44) = '1') else
        MANT_EXT(42 downto 20) when (MANT_EXT(43) = '1') else
        MANT_EXT(41 downto 19) when (MANT_EXT(42) = '1') else
        MANT_EXT(40 downto 18) when (MANT_EXT(41) = '1') else
        MANT_EXT(39 downto 17) when (MANT_EXT(40) = '1') else
        MANT_EXT(38 downto 16) when (MANT_EXT(39) = '1') else
        MANT_EXT(37 downto 15) when (MANT_EXT(38) = '1') else
        MANT_EXT(36 downto 14) when (MANT_EXT(37) = '1') else
        MANT_EXT(35 downto 13) when (MANT_EXT(36) = '1') else
        MANT_EXT(34 downto 12) when (MANT_EXT(35) = '1') else
        MANT_EXT(33 downto 11) when (MANT_EXT(34) = '1') else
        MANT_EXT(32 downto 10) when (MANT_EXT(33) = '1') else
        MANT_EXT(31 downto 9) when (MANT_EXT(32) = '1') else
        MANT_EXT(30 downto 8) when (MANT_EXT(31) = '1') else
        MANT_EXT(29 downto 7) when (MANT_EXT(30) = '1') else
        MANT_EXT(28 downto 6) when (MANT_EXT(29) = '1') else
        MANT_EXT(27 downto 5) when (MANT_EXT(28) = '1') else
        MANT_EXT(26 downto 4) when (MANT_EXT(27) = '1') else
        MANT_EXT(25 downto 3) when (MANT_EXT(26) = '1') else
        MANT_EXT(24 downto 2) when (MANT_EXT(25) = '1') else
        MANT_EXT(23 downto 1) when (MANT_EXT(24) = '1') else
        MANT_EXT(22 downto 0);
end RTL;