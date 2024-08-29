library ieee;
use ieee.std_logic_1164.all;

entity FLIP_FLOP_D is
	port (
		CLK : in STD_LOGIC;
		D : in STD_LOGIC;
		Q : out STD_LOGIC;
		RST : in STD_LOGIC
	);
end FLIP_FLOP_D;

architecture RTL of FLIP_FLOP_D is
begin
	FF : process (CLK)
	begin
		if (RST = '1') then
			Q <= '0';
		else
			if (CLK'event and CLK = '1') then
				Q <= D;
			end if;
		end if;
	end process;
end RTL;