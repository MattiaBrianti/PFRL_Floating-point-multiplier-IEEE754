library ieee;
use ieee.std_logic_1164.all;

entity PREP_COMPONENT is
    port (
        X : in STD_LOGIC_VECTOR (31 downto 0);
        Y : in STD_LOGIC_VECTOR (31 downto 0);
        MANT_EXT_X : out STD_LOGIC_VECTOR (23 downto 0);
        MANT_EXT_Y : out STD_LOGIC_VECTOR (23 downto 0);
        EXP_X : out STD_LOGIC_VECTOR (7 downto 0);
        EXP_Y : out STD_LOGIC_VECTOR (7 downto 0);
        S : out STD_LOGIC;
        FLAG : out STD_LOGIC_VECTOR (1 downto 0)
    );
end PREP_COMPONENT;


-- '01' infinity
-- '10' Invalid (at least one NaN)
-- '11' Zero (implies also BothDenormalized)

architecture RTL of PREP_COMPONENT is

  signal T1_X : STD_LOGIC;
  signal T1_Y : STD_LOGIC;
  signal T2_X : STD_LOGIC;
  signal T2_Y : STD_LOGIC;
  
begin
    
    -- Analisi esponenti
    T1_X <= X(30) or X(29) or X(28) or X(27) or X(26) or X(25) or X(24) or X(23); --  se ho tutti 0 mi ritornerá 0, se ho almeno un 1 mi ritornerá 1
    T1_Y <= Y(30) or Y(29) or Y(28) or Y(27) or Y(26) or Y(25) or Y(24) or Y(23);
    T2_X <= X(30) and X(29) and X(28) and X(27) and X(26) and X(25) and X(24) and X(23); -- se ho tutti 1 mi ritornerá 1, se ho almeno un 0 mi ritornerá 0
    T2_Y <= Y(30) and Y(29) and Y(28) and Y(27) and Y(26) and Y(25) and Y(24) and Y(23);

    -- FLAG CREATOR
    FLAG <= "10" when (T2_X = '1' and X(22 downto 0) /= "00000000000000000000000") or  -- X=Nan
                        (T2_Y ='1' and Y(22 downto 0) /= "00000000000000000000000") else --Y=Nan
            "10" when ((T2_X = '1' and X(22 downto 0) = "00000000000000000000000") and --X=inf
                    (T1_Y = '0' and Y(22 downto 0) = "00000000000000000000000")) or  -- Y=0
                        ((T2_Y ='1' and Y(22 downto 0) = "00000000000000000000000") and --Y=inf
                        (T2_X = '0' and X(22 downto 0) = "00000000000000000000000")) else --X=0
            "01" when (T2_X = '1' and X(22 downto 0) = "00000000000000000000000") or --X=inf
                        (T2_Y ='1' and Y(22 downto 0) = "00000000000000000000000") else --Y=inf
            "11" when (T1_X = '0' and X(22 downto 0) = "00000000000000000000000") or --X=0
                        (T1_Y = '0' and Y(22 downto 0) = "00000000000000000000000") else --Y=0
            "11" when (T1_X = '0' and T1_Y = '0') else --X e Y entrambi denormalizzati
            "00"; 
            

    -- Per creare la mantissa estesa aggiungiamo il bit implicito che troviamo usando l'OR8
    MANT_EXT_X <= T1_X & X(22 downto 0);
    MANT_EXT_Y <= T1_Y & Y(22 downto 0);
    
    -- Mando in uscita l'esponente
    EXP_X <= X(30 downto 23);
    EXP_Y <= Y(30 downto 23);

    -- Porta XOR per trovare il bit di segno
    S <= X(31) xor Y(31);

 end RTL;