library ieee;
use ieee.std_logic_1164.all;

entity TB_MANTIX_FIXER is
end TB_MANTIX_FIXER;

architecture behavior of TB_MANTIX_FIXER is

  -- Component Declaration for the Unit Under Test (UUT)

  component MANTIX_FIXER
    port (
      MANT_X : in STD_LOGIC_VECTOR(22 downto 0);
      MANT_Y : in STD_LOGIC_VECTOR(22 downto 0);
      EXP_X : in STD_LOGIC_VECTOR(7 downto 0);
      EXP_Y : in STD_LOGIC_VECTOR(7 downto 0);
      FIXED_MANT_X : out STD_LOGIC_VECTOR(23 downto 0);
      FIXED_MANT_Y : out STD_LOGIC_VECTOR(23 downto 0)
    );
  end component;
  --Inputs
  signal MANT_X : STD_LOGIC_VECTOR(22 downto 0);
  signal MANT_Y : STD_LOGIC_VECTOR(22 downto 0);
  signal EXP_X : STD_LOGIC_VECTOR(7 downto 0);
  signal EXP_Y : STD_LOGIC_VECTOR(7 downto 0);

  --Outputs
  signal FIXED_MANT_X : STD_LOGIC_VECTOR(23 downto 0);
  signal FIXED_MANT_Y : STD_LOGIC_VECTOR(23 downto 0);
begin

  -- Instantiate the Unit Under Test (UUT)
  uut : MANTIX_FIXER port map(
    MANT_X => MANT_X,
    MANT_Y => MANT_Y,
    EXP_X => EXP_X,
    EXP_Y => EXP_Y,
    FIXED_MANT_X => FIXED_MANT_X,
    FIXED_MANT_Y => FIXED_MANT_Y
  );
  -- Stimulus process
  process
  begin
    MANT_X <= "10000001000110100111100";
    MANT_Y <= "10110011010011100111101";
    EXP_X <= "01100111";
    EXP_Y <= "11100100";
    wait for 20 ns;

    MANT_X <= "11000010011110100100000";
    MANT_Y <= "11010000000000101110000";
    EXP_X <= "11101100";
    EXP_Y <= "11111111";
    wait for 20 ns;

    MANT_X <= "11010101010001100101111";
    MANT_Y <= "01011100000111010111101";
    EXP_X <= "00000000";
    EXP_Y <= "11111100";
    wait for 20 ns;

  end process;

end;