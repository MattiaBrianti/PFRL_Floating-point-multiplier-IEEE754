-- Finished

library ieee;
use ieee.std_logic_1164.all;

entity CSA is

      generic (N : INTEGER := 32);

      port (
            X : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Z : in STD_LOGIC_VECTOR (N - 1 downto 0);
            S : out STD_LOGIC_VECTOR (N + 1 downto 0)
      );
end CSA;

architecture RTL of CSA is

      signal CS : STD_LOGIC_VECTOR (N - 1 downto 0);
      signal T : STD_LOGIC_VECTOR (N - 1 downto 0);
      signal CIN : STD_LOGIC_VECTOR (N - 1 downto 0);

      component FA is
            port (
                  CIN : in STD_LOGIC;
                  X : in STD_LOGIC;
                  Y : in STD_LOGIC;
                  COUT : out STD_LOGIC;
                  S : out STD_LOGIC
            );
      end component;

      component HA is
            port (
                  X : in STD_LOGIC;
                  CIN : in STD_LOGIC;
                  S : out STD_LOGIC;
                  COUT : out STD_LOGIC
            );
      end component;

begin
      gen_carry_save : for I in 0 to N - 1 generate
            carry_save : FA
            port map(
                  X => X (I),
                  Y => Y (I),
                  CIN => Z (I),
                  COUT => CS(I),
                  S => T (I)
            );
      end generate gen_carry_save;

      gen_full_adder : for I in 0 to N - 2 generate
            full_adder : FA
            port map(
                  X => CS(I),
                  Y => T(I + 1),
                  CIN => CIN(I),
                  COUT => CIN(I + 1),
                  S => S(I + 1)
            );
      end generate gen_full_adder;

      half_adder : HA
      port map(
            X => CS(N - 1),
            CIN => CIN(N - 1),
            S => S(N),
            COUT => S(N + 1)
      );

      CIN(0) <= '0';
      S(0) <= T(0);

end RTL;