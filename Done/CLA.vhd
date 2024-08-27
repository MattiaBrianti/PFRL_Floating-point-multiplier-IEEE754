library ieee;
use ieee.std_logic_1164.all;

entity CLA is
    generic (N : INTEGER := 32);
    port (
        X : in STD_LOGIC_VECTOR(N - 1 downto 0);
        Y : in STD_LOGIC_VECTOR(N - 1 downto 0);
        S : out STD_LOGIC_VECTOR(N downto 0)
    );
end CLA;

-- Ritardo stimato 20 ns (13,855 exactly)

architecture RTL of CLA is
    component FA is
        port (
            X : in STD_LOGIC;
            Y : in STD_LOGIC;
            CIN : in STD_LOGIC;
            S : out STD_LOGIC;
            COUT : out STD_LOGIC
        );
    end component FA;

    signal G : STD_LOGIC_VECTOR(N - 1 downto 0); -- Generate
    signal P : STD_LOGIC_VECTOR(N - 1 downto 0); -- Propagate
    signal C : STD_LOGIC_VECTOR(N downto 0); -- Carry

    signal PRS : STD_LOGIC_VECTOR(N - 1 downto 0);

begin

    -- Create the Full Adders
    GEN_FULL_ADDERS : for i in 0 to N - 1 generate

        FULL_ADDER_INST : FA
        port map(
            X => X(i),
            Y => Y(i),
            CIN => C(i),
            S => PRS(i),
            COUT => open
        );
    end generate GEN_FULL_ADDERS;

    -- Create the Generate (G) Terms: Gi=Ai*Bi
    -- Create the Propagate Terms: Pi=Ai+Bi
    -- Create the Carry Terms: 
    GEN_CLA : for j in 0 to N - 1 generate
        G(j) <= X(j) and Y(j);
        P(j) <= X(j) or Y(j);
        C(j + 1) <= G(j) or (P(j) and C(j));
    end generate GEN_CLA;

    C(0) <= '0'; -- no carry input

    S <= C(N) & PRS; -- VHDL Concatenation

end RTL;