-- Finished

library ieee;
use ieee.std_logic_1164.all;

entity register is
	generic (N : INTEGER := 32);
	port (
		CLK : in STD_LOGIC;
		D : in STD_LOGIC_VECTOR (N - 1 downto 0);
		Q : out STD_LOGIC_VECTOR (N - 1 downto 0);
		RESET : in STD_LOGIC
	);

end register;

architecture register of register is

	component D_FLIP_FLOP is
		port (
			CLK : in STD_LOGIC;
			D : in STD_LOGIC;
			Q : out STD_LOGIC;
			RESET : in STD_LOGIC
		);
	end component;

begin

	gen_flipflop : for I in N - 1 downto 0 generate
		d_ff : D_FLIP_FLOP
		port map(
			CLK => CLK,
			D => D (I),
			Q => Q (I),
			RESET => RESET
		);
	end generate gen_flipflop;
end register;