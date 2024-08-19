library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplier is
    generic (
        N : positive := 23
    );
    port (
        A, B : in  std_logic_vector(N-1 downto 0);
        P    : out std_logic_vector(2*(N-1) downto 0)
    );
end entity Multiplier;

architecture RTL of Multiplier is
    component CSA is
        generic (
            N : positive
        );
        port (
            A, B, C : in  std_logic_vector(N-1 downto 0);
            S       : out std_logic_vector(N downto 0);
            Cout    : out std_logic
        );
    end component CSA;

    signal S : std_logic_vector(N downto 0);
    signal Cout : std_logic;
begin
    CSA_inst : CSA
        generic map (N => N)
        port map (
            A => A,
            B => B,
            C => S(0),
            S => S,
            Cout => Cout
        );

    process(S(N-1 downto 0), Cout)
    begin
        P <= S(N-1 downto 0) & Cout;
    end process;
end architecture RTL;
