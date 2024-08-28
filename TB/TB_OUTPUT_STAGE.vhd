
library ieee;
use ieee.std_logic_1164.all;

entity TB_OUTPUT_STAGE is
end TB_OUTPUT_STAGE;

architecture behavior of TB_OUTPUT_STAGE is

  -- Component Declaration for the Unit Under Test (UUT)

  component OUTPUT_STAGE
    port (
      FLAG : in STD_LOGIC_VECTOR(1 downto 0);
      S : in STD_LOGIC;
      exp_out : in STD_LOGIC_VECTOR(9 downto 0);
      P : in STD_LOGIC_VECTOR(47 downto 0);
      RES_FINAL : out STD_LOGIC_VECTOR(31 downto 0);
      INVALID : out STD_LOGIC
    );
  end component;
  --Inputs
  signal FLAG : STD_LOGIC_VECTOR(1 downto 0);
  signal S : STD_LOGIC;
  signal exp_out : STD_LOGIC_VECTOR(9 downto 0);
  signal P : STD_LOGIC_VECTOR(47 downto 0);

  --Outputs
  signal RES_FINAL : STD_LOGIC_VECTOR(31 downto 0);
  signal INVALID : STD_LOGIC;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut : OUTPUT_STAGE port map(
    FLAG => FLAG,
    S => S,
    exp_out => exp_out,
    P => P,
    RES_FINAL => RES_FINAL,
    INVALID => INVALID
  );

  -- Stimulus process
  process
  begin

    FLAG <= "00";
    S <= '1';
    exp_out <= "1100001010";
    P <= "110010001000011001000110010000101000000011101010";
    wait;

  end process;

end;