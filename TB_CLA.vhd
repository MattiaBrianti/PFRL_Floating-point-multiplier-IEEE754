library ieee;
use ieee.std_logic_1164.all;

entity TB_CLA is
end TB_CLA;

architecture behavior of TB_CLA is

  -- Component Declaration for the Unit Under Test (UUT)

  component CLA
    port (
      X : in STD_LOGIC_VECTOR(31 downto 0);
      Y : in STD_LOGIC_VECTOR(31 downto 0);
      S : out STD_LOGIC_VECTOR(32 downto 0)
    );
  end component;
  --Inputs
  signal X : STD_LOGIC_VECTOR(31 downto 0);
  signal Y : STD_LOGIC_VECTOR(31 downto 0);

  --Outputs
  signal S : STD_LOGIC_VECTOR(32 downto 0);

begin

  -- Instantiate the Unit Under Test (UUT)
  uut : CLA port map(
    X => X,
    Y => Y,
    S => S
  );
  -- Stimulus process
  process
  begin

    X <= "10101011100010101111001000101110";
    Y <= "10101101100001101100011010110110";
    wait for 20 ns;

    X <= "10011111001010011000000101011001";
    Y <= "10001110110010101100000000101011";
    wait;

  end process;

end;