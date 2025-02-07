library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_MULTIPLIER_IEEE754 is
end TB_MULTIPLIER_IEEE754;

architecture behavior of TB_MULTIPLIER_IEEE754 is

    -- Component Declaration for the Unit Under Test (UUT)

    component MULTIPLIER_IEEE754
        port (
            X : in STD_LOGIC_VECTOR(31 downto 0);
            Y : in STD_LOGIC_VECTOR(31 downto 0);
            NaN_flag : out std_logic;
            zero_flag : out std_logic;
            inf_flag : out std_logic;
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            RESULT : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    --Inputs
    signal X : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal Y : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal RST : STD_LOGIC;
    signal CLK : STD_LOGIC;
    --Outputs
    signal RESULT : STD_LOGIC_VECTOR(31 downto 0);
    signal NaN_flag : std_logic;
    signal zero_flag : std_logic;
    signal inf_flag : std_logic;
	 
	 --Utility signals
	 signal EXPECTED_RESULT: std_logic_vector(31 downto 0);
    -- signal ERROR : std_logic;
    -- signal INDEX : integer := 0;
    -- signal INDEX_RESULT : integer := 0;

    -- CLOCK PERIOD
    constant CLK_PERIOD : TIME := 20 ns;
begin

    --ERROR <= '1' when RESULT /= EXPECTED_RESULT else '0';
    --INDEX_RESULT <= INDEX - 3;

    -- Instantiate the Unit Under Test (UUT)
    uut : MULTIPLIER_IEEE754 port map(
        X => X,
        Y => Y,
        RST => RST,
        CLK => CLK,
        RESULT => RESULT,
        NaN_flag => NaN_flag,
        zero_flag => zero_flag,
        inf_flag => inf_flag
    );

    CLK_PROCESS : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
       -- INDEX <= INDEX + 1;
        wait for CLK_PERIOD/2;
    end process;

    process
    begin

        RST <= '1';
        wait for 50 ns;
        RST <= '0';
        wait for 55 ns;
        
        -- TEST 1 - NAN*NAN
        X <= "01111111101100000000000010000000";
        Y <= "01111111101100000011000010000000";
		--   EXPECTED_RESULT <= "01111111100001000100100010010000"; 1111111110000000000000000000000
        -- EXPECTED_RESULT <= "01111111110000000000000000000000";
        wait for CLK_PERIOD;
        
        
        -- TEST 2 - +INF * +INF
        X <= "01111111100000000000000000000000";
        Y <= "01111111100000000000000000000000";
		--   EXPECTED_RESULT <= "01111111100000000000000000000000";
        wait for CLK_PERIOD;
        
        -- TEST 3 - NAN*NORM
        X <= "01111111101100000000000010000000";
        Y <= "01111010101100000011000010000000";
		--   EXPECTED_RESULT <= "01111111100001000100100010010000";
        wait for CLK_PERIOD;
        
        -- TEST 4 - +INF * DENORM
        X <= "01111111100000000000000000000000";
        Y <= "00000000001100000011000010000000";
		--   EXPECTED_RESULT <= "01111111100000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 5 - NAN * DENORM
        X <= "01111111101100000000000010000000";
        Y <= "00000000001100000011000010000000";
		--   EXPECTED_RESULT <= "01111111100001000100100010010000";
        wait for CLK_PERIOD;
        
        -- TEST 6 - +INF * NORM
        X <= "01111111100000000000000000000000";
        Y <= "01111010101100000011000010000000";
		--   EXPECTED_RESULT <= "01111111100000000000000000000000";
        wait for CLK_PERIOD;
        
        -- TEST 7 - NAN * 0
        X <= "01111111101100000000000010000000";
        Y <= "00000000000000000000000000000000";
		--   EXPECTED_RESULT <= "01111111100001000100100010010000";
        wait for CLK_PERIOD;
        
         -- TEST 8 - +INF * -INF
        X <= "01111111100000000000000000000000";
        Y <= "11111111100000000000000000000000";
		--   EXPECTED_RESULT <= "11111111100000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 9 - NAN * INF
        X <= "01111111101100000000000010000000";
        Y <= "01111111100000000000000000000000";
		--   EXPECTED_RESULT <= "01111111100001000100100010010000";
        wait for CLK_PERIOD;

        -- TEST 10 - -INF*-INF
        X <= "11111111100000000000000000000000";
        Y <= "11111111100000000000000000000000";
		--   EXPECTED_RESULT <= "01111111100000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 11 - 0 * 0
        X <= "00000000000000000000000000000000";
        Y <= "00000000000000000000000000000000";
		--   EXPECTED_RESULT <= "00000000000000000000000000000000";
        wait for CLK_PERIOD;
        
        
         -- TEST 12 - 0 * INF
        X <= "00000000000000000000000000000000";
        Y <= "01111111100000000000000000000000";
		--   EXPECTED_RESULT <= "01111111100001000100100010010000";
        wait for CLK_PERIOD;

        -- TEST 13 - 0 * NORM
        X <= "00000000000000000000000000000000";
        Y <= "01111010101100000011000010000000";
		--   EXPECTED_RESULT <= "00000000000000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 14 - 0 * DENORM
        X <= "00000000000000000000000000000000";
        Y <= "00000000001100000011000010000000";
		--   EXPECTED_RESULT <= "00000000000000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 15 - NORM * NORM = NORM 
        X <= "01000000100100000000000000000000";
        Y <= "01000000011100000000000000000000";
		--   EXPECTED_RESULT <= "01000001100001110000000000000000";
        wait for CLK_PERIOD;

        -- TEST 16 - DENORM * DENORM = UNDERFLOW
        X <= "00000000011111111111111111111111";
        Y <= "00000000011111111111111111111111";
		--   EXPECTED_RESULT <= "00000000000000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 17 - NORM * NORM = OVERFLOW
        X <= "01111111011111111111111111111111";
        Y <= "01111111011111111111111111111111";
		--   EXPECTED_RESULT <= "01111111100000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 18 - NORM * DENORM = DENORM 
        X <= "01000000100000000000000110000100";
        Y <= "00000000000010000010000110000100";
		--   EXPECTED_RESULT <= "00000000001000001000011001110010";
        wait for CLK_PERIOD;

        -- TEST 19 - NORM * DENORM = UNDERFLOW
        X <= "00000000100000100100011111111111";
        Y <= "00000000000000100100011111111111";
		--   EXPECTED_RESULT <= "00000000000000000000000000000000";
        wait for CLK_PERIOD;

        -- TEST 20 - NORM * DENORM = NORM 
        X <= "01000011111000010000000000000000";
        Y <= "00000000000001011000110110101100";
		--   EXPECTED_RESULT <= "00000010100111000011000010001010";
        wait;
    end process;


    EXPECTED_RESULT_process: process
    begin

        wait for 100 ns;
        wait for CLK_PERIOD;
        -- wait until rising_edge(CLK);
        --1
        EXPECTED_RESULT <= "01111111110000000000000000000000";


        wait for CLK_PERIOD;
        wait for CLK_PERIOD;
        wait for CLK_PERIOD;
        wait for CLK_PERIOD;

        -- wait until rising_edge(CLK);
        -- wait until rising_edge(CLK);
        -- wait until rising_edge(CLK);
        -- wait until rising_edge(CLK);
        -- wait until rising_edge(CLK);
        --2
        EXPECTED_RESULT <= "01111111100000000000000000000000";

        wait for CLK_PERIOD;
        --3
        EXPECTED_RESULT <= "01111111110000000000000000000000";

        wait for CLK_PERIOD;
        --4
        EXPECTED_RESULT <= "01111111100000000000000000000000";

        wait for CLK_PERIOD;
        --5
        EXPECTED_RESULT <= "01111111110000000000000000000000";

        wait for CLK_PERIOD;
        --6
        EXPECTED_RESULT <= "01111111100000000000000000000000";

        wait for CLK_PERIOD;
        --7
        EXPECTED_RESULT <= "01111111110000000000000000000000";

        wait for CLK_PERIOD;
        --8
        EXPECTED_RESULT <= "11111111100000000000000000000000";

        wait for CLK_PERIOD;
        --9
        EXPECTED_RESULT <= "01111111110000000000000000000000";

        wait for CLK_PERIOD;
        --10
        EXPECTED_RESULT <= "01111111100000000000000000000000";

        wait for CLK_PERIOD;
        --11
        EXPECTED_RESULT <= "00000000000000000000000000000000";

        wait for CLK_PERIOD;
        --12
        EXPECTED_RESULT <= "01111111110000000000000000000000";

        wait for CLK_PERIOD;
        --13
        EXPECTED_RESULT <= "00000000000000000000000000000000";

        wait for CLK_PERIOD;
        --14
        EXPECTED_RESULT <= "00000000000000000000000000000000";

        wait for CLK_PERIOD;
        --15
        EXPECTED_RESULT <= "01000001100001110000000000000000";

        wait for CLK_PERIOD;
        --16
        EXPECTED_RESULT <= "00000000000000000000000000000000";

        wait for CLK_PERIOD;
        --17
        EXPECTED_RESULT <= "01111111100000000000000000000000";

        wait for CLK_PERIOD;
        --18
        EXPECTED_RESULT <= "00000000001000001000011001110010";

        wait for CLK_PERIOD;
        --19
        EXPECTED_RESULT <= "00000000000000000000000000000000";

        wait for CLK_PERIOD;
        --20
        EXPECTED_RESULT <= "00000010100111000011000010000101";

        wait;


    end process;


end;