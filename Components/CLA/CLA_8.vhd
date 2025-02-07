library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity CLA_8 is
  port (
    X, Y : in  std_logic_vector(7 downto 0);
    S    : out std_logic_vector(7 downto 0);
    Cin  : in  std_logic;
    Cout : out std_logic
  );
end entity;

architecture RTL of CLA_8 is
  component FA is
    port (
      X    : in  std_logic;
      Y    : in  std_logic;
      cin  : in  std_logic;
      S    : out std_logic;
      Cout : out std_logic
    );
  end component;

  signal C : std_logic_vector(8 downto 0) := (others => '0'); -- Carry
  signal P : std_logic_vector(7 downto 0) := (others => '0'); -- Propagazione
  signal G : std_logic_vector(7 downto 0) := (others => '0'); -- Generazione

begin
  G <= x and y; -- Funzione di generazione
  P <= x or y;  -- Funzione di propagazione

  C(1) <= G(0) or (P(0) and Cin);
  C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Cin);
  C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and Cin);
  C(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and Cin);
  C(5) <= G(4) or (P(4) and G(3)) or (P(4) and P(3) and G(2)) or (P(4) and P(3) and P(2) and G(1)) or (P(4) and P(3) and P(2) and P(1) and G(0)) or (P(4) and P(3) and P(2) and P(1) and P(0) and Cin);
  C(6) <= G(5) or (P(5) and G(4)) or (P(5) and P(4) and G(3)) or (P(5) and P(4) and P(3) and G(2)) or (P(5) and P(4) and P(3) and P(2) and G(1)) or (P(5) and P(4) and P(3) and P(2) and P(1) and G(0)) or (P(5) and P(4) and P(3) and P(2) and P(1) and P(0) and Cin);
  C(7) <= G(6) or (P(6) and G(5)) or (P(6) and P(5) and G(4)) or (P(6) and P(5) and P(4) and G(3)) or (P(6) and P(5) and P(4) and P(3) and G(2)) or (P(6) and P(5) and P(4) and P(3) and P(2) and G(1)) or (P(6) and P(5) and P(4) and P(3) and P(2) and P(1) and G(0)) or (P(6) and P(5) and P(4) and P(3) and P(2) and P(1) and P(0) and Cin);
  C(8) <= G(7) or (P(7) and G(6)) or (P(7) and P(6) and G(5)) or (P(7) and P(6) and P(5) and G(4)) or (P(7) and P(6) and P(5) and P(4) and G(3)) or (P(7) and P(6) and P(5) and P(4) and P(3) and G(2)) or (P(7) and P(6) and P(5) and P(4) and P(3) and P(2) and G(1)) or (P(7) and P(6) and P(5) and P(4) and P(3) and P(2) and P(1) and G(0)) or (P(7) and P(6) and P(5) and P(4) and P(3) and P(2) and P(1) and P(0) and Cin);

  -- Calcoliamo la prima somma considerando il Cin in ingresso
  first_FA: FA
    port map (
      X    => X(0),
      Y    => Y(0),
      CIN  => CIN,
      S    => S(0),
      COUT => open
    );

  -- Calcoliamo le altre somme con i carry calcolati dai CLA
  gen_full_adders: for i in 1 to 7 generate
    FA_inst: FA
      port map (
        X    => x(i),
        Y    => y(i),
        cin  => C(i),
        S    => S(i),
        Cout => open -- Non ci interessa il Carry che esce dalle FA
      );
  end generate;

  Cout <= C(8); -- Impostiamo l'ultimo carry calcolato come Cout del CLA     

end architecture;