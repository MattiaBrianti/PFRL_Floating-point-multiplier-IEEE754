library ieee;
use ieee.std_logic_1164.all;

entity FINAL_EXP_CALC is
    generic (N : INTEGER := 24);
    port (
        EXP : in STD_LOGIC_VECTOR(9 downto 0); -- è un numero con segno
        OFFSET : in STD_LOGIC_VECTOR(4 downto 0);
        SUB : in STD_LOGIC;
        S : out STD_LOGIC_VECTOR(9 downto 0)
    );
end entity FINAL_EXP_CALC;

architecture RTL of FINAL_EXP_CALC is

    signal PADDED_OFFSET_ADD : STD_LOGIC_VECTOR(9 downto 0);
    signal PADDED_OFFSET_SUB : STD_LOGIC_VECTOR(9 downto 0);
    signal S_1 : STD_LOGIC_VECTOR(11 downto 0);
    signal S_2 : STD_LOGIC_VECTOR(11 downto 0);

    component CSA is

        generic (N : INTEGER := 10);

        port (
            X : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Z : in STD_LOGIC_VECTOR (N - 1 downto 0);
            S : out STD_LOGIC_VECTOR (N + 1 downto 0)
        );
    end component CSA;

begin
    PADDED_OFFSET_ADD <= "00000" & OFFSET;
    PADDED_OFFSET_SUB <= not PADDED_OFFSET_ADD;

    CSA_SUB : CSA
    generic map(N => 10)
    port map(
        X => EXP,
        Y => PADDED_OFFSET_SUB,
        Z => "0000000001",
        S => S_1
    );
    CSA_ADD : CSA
    generic map(N => 10)
    port map(
        X => EXP,
        Y => PADDED_OFFSET_ADD,
        Z => "0000000000",
        S => S_2
    );

    S <= (S_1(9 downto 0)) when SUB = '1' else
        (S_2(9 downto 0));
end architecture RTL;