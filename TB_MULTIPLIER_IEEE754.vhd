
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
    constant CLK_PERIOD : TIME := 45 ns;
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
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    process
    begin

        RST <= '1';
        wait for 35 ns;
        RST <= '0';
        wait for 10 ns;
        
        -- TEST 1 - NAN*NAN
        X <= "01111111101100000000000010000000";
        Y <= "01111111101100000011000010000000";
        wait for CLK_PERIOD;

        -- TEST 2 - NAN*NORM
        X <= "01111111101100000000000010000000";
        Y <= "01111010101100000011000010000000";
        wait for CLK_PERIOD;

        -- TEST 3 - NAN * DENORM
        X <= "01111111101100000000000010000000";
        Y <= "00000000001100000011000010000000";
        wait for CLK_PERIOD;

        -- TEST 4 - NAN * 0
        X <= "01111111101100000000000010000000";
        Y <= "00000000000000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 5 - NAN * INF
        X <= "01111111101100000000000010000000";
        Y <= "01111111100000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 6 - 0 * INF
        X <= "00000000000000000000000000000000";
        Y <= "01111111100000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 7 - +INF * +INF
        X <= "01111111100000000000000000000000";
        Y <= "01111111100000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 8 - -INF*-INF
        X <= "11111111100000000000000000000000";
        Y <= "11111111100000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 9 - +INF * DENORM
        X <= "01111111100000000000000000000000";
        Y <= "00000000001100000011000010000000";
        wait for CLK_PERIOD;

        -- TEST 10 - +INF * NORM
        X <= "01111111100000000000000000000000";
        Y <= "01111010101100000011000010000000";
        wait for CLK_PERIOD;

        -- TEST 11 - +INF * -INF
        X <= "01111111100000000000000000000000";
        Y <= "11111111100000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 12 - 0 * 0
        X <= "00000000000000000000000000000000";
        Y <= "00000000000000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 13 - 0 * NORM
        X <= "00000000000000000000000000000000";
        Y <= "01111010101100000011000010000000";
        wait for CLK_PERIOD;

        -- TEST 14 - 0 * DENORM
        X <= "00000000000000000000000000000000";
        Y <= "00000000001100000011000010000000";
        wait for CLK_PERIOD;

        -- TEST 15 - NORM * NORM = NORM (EXP: 0 10000011 00001110000000000000000 )
        X <= "01000000100100000000000000000000";
        Y <= "01000000011100000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 16 - DENORM * DENORM = UNDERFLOW
        X <= "00000000011111111111111111111111";
        Y <= "00000000011111111111111111111111";
        wait for CLK_PERIOD;

        -- TEST 17 - NORM * NORM = OVERFLOW
        X <= "01111111011111111111111111111111";
        Y <= "01111111011111111111111111111111";
        wait for CLK_PERIOD;

        -- TEST 18 - NORM * DENORM = DENORM
        X <= "01000000100000000000000110000100";
        Y <= "00000000000010000010000110000100";
        wait for CLK_PERIOD;

        -- TEST 19 - NORM * DENORM = UNDERFLOW
        X <= "00000000100000100100011111111111";
        Y <= "00000000000000100100011111111111";
        wait for CLK_PERIOD;

        -- TEST 20 - NORM * DENORM = NORM
        X <= "01000011111000010000000000000000";
        Y <= "00000000000001011000110110101100";
        wait;
    end process;

end;
