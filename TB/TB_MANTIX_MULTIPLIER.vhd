
library ieee;
use ieee.std_logic_1164.all;

entity TB_MANTIX_MULTIPLIER is
end TB_MANTIX_MULTIPLIER;

architecture behavior of TB_MANTIX_MULTIPLIER is

  -- Component Declaration for the Unit Under Test (UUT)

  component MANTIX_MULTIPLIER
    port (
      A : in STD_LOGIC_VECTOR(23 downto 0);
      B : in STD_LOGIC_VECTOR(23 downto 0);
      P : out STD_LOGIC_VECTOR(47 downto 0)
    );
  end component;
  --Inputs
  signal A : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
  signal B : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');

  --Outputs
  signal P : STD_LOGIC_VECTOR(47 downto 0);

begin

  -- Instantiate the Unit Under Test (UUT)
  uut : MANTIX_MULTIPLIER port map(
    A => A,
    B => B,
    P => P
  );

  -- Stimulus process
  process
  begin
    -- expected 001001011111101100101000100110101011110011000101
    A <= "001101111001110000011011";
    B <= "101011101101100010011111";
    wait for 100 ns;

    -- expected 011101100100101100101000000110101110101010111100
    A <= "110001101001011000111111";
    B <= "100110000111111001000100";
    wait for 100 ns;

    -- expected 010010011100100111010101010101001101100001100100
    A <= "100110101010101000011100";
    B <= "011110100010001001011111";
    wait;

  end process;

end;