
library ieee;
use ieee.std_logic_1164.all;

entity EXP_ADDER is
    port (
        EXP_X : in STD_LOGIC_VECTOR (7 downto 0);
        EXP_Y : in STD_LOGIC_VECTOR (7 downto 0);
        SUM : out STD_LOGIC_VECTOR (8 downto 0);
    );
end EXP_ADDER;

-- Ritardo stimato 15 ns (9,100 exactly)
architecture RTL of EXP_ADDER is
    signal EXP_X_CORRECT : STD_LOGIC_VECTOR (7 downto 0);
    signal EXP_Y_CORRECT : STD_LOGIC_VECTOR (7 downto 0);
    component CLA is
        generic (N : INTEGER := 32);
        port (
            X : in STD_LOGIC_VECTOR(N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR(N - 1 downto 0);
            S : out STD_LOGIC_VECTOR(N downto 0)
        );
    end component CLA;

begin
    EXP_X_CORRECT <= "00000001" when EXP_X = "00000000" else
        EXP_X;
    EXP_Y_CORRECT <= "00000001" when EXP_Y = "00000000" else
        EXP_Y;

    -- Instantiate the CLA component
    U1 : CLA
    generic map(N => 8)
    port map(
        X => EXP_X_CORRECT,
        Y => EXP_Y_CORRECT,
        S => SUM
    );

end RTL;