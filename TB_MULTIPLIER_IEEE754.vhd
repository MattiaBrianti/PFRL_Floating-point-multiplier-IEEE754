
library ieee;
use ieee.std_logic_1164.all;

entity TB_MULTIPLIER_IEEE754 is
end TB_MULTIPLIER_IEEE754;

architecture behavior of TB_MULTIPLIER_IEEE754 is

    -- Component Declaration for the Unit Under Test (UUT)

    component MULTIPLIER_IEEE754
        port (
            X : in STD_LOGIC_VECTOR(31 downto 0);
            Y : in STD_LOGIC_VECTOR(31 downto 0);
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            RESULT : out STD_LOGIC_VECTOR(31 downto 0);
            INVALID : out STD_LOGIC
        );
    end component;
    --Inputs
    signal X : STD_LOGIC_VECTOR(31 downto 0);
    signal Y : STD_LOGIC_VECTOR(31 downto 0);
    signal RST : STD_LOGIC;
    signal CLK : STD_LOGIC;
    --Outputs
    signal RESULT : STD_LOGIC_VECTOR(31 downto 0);
    signal INVALID : STD_LOGIC;

    -- CLOCK PERIOD
    constant CLK_PERIOD : TIME := 85 ns;
begin

    -- Instantiate the Unit Under Test (UUT)
    uut : MULTIPLIER_IEEE754 port map(
        X => X,
        Y => Y,
        RST => RST,
        CLK => CLK,
        RESULT => RESULT,
        INVALID => INVALID
    );

    CLK_PROCESS : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD;
        CLK <= '1';
        wait for CLK_PERIOD;
    end process;

    process
    begin

        RST <= '1';
        wait for 15 ns;
        RST <= '0';
        -- TEST 15 - NORM * NORM = NORM (EXP: 0 10000011 00001110000000000000000 )
        X <= "01000000100100000000000000000000";
        Y <= "01000000011100000000000000000000";
        wait for 20 ns;

        -- TEST 16 - DENORM * DENORM = UNDERFLOW
        X <= "00000000011111111111111111111111";
        Y <= "00000000011111111111111111111111";
        wait for 20 ns;

        -- TEST 17 - NORM * NORM = OVERFLOW
        X <= "01111111011111111111111111111111";
        Y <= "01111111011111111111111111111111";
        wait for 20 ns;

        -- TEST 18 - NORM * DENORM = DENORM
        X <= "01000000100000000000000110000100";
        Y <= "00000000000010000010000110000100";
        wait for 20 ns;

        -- TEST 19 - NORM * DENORM = UNDERFLOW
        X <= "00000000100000100100011111111111";
        Y <= "00000000000000100100011111111111";
        wait for 20 ns;

        -- TEST 20 - NORM * DENORM = NORM
        X <= "01000011111000010000000000000000";
        Y <= "00000000000001011000110110101100";
        wait;
    end process;

end;