library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BIAS_SUBTRACTOR is
    generic (
        BIAS : integer := 127
    );
    port (
        exp_sum : in  integer range -127 to 128;
        exp_out : out integer range -127 to 128
    );
end entity BIAS_SUBTRACTOR;

architecture RTL of BIAS_SUBTRACTOR is
begin
    exp_out <= exp_sum - BIAS;
end architecture RTL;