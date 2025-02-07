library ieee;
use ieee.std_logic_1164.all;

entity FLAG_DETECTOR is
    port (
        FLAG : in STD_LOGIC_VECTOR (1 downto 0);
        S : in STD_LOGIC;
        MANT_IN : in STD_LOGIC_VECTOR (22 downto 0);
        EXP_IN : in STD_LOGIC_VECTOR (7 downto 0);
        RES_FINAL : out STD_LOGIC_VECTOR (31 downto 0);
        NaN_flag : out std_logic;
        zero_flag : out std_logic;
        inf_flag : out std_logic
    );
end FLAG_DETECTOR;

-- Ritardo stimato di 10.735 ns

-- '01' infinity
-- '10' Invalid (at least one NaN)
-- '11' Zero (implies also BothDenormalized)

architecture RTL of FLAG_DETECTOR is
begin

    -- Quando viene rilevata una condizione particolare
    -- viene alzata la flag corrispondente

    NaN_flag <= '1' when FLAG = "10" else '0';
    zero_flag <= '1' when FLAG = "11" else '0';
    inf_flag <= '1' when FLAG = "01" else '0';

    -- Codifica di zero per la flag 11 (Zero)
    RES_FINAL <= "00000000000000000000000000000000" when (FLAG = "11") else
        -- Codifica di infinito per la flag 01 (Infinity)
        (S & "1111111100000000000000000000000") when (FLAG = "01") else
        -- Codifica di QNaN per la flag 10 (Invalid)
        (S & "1111111110000000000000000000000") when (FLAG = "10") else
        -- Risultato finale, se non ci sono flag alzate
        S & EXP_IN & MANT_IN;

end RTL;