library ieee;
use ieee.std_logic_1164.all;

entity PREP_STAGE is
   port (
      X : in STD_LOGIC_VECTOR(31 downto 0);
      Y : in STD_LOGIC_VECTOR(31 downto 0);
      FLAG : out STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
      S : out STD_LOGIC;
      EXP_X : out STD_LOGIC_VECTOR (7 downto 0);
      EXP_Y : out STD_LOGIC_VECTOR (7 downto 0);
      FIXED_MANT_X : out STD_LOGIC_VECTOR (23 downto 0); -- 24-bit mantissa
      FIXED_MANT_Y : out STD_LOGIC_VECTOR (23 downto 0) -- 24-bit mantissa
   );
end entity PREP_STAGE;

architecture RTL of PREP_STAGE is

   signal S_X : STD_LOGIC;
   signal S_Y : STD_LOGIC;
   signal MANT_X : STD_LOGIC_VECTOR(22 downto 0);
   signal MANT_Y : STD_LOGIC_VECTOR(22 downto 0);
   signal S_EXP_X : STD_LOGIC_VECTOR(7 downto 0);
   signal S_EXP_Y : STD_LOGIC_VECTOR(7 downto 0);

   component EDGE_CASES_CHECK is
      port (
         EXP_X : in STD_LOGIC_VECTOR (7 downto 0); -- 8-bit exponent
         EXP_Y : in STD_LOGIC_VECTOR (7 downto 0); -- 8-bit exponent
         MANT_X : in STD_LOGIC_VECTOR (22 downto 0); -- 23-bit mantissa
         MANT_Y : in STD_LOGIC_VECTOR (22 downto 0); -- 23-bit mantissa
         FLAG : out STD_LOGIC_VECTOR (1 downto 0) -- 2-bit flag for INF, NAN, ZERO and DENORM
      );
   end component;

   component OPERANDS_SPLITTER is
      port (
         X : in STD_LOGIC_VECTOR (31 downto 0);
         Y : in STD_LOGIC_VECTOR (31 downto 0);
         S_X : out STD_LOGIC;
         S_Y : out STD_LOGIC;
         EXP_X : out STD_LOGIC_VECTOR (7 downto 0);
         EXP_Y : out STD_LOGIC_VECTOR (7 downto 0);
         MANT_X : out STD_LOGIC_VECTOR (22 downto 0);
         MANT_Y : out STD_LOGIC_VECTOR (22 downto 0)
      );
   end component;

   component MANTIX_FIXER is
      port (
         MANT_X : in STD_LOGIC_VECTOR (22 downto 0); -- 23-bit mantissa
         MANT_Y : in STD_LOGIC_VECTOR (22 downto 0); -- 23-bit mantissa
         EXP_X : in STD_LOGIC_VECTOR (7 downto 0); -- 8-bit exponent
         EXP_Y : in STD_LOGIC_VECTOR (7 downto 0); -- 8-bit exponent

         FIXED_MANT_X : out STD_LOGIC_VECTOR (23 downto 0); -- 24-bit mantissa
         FIXED_MANT_Y : out STD_LOGIC_VECTOR (23 downto 0) -- 24-bit mantissa
      );
   end component;

begin

   U1 : OPERANDS_SPLITTER
   port map(
      X => X,
      Y => Y,
      S_X => S_X,
      S_Y => S_Y,
      EXP_X => S_EXP_X,
      EXP_Y => S_EXP_Y,
      MANT_X => MANT_X,
      MANT_Y => MANT_Y
   );

   U2 : MANTIX_FIXER
   port map(
      MANT_X => MANT_X,
      MANT_Y => MANT_Y,
      EXP_X => S_EXP_X,
      EXP_Y => S_EXP_Y,
      FIXED_MANT_X => FIXED_MANT_X,
      FIXED_MANT_Y => FIXED_MANT_Y
   );

   U3 : EDGE_CASES_CHECK
   port map(
      EXP_X => S_EXP_X,
      EXP_Y => S_EXP_Y,
      MANT_X => MANT_X,
      MANT_Y => MANT_Y,
      FLAG => FLAG
   );

   S <= S_X xor S_Y;
   EXP_X <= S_EXP_X;
   EXP_Y <= S_EXP_Y;

end RTL;