library ieee;
use ieee.std_logic_1164.all;

entity BIAS_SUBTRACTOR is
    port (
        exp_sum : in STD_LOGIC_VECTOR(8 downto 0);
        exp_out : out STD_LOGIC_VECTOR(9 downto 0)
    );
end entity BIAS_SUBTRACTOR;

architecture RTL of BIAS_SUBTRACTOR is

    signal CS : STD_LOGIC_VECTOR(9 downto 0);

    component CLA_10 is
	port (
    X, Y : in  std_logic_vector(9 downto 0);
    S    : out std_logic_vector(9 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
end component;

begin
    -- Concateniamo uno zero per avere la somma di 2 numeri da 10 bit
    -- Lo 0 non avrà conseguenza poichè EXP_SUM è un numero unsigned
    CS <= '0' & exp_sum(8 downto 0);

    -- Effettuiamo la differenza tra EXP_SUM e 127
    -- Ci restituisce l'esponente signed
    Adder : CLA_10
    port map(
        X => CS(9 downto 0),
        Y => "1110000001",
		CIN => '0',
        S => exp_out,
		COUT => open
    );

end architecture RTL;