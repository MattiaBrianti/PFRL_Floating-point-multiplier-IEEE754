library ieee;
use ieee.std_logic_1164.all;

entity EXP_ADDER is
    port (
        EXP_X : in STD_LOGIC_VECTOR (7 downto 0);
        EXP_Y : in STD_LOGIC_VECTOR (7 downto 0);
        SUM : out STD_LOGIC_VECTOR (8 downto 0)
    );
end EXP_ADDER;

architecture RTL of EXP_ADDER is
    signal EXP_X_CORRECT : STD_LOGIC_VECTOR (7 downto 0);
    signal EXP_Y_CORRECT : STD_LOGIC_VECTOR (7 downto 0);
	signal COUT_TEMP: std_logic;
	signal TEMP_SUM: std_logic_vector(7 downto 0);
    component CLA_8 is
        port (
            X : in STD_LOGIC_VECTOR(7 downto 0);
            Y : in STD_LOGIC_VECTOR(7 downto 0);
			CIN: in STD_LOGIC;
            S : out STD_LOGIC_VECTOR(7 downto 0);
			COUT: out std_logic
        );
    end component CLA_8;

begin
    -- Correggiamo l'esponente se in ingresso abbiamo numeri denormalizzati
    EXP_X_CORRECT <= "00000001" when EXP_X = "00000000" else
        EXP_X;
    EXP_Y_CORRECT <= "00000001" when EXP_Y = "00000000" else
        EXP_Y;
    
    -- Si effettua la somma degli esponenti corretti
    Adder : CLA_8
    port map(
        X => EXP_X_CORRECT,
        Y => EXP_Y_CORRECT,
        S => TEMP_SUM,
		CIN => '0',
		COUT => COUT_TEMP
    );
	 
	 -- Concatenazione del risultato
	 process (TEMP_SUM, COUT_TEMP)
	 begin
		SUM(7 downto 0) <= TEMP_SUM;
		SUM(8) <= COUT_TEMP;
		end process;
end RTL;