library ieee;
use ieee.std_logic_1164.all;

entity RES_FIX is
    port (
        EXP_IN : in STD_LOGIC_VECTOR(7 downto 0);
        MANT_IN : in STD_LOGIC_VECTOR(22 downto 0);
        EXP_OUT : out STD_LOGIC_VECTOR(7 downto 0);
        MANT_OUT : out STD_LOGIC_VECTOR(22 downto 0);
    );
end entity RES_FIX;

architecture RTL of RES_FIX is