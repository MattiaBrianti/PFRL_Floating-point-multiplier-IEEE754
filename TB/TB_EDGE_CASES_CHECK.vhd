library ieee;
use ieee.std_logic_1164.all;

entity TB_EDGE_CASES_CHECK is
end TB_EDGE_CASES_CHECK;

architecture behavior of TB_EDGE_CASES_CHECK is

    -- Component Declaration for the Unit Under Test (UUT)

    component EDGE_CASES_CHECK
        port (
            EXP_X : in STD_LOGIC_VECTOR(7 downto 0);
            EXP_Y : in STD_LOGIC_VECTOR(7 downto 0);
            MANT_X : in STD_LOGIC_VECTOR(22 downto 0);
            MANT_Y : in STD_LOGIC_VECTOR(22 downto 0);
            FLAG : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;
    --Inputs
    signal EXP_X : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal EXP_Y : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal MANT_X : STD_LOGIC_VECTOR(22 downto 0) := (others => '0');
    signal MANT_Y : STD_LOGIC_VECTOR(22 downto 0) := (others => '0');

    --Outputs
    signal FLAG : STD_LOGIC_VECTOR(1 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : EDGE_CASES_CHECK port map(
        EXP_X => EXP_X,
        EXP_Y => EXP_Y,
        MANT_X => MANT_X,
        MANT_Y => MANT_Y,
        FLAG => FLAG
    );

    -- Stimulus process
    process
    begin
        --X=NAN E Y=NORM = NAN
        MANT_X <= "11010101010001100101111";
        EXP_X <= "11111111";
        MANT_Y <= "01011100000111010111101";
        EXP_Y <= "11111100";
        wait for 20 ns;

        --X=NORM E Y=NAN = NAN
        MANT_Y <= "11010101010001100101111";
        EXP_Y <= "11111111";
        MANT_X <= "01011100000111010111101";
        EXP_X <= "11111100";
        wait for 20 ns;

        --X=INF E Y=0 = NAN
        MANT_X <= "00000000000000000000000";
        EXP_X <= "11111111";
        MANT_Y <= "00000000000000000000000";
        EXP_Y <= "00000000";
        wait for 20 ns;

        --x=0 E Y=INF = NAN
        MANT_Y <= "00000000000000000000000";
        EXP_Y <= "11111111";
        MANT_X <= "00000000000000000000000";
        EXP_X <= "00000000";
        wait for 20 ns;

        --X=INF E Y=INF = INF
        MANT_X <= "00000000000000000000000";
        EXP_X <= "11111111";
        MANT_Y <= "00000000000000000000000";
        EXP_Y <= "11111111";
        wait for 20 ns;

        --X=NORM E Y=INF = INF
        MANT_X <= "00000011000000000000000";
        EXP_X <= "11110011";
        MANT_Y <= "00000000000000000000000";
        EXP_Y <= "11111111";
        wait for 20 ns;

        --X=0 E Y=0 = 0
        MANT_X <= "00000000000000000000000";
        EXP_X <= "00000000";
        MANT_Y <= "00000000000000000000000";
        EXP_Y <= "00000000";
        wait for 20 ns;

        --X=0 e Y NORM = 0
        MANT_X <= "00000000000000000000000";
        EXP_X <= "00000000";
        MANT_Y <= "00000000110000000000000";
        EXP_Y <= "00001100";
        wait for 20 ns;

        --DENORM E DENORM = DENORM(Zero)
        MANT_X <= "00110000000000000000000";
        EXP_X <= "00000000";
        MANT_Y <= "00000000110000000000000";
        EXP_Y <= "00000000";
        wait for 20 ns;

        --DENORM E NORM = NoFlag
        MANT_X <= "00110000000000000000000";
        EXP_X <= "00000000";
        MANT_Y <= "00000000110000000000000";
        EXP_Y <= "00001100";
        wait for 20 ns;

        --NORM E NORM = NoFlag
        MANT_X <= "00110000000000000000000";
        EXP_X <= "00000110";
        MANT_Y <= "00000000110000000000000";
        EXP_Y <= "00001100";
        wait;
    end process;

end;