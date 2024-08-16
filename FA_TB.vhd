
library ieee;
use ieee.std_logic_1164.all;
entity TB_FA is
end TB_FA;

architecture behavior of TB_FA is

  -- Component Declaration for the Unit Under Test (UUT)

  component FA
    port (
      X : in STD_LOGIC;
      Y : in STD_LOGIC;
      CIN : in STD_LOGIC;
      S : out STD_LOGIC;
      COUT : out STD_LOGIC
    );
  end component;
  --Inputs
  signal X : STD_LOGIC;
  signal Y : STD_LOGIC;
  signal CIN : STD_LOGIC;

  --Outputs
  signal S : STD_LOGIC;
  signal COUT : STD_LOGIC;
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : FA port map(
    X => X,
    Y => Y,
    CIN => CIN,
    S => S,
    COUT => COUT
  );

  -- Stimulus process
  process
  begin
    X <= '0';
    Y <= '0';
    CIN <= '0';
    wait for 20 ns;

    X <= '1';
    Y <= '0';
    CIN <= '0';
    wait for 20 ns;

    X <= '1';
    Y <= '1';
    CIN <= '0';
    wait for 20 ns;

    X <= '1';
    Y <= '1';
    CIN <= '1';
    wait for 20 ns;

    X <= '1';
    Y <= '0';
    CIN <= '1';
    wait;

  end process;
end;