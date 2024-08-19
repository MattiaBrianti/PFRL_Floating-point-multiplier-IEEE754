
library ieee;
use ieee.std_logic_1164.all;

entity TB_OPERANDS_SPLITTER is
end TB_OPERANDS_SPLITTER;

architecture behavior of TB_OPERANDS_SPLITTER is

    -- Component Declaration for the Unit Under Test (UUT)

    component OPERANDS_SPLITTER
        port (
            X : in STD_LOGIC_VECTOR(31 downto 0);
            Y : in STD_LOGIC_VECTOR(31 downto 0);
            S_X : out STD_LOGIC;
            S_Y : out STD_LOGIC;
            EXP_X : out STD_LOGIC_VECTOR(7 downto 0);
            EXP_Y : out STD_LOGIC_VECTOR(7 downto 0);
            MANT_X : out STD_LOGIC_VECTOR(22 downto 0);
            MANT_Y : out STD_LOGIC_VECTOR(22 downto 0)
        );
    end component;
    --Inputs
    signal X : STD_LOGIC_VECTOR(31 downto 0);
    signal Y : STD_LOGIC_VECTOR(31 downto 0);

    --Outputs
    signal S_X : STD_LOGIC;
    signal S_Y : STD_LOGIC;
    signal EXP_X : STD_LOGIC_VECTOR(7 downto 0);
    signal EXP_Y : STD_LOGIC_VECTOR(7 downto 0);
    signal MANT_X : STD_LOGIC_VECTOR(22 downto 0);
    signal MANT_Y : STD_LOGIC_VECTOR(22 downto 0);
begin

    -- Instantiate the Unit Under Test (UUT)
    uut : OPERANDS_SPLITTER port map(
        X => X,
        Y => Y,
        S_X => S_X,
        S_Y => S_Y,
        EXP_X => EXP_X,
        EXP_Y => EXP_Y,
        MANT_X => MANT_X,
        MANT_Y => MANT_Y
    );

    -- Stimulus process
    stim_proc : process
    begin
        X <= "10100101000000000100011000001110";
        Y <= "00000110011111000100000110000100";
        wait for 20 ns;

        X <= "01111100000000111110100110111011";
        Y <= "01000111011100110110011010110010";
        wait for 20 ns;

        X <= "10010001010010101001011000011101";
        Y <= "01010111000100010100000101101000";
        wait for 20 ns;

    end process;

end;