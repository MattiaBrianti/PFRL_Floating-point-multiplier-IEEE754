-- Work in progress

library ieee;
use ieee.std_logic_1164.all;

entity EDGE_CASES_CHECK is
    port(
        EXP_X 	: in  std_logic_vector (7 downto 0); -- 8-bit exponent
        EXP_Y 	: in  std_logic_vector (7 downto 0); -- 8-bit exponent
        MANT_X 	: in  std_logic_vector (22 downto 0); -- 23-bit mantissa
        MANT_Y 	: in  std_logic_vector (22 downto 0); -- 23-bit mantissa
        FLAG    : out std_logic_vector (1 downto 0) -- 2-bit flag for INF, NAN, ZERO and DENORM
    );
end EDGE_CASES_CHECK;

-- '00' zero
-- '01' infinity
-- '10' Nan (Not a number)
-- '11' Denormalized

architecture RTL of EDGE_CASES_CHECK is
    signal T1 : std_logic;
    signal T2 : std_logic;
    signal T3 : std_logic;
    signal T4 : std_logic;
begin
    T1 <= EXP_X(7) and EXP_X(6) and EXP_X(5) and EXP_X(4) and EXP_X(3) and EXP_X(2) and EXP_X(1) and EXP_X(0);
    T2 <= EXP_Y(7) and EXP_Y(6) and EXP_Y(5) and EXP_Y(4) and EXP_Y(3) and EXP_Y(2) and EXP_Y(1) and EXP_Y(0);
    T3 <= EXP_X(7) or EXP_X(6) or EXP_X(5) or EXP_X(4) or EXP_X(3) or EXP_X(2) or EXP_X(1) or EXP_X(0);
    T4 <= EXP_Y(7) or EXP_Y(6) or EXP_Y(5) or EXP_Y(4) or EXP_Y(3) or EXP_Y(2) or EXP_Y(1) or EXP_Y(0);

end EDGE_CASES_CHECK;