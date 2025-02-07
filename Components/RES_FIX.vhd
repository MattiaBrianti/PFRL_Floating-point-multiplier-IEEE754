library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity RES_FIX is
  port (
    EXP_IN    : in  STD_LOGIC_VECTOR(9 downto 0);
    MANT_IN   : in  STD_LOGIC_VECTOR(22 downto 0);
    EXP_OUT   : out STD_LOGIC_VECTOR(7 downto 0);
    MANT_OUT  : out STD_LOGIC_VECTOR(22 downto 0)
  );
end entity;

architecture RTL of RES_FIX is

  component CLA_10 is
    port (
      X, Y : in  std_logic_vector(9 downto 0);
      Cin  : in  std_logic;
      S    : out std_logic_vector(9 downto 0);
      Cout : out std_logic
    );
  end component;

  component DENORMALIZER is
    port (
      MANTIX : in  std_logic_vector(22 downto 0);
      OFFSET  : in  std_logic_vector(4 downto 0);
      SHIFTED : out std_logic_vector(22 downto 0)
    );
  end component;

  signal TEMP_S            : std_logic_vector(9 downto 0);
  signal DENORM_OFFSET_SIG : std_logic_vector(4 downto 0);
  signal MANTIX_DENORM     : std_logic_vector(22 downto 0);

begin

  -- Controlliamo che l'esponente in ingresso sia maggiore di 22 utilizzando
  -- un CLA a 10 bit, sommando quindi all'esponente in ingresso 22 
   
  UNDERFLOW_CHECK: CLA_10
    port map (
      X    => EXP_IN,
      Y    => "0000010110",
      Cin  => '0',
      S    => TEMP_S, -- EXP_IN + 22
      Cout => open
    );

  -- Assumiamo che Temp_S sia un numero negativo a 9 bit.
  DENORM_OFFSET_SIG <= TEMP_S(4 downto 0);
  
  
  -- Il Denormalizer shifta la mantissa
  -- del numero di bit pari alla somma che esce
  -- dal CLA_10
  DENORMALIZE: DENORMALIZER
    port map (
      MANTIX => MANT_IN,
      OFFSET  => DENORM_OFFSET_SIG,
      SHIFTED => MANTIX_DENORM
    );


  -- Controlla l'overflow sull'esponente
  process (EXP_IN, MANT_IN, TEMP_S, DENORM_OFFSET_SIG)
  begin
    -- Controlliamo se l'esponente è maggiore di 254
    if (EXP_IN(9) = '0') and (EXP_IN(8) = '1') then
      -- In tal caso si verifica un Overflow e di conseguenza
      -- codifichiamo il numero con infinito
      EXP_OUT<= "11111111";
      MANT_OUT<= "00000000000000000000000";
      
      -- Verifichiamo quando l'esponente in ingresso è negativo
    elsif (EXP_IN(9) = '1') then

      -- Se il risultato della somma nel CLA_10 è negativo
      -- allora l'esponente in ingresso è minore di 22
      if (TEMP_S(9) = '1') then
        -- Codifichiamo quindi il risultato come un underflow
        EXP_OUT<= "00000000";
        MANT_OUT<= "00000000000000000000000";
      
        -- Se invece il risultato della somma è positivo
        -- abbiamo un denormalizzato recuperabile
        else
        EXP_OUT<= "00000000"; -- codifichiamo l'esponente con la codifica dei denorm
        MANT_OUT<= MANTIX_DENORM; -- Shift a dx di 22+TEMP_S bit, aggiungendo 1 come LSB dello shift
      end if;
    else
      -- Se non si rientra nelle casistiche precedenti
      -- il risultato è corretto
      EXP_OUT<= EXP_IN(7 downto 0);
      MANT_OUT<= MANT_IN;
    end if;
  end process;
end architecture;


