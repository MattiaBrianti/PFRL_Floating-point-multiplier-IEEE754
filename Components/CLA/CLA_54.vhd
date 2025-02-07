library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_54 is
  port (
    X, Y : in  std_logic_vector(53 downto 0);
    S    : out std_logic_vector(53 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
end entity;

architecture rtl of CLA_54 is

  component CLA_4 is
    port (
      X, Y : in  std_logic_vector(3 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(3 downto 0);
      Cout : out std_logic
    );
  end component;

  component CLA_10 is
    port (
      X, Y : in  std_logic_vector(9 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(9 downto 0);
      Cout : out std_logic
    );
  end component;

  signal Cout0, Cout1, Cout2, Cout3, Cout4 : std_logic;

begin
  CLA0: CLA_10 port map (X(9 downto 0), Y(9 downto 0), Cin, S(9 downto 0), Cout0);
  CLA1: CLA_10 port map (X(19 downto 10), y(19 downto 10), Cout0, S(19 downto 10), Cout1);
  CLA2: CLA_10 port map (X(29 downto 20), Y(29 downto 20), Cout1, S(29 downto 20), Cout2);
  CLA3: CLA_10 port map (X(39 downto 30), Y(39 downto 30), Cout2, S(39 downto 30), Cout3);
  CLA4: CLA_10 port map (X(49 downto 40), Y(49 downto 40), Cout3, S(49 downto 40), Cout4);
  CLA5: CLA_4 port map (X(53 downto 50), Y(53 downto 50), Cout4, S(53 downto 50), Cout);
end architecture;
