library ieee;
use ieee.std_logic_1164.all;
entity TB_FINAL_EXP_CALC is
end TB_FINAL_EXP_CALC;

architecture behavior of TB_FINAL_EXP_CALC is

   component FINAL_EXP_CALC
      port (
         EXP : in STD_LOGIC_VECTOR(9 downto 0);
         OFFSET : in STD_LOGIC_VECTOR(4 downto 0);
         SUB : in STD_LOGIC;
         S : out STD_LOGIC_VECTOR(11 downto 0)
      );
   end component;
   --Inputs
   signal EXP : STD_LOGIC_VECTOR(9 downto 0);
   signal OFFSET : STD_LOGIC_VECTOR(4 downto 0);
   signal SUB : STD_LOGIC;

   --Outputs
   signal S : STD_LOGIC_VECTOR(11 downto 0);
begin

   -- Instantiate the Unit Under Test (UUT)
   uut : FINAL_EXP_CALC port map(
      EXP => EXP,
      OFFSET => OFFSET,
      SUB => SUB,
      S => S
   );

   -- Stimulus process
   process
   begin

      -- TODO capire perchè esce un 1 di carry e cosa vuol dire
      EXP <= "0000000001";
      OFFSET <= "00001";
      SUB <= '1';
      wait for 20 ns;

      -- Expected 0000011110
      EXP <= "0000110010";
      OFFSET <= "10100";
      SUB <= '1';
      wait for 20 ns;

      --Expected 0000000010
      EXP <= "0000000001";
      OFFSET <= "00001";
      SUB <= '0';
      wait for 20 ns;
      EXP <= "0000000001";
      OFFSET <= "11111";
      SUB <= '0';
      wait;
   end process;

end;