library ieee;
use ieee.std_logic_1164.all;

entity CLA is
    generic (
        N : INTEGER := 32
    );
    port (
        A : in std_logic_vector(N-1 downto 0);
        B : in std_logic_vector(N-1 downto 0)
        Cin : in std_logic;
        Sum : out std_logic_vector(N-1 downto 0);
        Cout : out std_logic
    );
end entity CLA;

architecture RTL of CLA is
    signal P, G : std_logic_vector(N-1 downto 0);
    signal C : std_logic_vector(N downto 0);
begin
    P(0) <= A(0) xor B(0);
    G(0) <= A(0) and B(0);
    C(0) <= Cin;

    generate_carry : for i in 1 to N-1 generate
        P(i) <= A(i) xor B(i);
        G(i) <= A(i) and B(i);
        C(i) <= P(i-1) or (G(i-1) and C(i-1));
    end generate generate_carry;

    Sum <= A xor B xor C(N-1 downto 0);
    Cout <= G(N-1) or (P(N-1) and C(N-1));
end architecture RTL;