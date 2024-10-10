library ieee;
use ieee.std_logic_1164.all;

entity BIAS_SUBTRACTOR is
    generic (N : INTEGER := 10);
    port (
        exp_sum : in STD_LOGIC_VECTOR(8 downto 0);
        exp_out : out STD_LOGIC_VECTOR(9 downto 0)
    );
end entity BIAS_SUBTRACTOR;

-- Ritardo stimato di 12 ns (8,362ns exactly)

architecture RTL of BIAS_SUBTRACTOR is

    signal CS : STD_LOGIC_VECTOR(9 downto 0);
    signal CLA_result : STD_LOGIC_VECTOR(N downto 0);

    component CLA is
        generic (N : INTEGER := 10);
        port (
            X : in STD_LOGIC_VECTOR(N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR(N - 1 downto 0);
            S : out STD_LOGIC_VECTOR(N downto 0)
        );
    end component CLA;

begin

    CS <= '0' & exp_sum(8 downto 0);

    U1 : CLA
    generic map(N => 10)
    port map(
        X => CS(N - 1 downto 0),
        Y => "1110000001",
        S => CLA_result
    );

    -- Ignoriamo il MSB, come richiesto dalla somma in complemento a 2
    -- Quindi in uscita avremo il risultato in complemento a 2
    exp_out <= CLA_result(N - 1 downto 0);

end architecture RTL;