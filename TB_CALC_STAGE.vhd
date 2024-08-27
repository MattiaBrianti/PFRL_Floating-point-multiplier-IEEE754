
library ieee;
use ieee.std_logic_1164.all;

entity TB_CALC_STAGE is
end TB_CALC_STAGE;

architecture behavior of TB_CALC_STAGE is

    -- Component Declaration for the Unit Under Test (UUT)

    component CALC_STAGE
        port (
            FLAG : in STD_LOGIC_VECTOR(1 downto 0);
            S : in STD_LOGIC;
            EXP_X : in STD_LOGIC_VECTOR(7 downto 0);
            EXP_Y : in STD_LOGIC_VECTOR(7 downto 0);
            FIXED_MANT_X : in STD_LOGIC_VECTOR(23 downto 0);
            FIXED_MANT_Y : in STD_LOGIC_VECTOR(23 downto 0);
            S_OUT : out STD_LOGIC;
            FLAG_OUT : out STD_LOGIC_VECTOR(1 downto 0);
            P : out STD_LOGIC_VECTOR(47 downto 0);
            exp_out : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;
    --Inputs
    signal FLAG : STD_LOGIC_VECTOR(1 downto 0);
    signal S : STD_LOGIC;
    signal EXP_X : STD_LOGIC_VECTOR(7 downto 0);
    signal EXP_Y : STD_LOGIC_VECTOR(7 downto 0);
    signal FIXED_MANT_X : STD_LOGIC_VECTOR(23 downto 0);
    signal FIXED_MANT_Y : STD_LOGIC_VECTOR(23 downto 0);

    --Outputs
    signal S_OUT : STD_LOGIC;
    signal FLAG_OUT : STD_LOGIC_VECTOR(1 downto 0);
    signal P : STD_LOGIC_VECTOR(47 downto 0);
    signal exp_out : STD_LOGIC_VECTOR(9 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : CALC_STAGE port map(
        FLAG => FLAG,
        S => S,
        EXP_X => EXP_X,
        EXP_Y => EXP_Y,
        FIXED_MANT_X => FIXED_MANT_X,
        FIXED_MANT_Y => FIXED_MANT_Y,
        S_OUT => S_OUT,
        FLAG_OUT => FLAG_OUT,
        P => P,
        exp_out => exp_out
    );
    -- Stimulus process
    process
    begin

        -- 
        FLAG <= "00";
        S <= '1';
        EXP_X <= "01101000"; --EXP(-23)--104
        EXP_Y <= "10100000"; --EXP(33)--160
        FIXED_MANT_X <= "001101111001110000011011";
        FIXED_MANT_Y <= "101011101101100010011111";
        wait;

    end process;

end;