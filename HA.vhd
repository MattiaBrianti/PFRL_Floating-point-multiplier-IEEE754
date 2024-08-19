-- Finished and tested

library ieee;
use ieee.std_logic_1164.all;

entity HA is
	port (
		X : in STD_LOGIC;
		CIN : in STD_LOGIC;
		S : out STD_LOGIC;
		COUT : out STD_LOGIC
	);
end HA;

architecture RTL of HA is
begin

	S <= X xor CIN;
	COUT <= X and CIN;

end RTL;