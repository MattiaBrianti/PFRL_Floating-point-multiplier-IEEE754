library ieee;
use ieee.std_logic_1164.all;

entity REG_1bit is
	port (
		CLK : in STD_LOGIC;
		D : in STD_LOGIC;
		Q : out STD_LOGIC;
		RST : in STD_LOGIC
	);
end REG_1bit;

architecture RTL of REG_1bit is

	component FLIP_FLOP_D is
		port (
			CLK : in STD_LOGIC;
			D : in STD_LOGIC;
			Q : out STD_LOGIC;
			RST : in STD_LOGIC
		);
	end component;

begin
	d_ff : FLIP_FLOP_D
	port map(
		CLK => CLK,
		D => D,
		Q => Q,
		RST => RST
	);
end RTL;