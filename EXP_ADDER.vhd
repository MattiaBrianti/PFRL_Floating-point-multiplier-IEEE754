-- Work in progress

library ieee;
use ieee.std_logic_1164.all;

entity EXP_ADDER is
    port (
        EXP_X : in STD_LOGIC_VECTOR (7 downto 0);
        EXP_Y : in STD_LOGIC_VECTOR (7 downto 0);
        SUM : out STD_LOGIC_VECTOR (8 downto 0);
    );

architecture RTL of EXP_ADDER is
    signal CARRY : STD_LOGIC_VECTOR (7 downto 0);
    signal SUM_TEMP : STD_LOGIC_VECTOR (8 downto 0);

    component CSA is
        generic (N : INTEGER := 8);
        port (
            X : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Z : in STD_LOGIC_VECTOR (N - 1 downto 0);
            S : out STD_LOGIC_VECTOR (N + 1 downto 0)
        );
    end component;

end EXP_ADDER;