library ieee;
use ieee.std_logic_1164.all;

entity FINAL_EXP_CALC is
    generic (N : integer := 24);
    port (
        EXP : in  std_logic_vector(9 downto 0);
        OFFSET : in  std_logic_vector(4 downto 0);
        SUB : in std_logic;
        S   : out std_logic_vector
    );
    end entity FINAL_EXP_CALC;

    architecture RTL of FINAL_EXP_CALC is 
 
    signal PADDED_OFFSET_ADD : std_logic_vector(10 downto 0);
	 signal PADDED_OFFSET_SUB : std_logic_vector(10 downto 0);
    signal S_1 : std_logic_vector(12 downto 0);
    signal S_2 : std_logic_vector(12 downto 0);
	 
	 component CSA is

      generic (N : INTEGER := 11);

      port (
            X : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Z : in STD_LOGIC_VECTOR (N - 1 downto 0);
            S : out STD_LOGIC_VECTOR (N+1 downto 0)
      );
end component CSA;

    begin 
        PADDED_OFFSET_ADD <= "000000" & OFFSET;
		  PADDED_OFFSET_SUB <= not PADDED_OFFSET_ADD;
		  
        CSA_SUB : CSA
            generic map(N => 11)
            port map(
				 X => X,
             Y => PADDED_OFFSET_SUB, 
				 Z => "00000000001",
             S =>  S_1
             );
				 
        CSA_ADD : CSA
             generic map(N => 11)
             port map(
				  X => X,
              Y => PADDED_OFFSET_ADD,
              Z => "00000000000",			  
              S => S_2
              );
				  
        S <= '0' & S_1 when SUB = '1' else '0' & S_2;
    
       
    end architecture RTL;
