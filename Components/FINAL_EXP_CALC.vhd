library ieee;
use ieee.std_logic_1164.all;

entity FINAL_EXP_CALC is
    port (
        EXP : in STD_LOGIC_VECTOR(9 downto 0); -- è un numero con segno
        OFFSET : in STD_LOGIC_VECTOR(4 downto 0); -- in uscita da rounder
        SUB : in STD_LOGIC;
        S : out STD_LOGIC_VECTOR(9 downto 0) -- in uscita avremo l' esponente che in alcuni casi verrà modificato da RES_FIX
    );
end entity FINAL_EXP_CALC;


architecture RTL of FINAL_EXP_CALC is
    
    component CLA_10 is
    port (
    X, Y : in  std_logic_vector(9 downto 0);
    S    : out std_logic_vector(9 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
  end component CLA_10;

    signal S_OUT : std_logic_vector(9 downto 0);
	 signal PADDED_OFFSET: std_logic_vector(9 downto 0);
	 signal EXTENDED_SUB: std_logic_vector(9 downto 0);
	 signal FINAL_OFFSET: std_logic_vector(9 downto 0);
	 signal SUB_SIG: std_logic;

begin
    PADDED_OFFSET <= "00000" & OFFSET; --Paddiamo l'offset per arrivare a 10bit
	 EXTENDED_SUB <= (others => SUB); --Creiamo un vettore fatto da tutti i bit uguali a sub
	 FINAL_OFFSET <= EXTENDED_SUB xor PADDED_OFFSET; -- se SUB è 1 lo xor mi complementa ad uno l'OFFSET, se è 0 lo lascia al valore originale
	 SUB_SIG <= SUB;

	process(S_OUT)
	begin
		S <= S_OUT;
	end process;
	
    CLA_ADD : CLA_10
    port map(
        X => EXP,
        Y => FINAL_OFFSET,
        Cin => SUB_SIG,
        S => S_OUT,
        Cout => open
    );
end architecture RTL;