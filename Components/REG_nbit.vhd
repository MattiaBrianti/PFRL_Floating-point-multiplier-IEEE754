library ieee;
use ieee.std_logic_1164.all;

entity REG_Nbit is
	generic (N : INTEGER);
	port (
		CLK : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR (N - 1 downto 0);
		Q : out STD_LOGIC_VECTOR (N - 1 downto 0);
		RST : in STD_LOGIC
	);
end REG_Nbit;

architecture RTL of REG_Nbit is

	component FLIP_FLOP_D is
		port (
			CLK : in STD_LOGIC;
			D : in STD_LOGIC;
			Q : out STD_LOGIC;
			RST : in STD_LOGIC
		);
	end component;

begin

	GEN_FFD : for I in N - 1 downto 0 generate
		d_ff : FLIP_FLOP_D
		port map(
			CLK => CLK,
			D => D (I),
			Q => Q (I),
			RST => RST
		);
	end generate GEN_FFD;
end RTL;