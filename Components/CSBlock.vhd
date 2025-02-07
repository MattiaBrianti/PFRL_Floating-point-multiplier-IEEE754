library ieee;
use ieee.std_logic_1164.all;

entity CSBlock is
      generic(
            N : integer := 47
      );
   
      port (
            X : in STD_LOGIC_VECTOR (N-1 downto 0);
            Y : in STD_LOGIC_VECTOR (N-1 downto 0);
            Z : in STD_LOGIC_VECTOR (N-1 downto 0);
            T : out STD_LOGIC_VECTOR (N downto 0);
            CS : out STD_LOGIC_VECTOR (N downto 0)
      );
end CSBlock;

architecture RTL of CSBlock is

      component FA is
            port (
                  CIN : in STD_LOGIC;
                  X : in STD_LOGIC;
                  Y : in STD_LOGIC;
                  COUT : out STD_LOGIC;
                  S : out STD_LOGIC
            );
      end component;


begin
      gen_carry_save : for I in 0 to N-1 generate
            carry_save : FA
            port map(
                  X => X (I),
                  Y => Y (I),
                  CIN => Z (I),
                  COUT => CS(I+1),
                  S => T (I)
            );
      end generate gen_carry_save;

      CS(0) <= '0';
      T(N) <= '0';

 end RTL;