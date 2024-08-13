library ieee;
use ieee.std_logic_1164.all;

entity REGISTER is
    generic( N : integer);
    
    port(
        CLK : in std_logic;
        RST : in std_logic;
        X: in std_logic_vector (0 to N-1);
        Y: out std_logic_vector (0 to N-1);
    );
end REGISTER;

architecture rtl of REGISTER is
    begin 
        reg: process(CLK, RST)
        begin 
            reg: process(CLK, RST)
            begin
                if RST = '1' then
                    Y <= (others => '0');
                elsif (CLK' event and CLK ='1') then
                    Y <= X;
                end if;
            end process;
        end rtl;