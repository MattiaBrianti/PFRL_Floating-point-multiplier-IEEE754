-- Work in progress

library ieee;
use ieee.std_logic_1164.all;

entity EXP_ADDER is
    port (
        EXP_X : in STD_LOGIC_VECTOR (7 downto 0);
        EXP_Y : in STD_LOGIC_VECTOR (7 downto 0);
        SUM : out STD_LOGIC_VECTOR (8 downto 0);
    );

    

end EXP_ADDER;