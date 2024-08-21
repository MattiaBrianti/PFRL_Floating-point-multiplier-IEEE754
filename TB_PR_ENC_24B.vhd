
library ieee;
use ieee.std_logic_1164.all;

entity TB_PR_ENC_24B is
end TB_PR_ENC_24B;

architecture behavior of TB_PR_ENC_24B is

    -- Component Declaration for the Unit Under Test (UUT)

    component PR_ENC_24B
        port (
            X : in STD_LOGIC_VECTOR(23 downto 0);
            POSITION : out STD_LOGIC_VECTOR(4 downto 0);
            INVALID : out STD_LOGIC
        );
    end component;
    --Inputs
    signal X : STD_LOGIC_VECTOR(23 downto 0);

    --Outputs
    signal POSITION : STD_LOGIC_VECTOR(4 downto 0);
    signal INVALID : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : PR_ENC_24B port map(
        X => X,
        POSITION => POSITION,
        INVALID => INVALID
    );

    -- Stimulus process
    process
    begin
        X <= "000000000000000000000001";
        wait for 20 ns;

        X <= "000000000000000000000000";
        wait for 20 ns;

        X <= "000000000000001100111000";
        wait for 20 ns;

        X <= "100011000100010001110000";
        wait;
    end process;

end;