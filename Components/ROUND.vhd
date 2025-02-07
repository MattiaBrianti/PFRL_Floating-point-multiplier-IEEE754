library ieee;
use ieee.std_logic_1164.all;

entity ROUND is
    port (
        MANT_MULT : in STD_LOGIC_VECTOR (47 downto 0);
        MANT_SHIFT : out STD_LOGIC_VECTOR (22 downto 0);
        OFFSET : out STD_LOGIC_VECTOR (4 downto 0);
        SUB : out STD_LOGIC
    );
end ROUND;

architecture RTL of ROUND is
     
     signal offset_t: STD_LOGIC_VECTOR (4 downto 0);
     signal mant_shift_t : STD_LOGIC_VECTOR (22 downto 0);


    component ENCODER_OFFSET is
        port (
            MANT_IN : in STD_LOGIC_VECTOR (23 downto 0); --faccio con 24 bit perché se non trovo un uno nei primi 24 bit allora non c'è offset e prendo gli ulitmi 22 bit della mantissa e concateno uno 0
            OFFSET : out STD_LOGIC_VECTOR (4 downto 0)
        );
    end component ENCODER_OFFSET;
    
    begin
        E_O : ENCODER_OFFSET
        port map (
            MANT_IN => MANT_MULT(45 downto 22), --prendo i primi 24 bit dopo la virgola
            OFFSET => offset_t
        );

-- Slicing della mantissa
with offset_t select
    mant_shift_t <= MANT_MULT(44 downto 22) when "00001",
                  MANT_MULT(43 downto 21) when "00010",
                  MANT_MULT(42 downto 20) when "00011",
                  MANT_MULT(41 downto 19) when "00100",
                  MANT_MULT(40 downto 18) when "00101",
                  MANT_MULT(39 downto 17) when "00110",
                  MANT_MULT(38 downto 16) when "00111",
                  MANT_MULT(37 downto 15) when "01000",
                  MANT_MULT(36 downto 14) when "01001",
                  MANT_MULT(35 downto 13) when "01010",
                  MANT_MULT(34 downto 12) when "01011",
                  MANT_MULT(33 downto 11) when "01100",
                  MANT_MULT(32 downto 10) when "01101",
                  MANT_MULT(31 downto 9) when "01110",
                  MANT_MULT(30 downto 8) when "01111",
                  MANT_MULT(29 downto 7) when "10000",
                  MANT_MULT(28 downto 6) when "10001",
                  MANT_MULT(27 downto 5) when "10010",
                  MANT_MULT(26 downto 4) when "10011",
                  MANT_MULT(25 downto 3) when "10100",
                  MANT_MULT(24 downto 2) when "10101",
                  MANT_MULT(23 downto 1) when "10110",
                  MANT_MULT(22 downto 0) when "10111",
                  MANT_MULT(21 downto 0) & '0' when others;

--cosí so se i primi 24 bit sono tutti 0, prendo gli ultimi 22 bit e concateno uno zero. Altrimenti se prendessi gli ultimi 23 sarei nello stesso
-- caso di offset = 10111 (23) 
result: process (offset_t, mant_shift_t)
  begin
    if (offset_t = "11001") then --Non è stato trovato un uno nei primi 24 bit della mantissa, perciò pongo offset al suo valore massimo
      MANT_SHIFT<= mant_shift_t;
      OFFSET<= "11000";
      SUB <= '1';
    elsif (MANT_MULT(47) = '1') then
      MANT_SHIFT <= MANT_MULT(46 downto 24);
      OFFSET <= "00001";
      SUB <= '0';
    elsif (MANT_MULT(46) = '1') then
        MANT_SHIFT <= MANT_MULT(45 downto 23);
        OFFSET <= "00000";
        SUB <= '0';
      else 
        OFFSET <= offset_t;
        MANT_SHIFT <= mant_shift_t;
        SUB <= '1';
      end if;
    end process;
   
end RTL;