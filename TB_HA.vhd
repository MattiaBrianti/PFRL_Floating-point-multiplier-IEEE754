
library ieee;
use ieee.std_logic_1164.all;

entity TB_HA is
end TB_HA;

architecture behavior of TB_HA is

    -- Component Declaration for the Unit Under Test (UUT)

    component HA
        port (
            X : in STD_LOGIC;
            CIN : in STD_LOGIC;
            S : out STD_LOGIC;
            COUT : out STD_LOGIC
        );
    end component;
    --Inputs
    signal X : STD_LOGIC;
    signal CIN : STD_LOGIC;

    --Outputs
    signal S : STD_LOGIC;
    signal COUT : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : HA port map(
        X => X,
        CIN => CIN,
        S => S,
        COUT => COUT
    );
    -- Stimulus process
    process
    begin
        X <= '0';
        CIN <= '0';
        wait for 20 ns;

        X <= '1';
        CIN <= '0';
        wait for 20 ns;

        X <= '1';
        CIN <= '1';
        wait for 20 ns;
    end process;
end;