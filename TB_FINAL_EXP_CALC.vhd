LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_FINAL_EXP_CALC IS
END TB_FINAL_EXP_CALC;
 
ARCHITECTURE behavior OF TB_FINAL_EXP_CALC IS 
 
    COMPONENT FINAL_EXP_CALC
    PORT(
         EXP : IN  std_logic_vector(10 downto 0);
         OFFSET : IN  std_logic_vector(4 downto 0);
         SUB : IN  std_logic;
         S : OUT  std_logic_vector
        );
    END COMPONENT;
    

   --Inputs
   signal EXP : std_logic_vector(10 downto 0);
   signal OFFSET : std_logic_vector(4 downto 0);
   signal SUB : std_logic;

 	--Outputs
   signal S : std_logic_vector(9 downto 0);
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FINAL_EXP_CALC PORT MAP (
          EXP => EXP,
          OFFSET => OFFSET,
          SUB => SUB,
          S => S
        );

   -- Stimulus process
   process
   begin
	
      -- Expected 0000000000
      EXP <= "00000000001";
      OFFSET <= "00001";
		SUB <= '1';
      wait for 20 ns;
		
		-- Expected 0000011110
		EXP <= "00000110010";
      OFFSET <= "10100";
		SUB <= '1';
      wait for 20 ns;
      
		--Expected 0000000010
      EXP <= "00000000001";
      OFFSET <= "00001";
		SUB <= '0';
      wait for 20 ns;
		
		--Expected 
      EXP <= "00000000001";
      OFFSET <= "11111";
		SUB <= '0';
      wait;
   end process;

END;
