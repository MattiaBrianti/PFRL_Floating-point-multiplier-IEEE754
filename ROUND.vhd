
library ieee;
use ieee.std_logic_1164.all;

entity ROUND is
    port (
        MANT_EXT : in STD_LOGIC_VECTOR (47 downto 0);
        MANT_SHIFT : out STD_LOGIC_VECTOR (22 downto 0);
        OFFSET : out STD_LOGIC_VECTOR (4 downto 0);
        SUB : out STD_LOGIC
    );
end ROUND;

architecture RTL of ROUND is

    component PR_ENC_24B is
        port (
            X : in STD_LOGIC_VECTOR (23 downto 0);
            POSITION : out STD_LOGIC_VECTOR (4 downto 0);
            INVALID : out STD_LOGIC
        );
    end component PR_ENC_24B;

    signal POSITION : STD_LOGIC_VECTOR (4 downto 0);
    signal INVALID : STD_LOGIC;

begin
    U1 : PR_ENC_24B
    port map(
        X => MANT_EXT(46 downto 23),
        POSITION => POSITION,
        INVALID => INVALID
    );

    SUB <= '0' when (MANT_EXT(47) = '1') or
        (MANT_EXT(46) = '1') else
        '1';

    OFFSET <= "00001" when (MANT_EXT(47) = '1') else
        "00000" when (MANT_EXT(46) = '1') else
        POSITION;

    MANT_SHIFT <= MANT_EXT(47 downto 25) when (MANT_EXT(47) = '1') else
        MANT_EXT(46 downto 24) when (MANT_EXT(46) = '1') else
        MANT_EXT(22 downto 0) when (INVALID = '1') else
        MANT_EXT(45 - POSITION downto (45 - POSITION) - 22); --SBAGLIATO! Non posso usare il segno - (pensare strategia diversa)      

end RTL;