
library ieee;
use ieee.std_logic_1164.all;

entity TB_CSA is
end TB_CSA;

architecture behavior of TB_CSA is

    -- Component Declaration for the Unit Under Test (UUT)

    component CSA
        port (
            X : in STD_LOGIC_VECTOR(31 downto 0);
            Y : in STD_LOGIC_VECTOR(31 downto 0);
            Z : in STD_LOGIC_VECTOR(31 downto 0);
            S : out STD_LOGIC_VECTOR(33 downto 0)
        );
    end component;
    --Inputs
    signal X : STD_LOGIC_VECTOR(31 downto 0);
    signal Y : STD_LOGIC_VECTOR(31 downto 0);
    signal Z : STD_LOGIC_VECTOR(31 downto 0);

    --Outputs
    signal S : STD_LOGIC_VECTOR(33 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : CSA port map(
        X => X,
        Y => Y,
        Z => Z,
        S => S
    );
    -- Stimulus process
    process
    begin

        X <= "10101011100010101111001000101110";
        Y <= "10101101100001101100011010110110";
        Z <= "10101101111000100001000000100000";
        wait for 20 ns;

        X <= "10011111001010011000000101011001";
        Y <= "10001110110010101100000000101011";
        Z <= "11001110101001101110001011000011";
        wait;
    end process;

end;