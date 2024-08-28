library ieee;
use ieee.std_logic_1164.all;

entity TB_CSA is
end TB_CSA;

architecture behavior of TB_CSA is

    -- Component Declaration for the Unit Under Test (UUT)

    component CSA
        generic (N : INTEGER := 48);
        port (
            X : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Z : in STD_LOGIC_VECTOR (N - 1 downto 0);
            S : out STD_LOGIC_VECTOR (N + 1 downto 0)
        );
    end component;
    --inputs
    signal X : STD_LOGIC_VECTOR (47 downto 0);
    signal Y : STD_LOGIC_VECTOR (47 downto 0);
    signal Z : STD_LOGIC_VECTOR (47 downto 0);
    --outputs
    signal S : STD_LOGIC_VECTOR(49 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : CSA port map(
        X => X,
        Y => Y,
        Z => Z,
        S => S
    );
    process
    begin
        X <= "000000000000000000000000000000000000000000000000";
        Y <= "000000000000000000000000000000000000000000000001";
        Z <= "000000000000000000000000000000000000000000000001";
        wait for 20 ns;

        X <= "000000000000000000000000000000000000000000000000";
        Y <= "000000000000000000000000000000000000000000000000";
        Z <= "000000000000000000000000000000000000000000000001";
        wait for 20 ns;

        X <= "000010000010000000000001000000000000000000010000";
        Y <= "100000000000000000000000000000000000000000010000";
        Z <= "100000100000000000000000000000000000000000000001";
        wait for 20 ns;
    end process;
end;