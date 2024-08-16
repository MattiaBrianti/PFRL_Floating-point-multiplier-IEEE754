library ieee;
use ieee.std_logic_1164.all;

entity FLIP_FLOP_D is
	port( 
	CLK :  in   std_logic;
	D 	 :  in   std_logic;
	Q	 :  out  std_logic;
	RESET: in   std_logic
);
end FLIP_FLOP_D;

architecture FLIP_FLOP_D of FLIP_FLOP_D is
begin
	FF: process( CLK, RESET )
		begin
			if( RESET = '1' ) then
			Q <= '0';
		else 
			if( CLK'event and CLK = '1' ) then
				Q <= D;
		end if;
	end if;
end process;
end FLIP_FLOP_D;