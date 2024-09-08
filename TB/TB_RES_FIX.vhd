
library ieee;
use ieee.std_logic_1164.all;

entity TB_RES_FIX is
end TB_RES_FIX;

architecture behavior of TB_RES_FIX is

    -- Component Declaration for the Unit Under Test (UUT)

    component RES_FIX
        port (
            EXP_IN : in STD_LOGIC_VECTOR(9 downto 0);
            MANT_IN : in STD_LOGIC_VECTOR(22 downto 0);
            EXP_OUT : out STD_LOGIC_VECTOR(7 downto 0);
            MANT_OUT : out STD_LOGIC_VECTOR(22 downto 0)
        );
    end component;
    --Inputs
    signal EXP_IN : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal MANT_IN : STD_LOGIC_VECTOR(22 downto 0) := (others => '0');

    --Outputs
    signal EXP_OUT : STD_LOGIC_VECTOR(7 downto 0);
    signal MANT_OUT : STD_LOGIC_VECTOR(22 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : RES_FIX port map(
        EXP_IN => EXP_IN,
        MANT_IN => MANT_IN,
        EXP_OUT => EXP_OUT,
        MANT_OUT => MANT_OUT
    );

    -- Stimulus process
    process
    begin

        -- Overflow, expected exp a tutti 1 e mantix a tutti 0
        EXP_IN <= "0011111111";
        MANT_IN <= "00011111011100010010110";
        wait for 20 ns;

        -- Denorm, expected exp a 0 e mantix shiftata di exp_in + 22
        EXP_IN <= "1111101100";
        MANT_IN <= "00011111011100010010110";
        wait for 20 ns;

        -- Underflow, exp a 0 e mantix a 0
        EXP_IN <= "1111101001";
        MANT_IN <= "00011111011100010010110";
        wait for 20 ns;

        -- Standard Case, rimangono uguali
        EXP_IN <= "0011111110";
        MANT_IN <= "00011111011100010010110";
        wait;
    end process;
end;
