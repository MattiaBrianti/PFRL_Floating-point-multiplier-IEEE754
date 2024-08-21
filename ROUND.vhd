
library ieee;
use ieee.std_logic_1164.all;

entity ROUND is
    generic (N : INTEGER := 24); --Non so quanto sarà l'OFFSET (al MAX 24)
    port (
        MANT_EXT : in STD_LOGIC_VECTOR (47 downto 0);
        MANT_SHIFT : out STD_LOGIC_VECTOR (22 downto 0);
        OFFSET : out STD_LOGIC_VECTOR (N - 1 downto 0);
        SUB : out STD_LOGIC;
    );
end ROUND;

architecture RTL of ROUND is
begin

    SUB <= '0' when (MANT_EXT(47) = '1') or
        (MANT_EXT(46) = '1') else
        '1';

    OFFSET <=

        MANT_SHIFT
    end RTL;