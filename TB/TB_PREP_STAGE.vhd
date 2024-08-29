
library ieee;
use ieee.std_logic_1164.all;

entity TB_PREP_STAGE is
end TB_PREP_STAGE;

architecture behavior of TB_PREP_STAGE is

   -- Component Declaration for the Unit Under Test (UUT)

   component PREP_STAGE
      port (
         X : in STD_LOGIC_VECTOR(31 downto 0);
         Y : in STD_LOGIC_VECTOR(31 downto 0);
         FLAG : out STD_LOGIC_VECTOR(1 downto 0);
         S : out STD_LOGIC;
         EXP_X : out STD_LOGIC_VECTOR(7 downto 0);
         EXP_Y : out STD_LOGIC_VECTOR(7 downto 0);
         FIXED_MANT_X : out STD_LOGIC_VECTOR(23 downto 0);
         FIXED_MANT_Y : out STD_LOGIC_VECTOR(23 downto 0)
      );
   end component;
   --Inputs
   signal X : STD_LOGIC_VECTOR(31 downto 0);
   signal Y : STD_LOGIC_VECTOR(31 downto 0);

   --Outputs
   signal FLAG : STD_LOGIC_VECTOR(1 downto 0);
   signal S : STD_LOGIC;
   signal EXP_X : STD_LOGIC_VECTOR(7 downto 0);
   signal EXP_Y : STD_LOGIC_VECTOR(7 downto 0);
   signal FIXED_MANT_X : STD_LOGIC_VECTOR(23 downto 0);
   signal FIXED_MANT_Y : STD_LOGIC_VECTOR(23 downto 0);
begin

   -- Instantiate the Unit Under Test (UUT)
   uut : PREP_STAGE port map(
      X => X,
      Y => Y,
      FLAG => FLAG,
      S => S,
      EXP_X => EXP_X,
      EXP_Y => EXP_Y,
      FIXED_MANT_X => FIXED_MANT_X,
      FIXED_MANT_Y => FIXED_MANT_Y
   );

   -- Stimulus process
   process
   begin
      -- EDGE: ZERO
      X <= "00000000000000000000000000000000";
      Y <= "10011100100101000011010001111011";
      wait for 20 ns;

      -- EDGE: INF
      X <= "01111111100000000000000000000000";
      Y <= "10011100111110100001101000111101";
      wait for 20 ns;

      -- EDGE: NAN
      X <= "01111101100000000001000000010000";
      Y <= "01111111100000000001000000000000";
      wait for 20 ns;
      -- EDGE: BOTH DENORM
      X <= "00000000000000000101000000000000";
      Y <= "00000000000000000101000000110000";
      wait for 20 ns;

      -- EDGE: BOTH DENORM
      X <= "00000000000000000101000000000000";
      Y <= "00000000000000000101000000110000";
      wait for 20 ns;

      -- NEG*POS - 
      X <= "10000000000000000101000000000000"; --DENORM NEG
      Y <= "00100100000000000101000000000000"; -- NORM POS
      wait for 20 ns;

      -- NEG*NEG - 
      X <= "10000000000000000101000000000000"; --DENORM NEG
      Y <= "10100100000000000101000000000000"; -- NORM NEG
      wait;

      -- 1*1
      X <= "00111111100000000000000000000000";
      Y <= "00111111100000000000000000000000";
   end process;

end;