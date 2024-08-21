library ieee;
use ieee.std_logic_1164.all;

entity PR_ENC_24B is
    port (
        X : in STD_LOGIC_VECTOR (23 downto 0);
        POSITION : out STD_LOGIC_VECTOR (4 downto 0);
        INVALID : out STD_LOGIC
    );
end PR_ENC_24B;

architecture RTL of PR_ENC_24B is
begin
    INVALID <= '1' when (X = "000000000000000000000000") else
        '0';

    POSITION <= "10111" when (X(23) = '1') else
        "10110" when (X(22) = '1') else
        "10101" when (X(21) = '1') else
        "10100" when (X(20) = '1') else
        "10011" when (X(19) = '1') else
        "10010" when (X(18) = '1') else
        "10001" when (X(17) = '1') else
        "10000" when (X(16) = '1') else
        "01111" when (X(15) = '1') else
        "01110" when (X(14) = '1') else
        "01101" when (X(13) = '1') else
        "01100" when (X(12) = '1') else
        "01011" when (X(11) = '1') else
        "01010" when (X(10) = '1') else
        "01001" when (X(9) = '1') else
        "01000" when (X(8) = '1') else
        "00111" when (X(7) = '1') else
        "00110" when (X(6) = '1') else
        "00101" when (X(5) = '1') else
        "00100" when (X(4) = '1') else
        "00011" when (X(3) = '1') else
        "00010" when (X(2) = '1') else
        "00001" when (X(1) = '1') else
        "00000";

end RTL;