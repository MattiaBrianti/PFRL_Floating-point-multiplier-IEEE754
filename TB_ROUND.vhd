
library ieee;
use ieee.std_logic_1164.all;

entity TB_ROUND is
end TB_ROUND;

architecture behavior of TB_ROUND is

    -- Component Declaration for the Unit Under Test (UUT)

    component ROUND
        port (
            MANT_EXT : in STD_LOGIC_VECTOR(47 downto 0);
            MANT_SHIFT : out STD_LOGIC_VECTOR(22 downto 0);
            OFFSET : out STD_LOGIC_VECTOR(4 downto 0);
            SUB : out STD_LOGIC
        );
    end component;
    --Inputs
    signal MANT_EXT : STD_LOGIC_VECTOR(47 downto 0);

    --Outputs
    signal MANT_SHIFT : STD_LOGIC_VECTOR(22 downto 0);
    signal OFFSET : STD_LOGIC_VECTOR(4 downto 0);
    signal SUB : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : ROUND port map(
        MANT_EXT => MANT_EXT,
        MANT_SHIFT => MANT_SHIFT,
        OFFSET => OFFSET,
        SUB => SUB
    );
    -- Stimulus process
    process
    begin

        -- 1bit - expected 10001000001010001111011
        MANT_EXT <= "100010000010100011110110010001100111000010010101";
        wait for 20 ns;

        -- 2bit - expected 10010000010100011110110
        MANT_EXT <= "010010000010100011110110010001100111000010010101";
        wait for 20 ns;

        -- posizione intermedia -expected 00000000000001100000000
        MANT_EXT <= "000000000000000010000000000000110000000000000001";
        wait for 20 ns;

        -- ultimi 23 bit -expected 00001000000010000000000
        MANT_EXT <= "000000000000000000000000000001000000010000000000";
        wait;
    end process;

end;