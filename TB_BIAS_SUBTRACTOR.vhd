
library ieee;
use ieee.std_logic_1164.all;
entity TB_BIAS_SUBTRACTOR is
end TB_BIAS_SUBTRACTOR;

architecture behavior of TB_BIAS_SUBTRACTOR is

  -- Component Declaration for the Unit Under Test (UUT)

  component BIAS_SUBTRACTOR
    port (
      exp_sum : in STD_LOGIC_VECTOR(8 downto 0);
      exp_out : out STD_LOGIC_VECTOR(9 downto 0)
    );
  end component;
  --Inputs
  signal exp_sum : STD_LOGIC_VECTOR(8 downto 0);

  --Outputs
  signal exp_out : STD_LOGIC_VECTOR(9 downto 0);

begin

  -- Instantiate the Unit Under Test (UUT)
  uut : BIAS_SUBTRACTOR port map(
    exp_sum => exp_sum,
    exp_out => exp_out
  );
  -- Stimulus process
  process
  begin
    -- 240 - 127 = 113 (0001110001)
    exp_sum <= "011110000";
    wait for 20 ns;

    -- 175 - 127 = 48 (0000110000)
    exp_sum <= "010101111";
    wait for 20 ns;

    -- 9 - 127 = -118 (1110001010)
    exp_sum <= "000001001";
    wait;
  end process;

end;