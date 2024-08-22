LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TB_CSA IS
END TB_CSA;
 
ARCHITECTURE behavior OF TB_CSA IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CSA
    PORT(
	         X : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Z : in STD_LOGIC_VECTOR (N - 1 downto 0);
            S : out STD_LOGIC_VECTOR (N downto 0)
        );
    END COMPONENT;
	 --inputs
	         signal X : STD_LOGIC_VECTOR (N - 1 downto 0);
            signal Y : STD_LOGIC_VECTOR (N - 1 downto 0);
            signal Z : STD_LOGIC_VECTOR (N - 1 downto 0);
	--outputs
	         signal S: STD_LOGIC_VECTOR(N downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CSA PORT MAP (
	X => X;
	Y=> Y;
	Z=> Z;
	S=> S;
        );

   
   process
   begin		
       X <= "000000000000000000000000000000000000000000000000";
    Y <= "000000000000000000000000000000000000000000000001";
    Z <= "000000000000000000000000000000000000000000000001";
    wait for 20 ns;

    X <= "000000000000000000000000000000000000000000000000";
    Y <= "000000000000000000000000000000000000000000000000";
    Z <= "000000000000000000000000000000000000000000000001";
    wait for 20 ns;

    X <= "000010000010000000000001000000000000000000010000";
    Y <= "100000000000000000000000000000000000000000010000";
    Z <= "100000100000000000000000000000000000000000000001";
    wait for 20 ns;
END;
