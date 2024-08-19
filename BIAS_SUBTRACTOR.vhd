library ieee;
use ieee.std_logic_1164.all;

entity BIAS_SUBTRACTOR is
    port (
        exp_sum : in STD_LOGIC_VECTOR(8 downto 0);
        exp_out : out STD_LOGIC_VECTOR(9 downto 0)
    );
end entity BIAS_SUBTRACTOR;

architecture RTL of BIAS_SUBTRACTOR is
    component CSA is

        generic (N : INTEGER := 32);
        port (
            X : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Z : in STD_LOGIC_VECTOR (N - 1 downto 0);
            S : out STD_LOGIC_VECTOR (N + 1 downto 0)
        );
    end component CSA;

begin
    U1 : CSA
    generic map(N => 9)
    port map(
        X => exp_sum(N - 1 downto 0),
        Y => "10000001",
        Z => "00000000",
        S => exp_out(N downto 0)
    );
end architecture RTL;

-- Non funziona il test
-- Capire a cosa serve il MSB, usato dopo per il segno (?)