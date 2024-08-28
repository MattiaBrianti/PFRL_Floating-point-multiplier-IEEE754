
library ieee;
use ieee.std_logic_1164.all;

entity TB_EXP_ADDER is
end TB_EXP_ADDER;

architecture behavior of TB_EXP_ADDER is

   -- Component Declaration for the Unit Under Test (UUT)

   component EXP_ADDER
      port (
         EXP_X : in STD_LOGIC_VECTOR(7 downto 0);
         EXP_Y : in STD_LOGIC_VECTOR(7 downto 0);
         SUM : out STD_LOGIC_VECTOR(8 downto 0)
      );
   end component;
   --Inputs
   signal EXP_X : STD_LOGIC_VECTOR(7 downto 0);
   signal EXP_Y : STD_LOGIC_VECTOR(7 downto 0);

   --Outputs
   signal SUM : STD_LOGIC_VECTOR(8 downto 0);

begin

   -- Instantiate the Unit Under Test (UUT)
   uut : EXP_ADDER port map(
      EXP_X => EXP_X,
      EXP_Y => EXP_Y,
      SUM => SUM
   );

   -- Stimulus process
   process
   begin
      -- Expected (001100101) first Denorm
      EXP_X <= "00000000";
      EXP_Y <= "01100100";
      wait for 20 ns;

      -- Expected (001100101) second Denorm
      EXP_X <= "01100100";
      EXP_Y <= "00000000";
      wait for 20 ns;

      -- Expected (000000010) both denorm
      EXP_X <= "00000000";
      EXP_Y <= "00000000";
      wait for 20 ns;

      -- Expected (101110110) both norm
      EXP_X <= "11000110";
      EXP_Y <= "10110000";
      wait;
   end process;

end;