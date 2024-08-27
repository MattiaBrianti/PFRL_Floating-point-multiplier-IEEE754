-- Finished and tested

library ieee;
use ieee.std_logic_1164.all;

entity EDGE_CASES_CHECK is
    port (
        EXP_X : in STD_LOGIC_VECTOR (7 downto 0); -- 8-bit exponent
        EXP_Y : in STD_LOGIC_VECTOR (7 downto 0); -- 8-bit exponent
        MANT_X : in STD_LOGIC_VECTOR (22 downto 0); -- 23-bit mantissa
        MANT_Y : in STD_LOGIC_VECTOR (22 downto 0); -- 23-bit mantissa
        FLAG : out STD_LOGIC_VECTOR (1 downto 0) -- 2-bit flag for INF, NAN, ZERO and DENORM
    );
end EDGE_CASES_CHECK;

-- Ritardo stimato 15 ns (9,250 exactly)
-- '00' NoFlag
-- '01' infinity
-- '10' Invalid (at least one NaN)
-- '11' Zero (implies also BothDenormalized)

--Dubbi: Posso usare il diverso?
-- Come faccio a riconoscere una NoFlag? forse devo lasciare un caso per questa (tipo 00)

architecture RTL of EDGE_CASES_CHECK is
begin
    FLAG <= "10" when (EXP_X = "11111111" and MANT_X /= "00000000000000000000000") or
        (EXP_Y = "11111111" and MANT_Y /= "00000000000000000000000") else
        "10" when ((EXP_X = "11111111" and MANT_X = "00000000000000000000000") and
        (EXP_Y = "00000000" and MANT_Y = "00000000000000000000000")) or
        ((EXP_Y = "11111111" and MANT_Y = "00000000000000000000000") and
        (EXP_X = "00000000" and MANT_X = "00000000000000000000000")) else
        "01" when (EXP_X = "11111111" and MANT_X = "00000000000000000000000") or
        (EXP_Y = "11111111" and MANT_Y = "00000000000000000000000") else
        "11" when (EXP_X = "00000000" and MANT_X = "00000000000000000000000") or
        (EXP_Y = "00000000" and MANT_Y = "00000000000000000000000") else
        "11" when (EXP_X = "00000000" and EXP_Y = "00000000") else
        "00";
end RTL;
-- 10010101110110000001111