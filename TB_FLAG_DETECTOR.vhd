
library ieee;
use ieee.std_logic_1164.all;

entity TB_FLAG_DETECTOR is
end TB_FLAG_DETECTOR;

architecture behavior of TB_FLAG_DETECTOR is

   -- Component Declaration for the Unit Under Test (UUT)

   component FLAG_DETECTOR
      port (
         FLAG : in STD_LOGIC_VECTOR(1 downto 0);
         RES : in STD_LOGIC_VECTOR(31 downto 0);
         RES_FINAL : out STD_LOGIC_VECTOR(31 downto 0);
         INVALID : out STD_LOGIC
      );
   end component;
   --Inputs
   signal FLAG : STD_LOGIC_VECTOR(1 downto 0);
   signal RES : STD_LOGIC_VECTOR(31 downto 0);

   --Outputs
   signal RES_FINAL : STD_LOGIC_VECTOR(31 downto 0);
   signal INVALID : STD_LOGIC;

begin

   -- Instantiate the Unit Under Test (UUT)
   uut : FLAG_DETECTOR port map(
      FLAG => FLAG,
      RES => RES,
      RES_FINAL => RES_FINAL,
      INVALID => INVALID
   );

   -- Stimulus process
   stim_proc : process
   begin

      -- Flag di zero, expected 0
      FLAG <= "11";
      RES <= "00100110111110011110000101010011";
      wait for 20 ns;

      -- Flag di infinito con numero positivo, expected infinito con 0 davanti
      FLAG <= "01";
      RES <= "00100110111110011110000101010011";
      wait for 20 ns;

      -- Flag di infinito con numero negativo, expected infinito con 1 davanti
      FLAG <= "01";
      RES <= "10100110111011110001111101010010";
      wait for 20 ns;

      -- Flag di invalid con numero qualunque, expected flag a 1 e numero mantenuto
      FLAG <= "10";
      RES <= "10100110111011110001111101010010";
      wait for 20 ns;

      -- NoFlag, expected res mantenuto
      FLAG <= "00";
      RES <= "10100110111011110001111101010010";
      wait;

   end process;

end;