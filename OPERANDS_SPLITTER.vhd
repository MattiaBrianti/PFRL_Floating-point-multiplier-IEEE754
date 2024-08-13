library ieee;
use ieee.std_logic_1164.all;

entity OPERANDS_SPLITTER is
    
    port(
        X	    : in  std_logic_vector (31 downto 0);
        Y       : in  std_logic_vector (31 downto 0);
        S_X     : out std_logic;
        S_Y     : out std_logic;
        EXP_X   : out std_logic_vector (7 downto 0);
        EXP_Y   : out std_logic_vector (7 downto 0);
        MANT_X  : out std_logic_vector (22 downto 0);
        MANT_Y  : out std_logic_vector (22 downto 0);
    );
end OPERANDS_SPLITTER;

architecture RTL of OPERANDS_SPLITTER is
    begin
        S_X <= X(31);
        S_Y <= Y(31);
        EXP_X <= X(30 downto 23);
        EXP_Y <= Y(30 downto 23);
        MANT_X <= X(22 downto 0);
        MANT_Y <= Y(22 downto 0);
end RTL;