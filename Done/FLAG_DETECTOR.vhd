library ieee;
use ieee.std_logic_1164.all;

entity FLAG_DETECTOR is
    port (
        FLAG : in STD_LOGIC_VECTOR (1 downto 0);
        S : in STD_LOGIC;
        MANT_IN : in STD_LOGIC_VECTOR (22 downto 0);
        EXP_IN : in STD_LOGIC_VECTOR (7 downto 0);
        RES_FINAL : out STD_LOGIC_VECTOR (31 downto 0);
        INVALID : out STD_LOGIC
    );
end FLAG_DETECTOR;
-- '00' NoFlag
-- '01' infinity
-- '10' Invalid (at least one NaN)
-- '11' Zero (implies also BothDenormalized)

architecture RTL of FLAG_DETECTOR is
begin
    RES_FINAL <= "00000000000000000000000000000000" when (FLAG = "11") else
        (S & "1111111100000000000000000000000") when (FLAG = "01") else
        S & EXP_IN & MANT_IN;
    INVALID <= '1' when (FLAG = "10") else
        '0';

end RTL;