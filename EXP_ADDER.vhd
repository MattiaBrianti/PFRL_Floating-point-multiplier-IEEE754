library ieee;
use ieee.std_logic_1164.all;

entity EXP_ADDER is
    port(
        EXP_X   : in  std_logic_vector (7 downto 0);
        EXP_Y   : in  std_logic_vector (7 downto 0);
        SUM  : out std_logic_vector (7 downto 0);
    );
end EXP_ADDER;