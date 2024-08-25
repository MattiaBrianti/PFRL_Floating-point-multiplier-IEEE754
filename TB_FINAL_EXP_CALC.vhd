
library ieee;
use ieee.std_logic_1164.all;

entity TB_FINAL_EXP_CALC is
end TB_FINAL_EXP_CALC;

architecture behavior of TB_FINAL_EXP_CALC is

   -- Component Declaration for the Unit Under Test (UUT)

   component FINAL_EXP_CALC
      port (
         EXP : in STD_LOGIC_VECTOR(9 downto 0);
         OFFSET : in STD_LOGIC_VECTOR(4 downto 0);
         SUB : in STD_LOGIC;
         S : out STD_LOGIC_VECTOR(9 downto 0)
      );
   end component;
   --Inputs
   signal EXP : STD_LOGIC_VECTOR(9 downto 0);
   signal OFFSET : STD_LOGIC_VECTOR(4 downto 0);
   signal SUB : STD_LOGIC;

   --Outputs
   signal S : STD_LOGIC_VECTOR(9 downto 0);

begin

   -- Instantiate the Unit Under Test (UUT)
   uut : FINAL_EXP_CALC port map(
      EXP => EXP,
      OFFSET => OFFSET,
      SUB => SUB,
      S => S
   );

   process
   begin

      -- CASO POSITIVO - POSITIVO = POSITIVO
      -- expected 01000(10-2=8)
      EXP <= "0000001010";
      OFFSET <= "00010";
      SUB <= '1';
      wait for 20 ns;

      -- CASO POSITIVO - POSITIVO = NEGATIVO
      -- expected 1011(10-15=-5)
      EXP <= "0000001010";
      OFFSET <= "01111";
      SUB <= '1';
      wait for 20 ns;

      -- CASO NEGATIVO - POSITIVO = NEGATIVO
      -- expected 1011101(-20-15=-35)
      EXP <= "1111101100";
      OFFSET <= "01111";
      SUB <= '1';
      wait for 20 ns;

      -- CASO POSITIVO + POSITIVO = POSITIVO
      -- expected 010100(5+15=20)
      EXP <= "0000000101";
      OFFSET <= "01111";
      SUB <= '0';
      wait for 20 ns;

      -- CASO NEGATIVO + POSITIVO = POSITIVO
      -- expected 0101(-10+15=5)
      EXP <= "1111110110";
      OFFSET <= "01111";
      SUB <= '0';
      wait for 20 ns;

      -- CASO NEGATIVO + POSITIVO = NEGATIVO
      -- expected 1011(-20+15=-5)
      EXP <= "1111101100";
      OFFSET <= "01111";
      SUB <= '0';
      wait;

   end process;

end;