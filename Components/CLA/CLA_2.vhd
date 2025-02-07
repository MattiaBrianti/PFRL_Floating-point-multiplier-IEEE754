library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_2 is
  port (
    X, Y : in  std_logic_vector(1 downto 0);
    S    : out std_logic_vector(1 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
end entity;

architecture rtl of CLA_2 is
  component FA is
    port (
      X    : in  std_logic;
      Y    : in  std_logic;
      cin  : in  std_logic;
      S    : out std_logic;
      Cout : out std_logic
    );
  end component;

  signal C : std_logic_vector(2 downto 0) := (others => '0'); -- Carry
  signal P : std_logic_vector(1 downto 0) := (others => '0'); -- Propagazione
  signal G : std_logic_vector(1 downto 0) := (others => '0'); -- Generazione

begin
  G <= x and y; -- Funzione di generazione
  P <= x or y;  -- Funzione di propagazione

  C(1) <= G(0) or (P(0) and Cin);
  C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Cin);

  -- Calcoliamo la prima somma considerando il Cin in ingresso
  first_FA: FA
    port map (
      X    => x(0),
      Y    => y(0),
      cin  => Cin,
      S    => S(0),
      Cout => open
    );

  -- Calcoliamo l'altra somma con il carry calcolato dal CLA
  FA_inst: FA
    port map (
      X    => x(1),
      Y    => y(1),
      cin  => C(1),
      S    => S(1),
      Cout => open -- Non ci interessa il Carry che esce dalle FA
    );

  Cout <= C(2); -- Impostiamo l'ultimo carry calcolato come Cout del CLA     

end architecture;