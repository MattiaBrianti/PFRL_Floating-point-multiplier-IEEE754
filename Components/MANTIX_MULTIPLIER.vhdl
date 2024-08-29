
library ieee;
use ieee.std_logic_1164.all;

entity MANTIX_MULTIPLIER is
    generic (
        N : POSITIVE := 24
    );
    port (
        A, B : in STD_LOGIC_VECTOR(N - 1 downto 0);
        P : out STD_LOGIC_VECTOR(2 * N - 1 downto 0)
    );
end entity MANTIX_MULTIPLIER;

architecture RTL of MANTIX_MULTIPLIER is
    component CSA is
        generic (
            N : INTEGER
        );
        port (
            X, Y, Z : in STD_LOGIC_VECTOR(N - 1 downto 0);
            S : out STD_LOGIC_VECTOR(N + 1 downto 0)
        );
    end component CSA;

    type partial_product_array is array (0 to 23) of STD_LOGIC_VECTOR(46 downto 0); --array of 24 partial products of 48 bits
    signal partial_products : partial_product_array;

    type partial_sum_1_array is array (0 to 8) of STD_LOGIC_VECTOR(48 downto 0); --array of 8 partial sums of 49 bits
    signal partial_sum_1 : partial_sum_1_array;

    type partial_sum_1_array_fixed is array (0 to 8) of STD_LOGIC_VECTOR(47 downto 0); --array of 8 partial sums of 48 bits
    signal partial_sum_1_fixed : partial_sum_1_array_fixed;

    type partial_sum_2_array is array (0 to 2) of STD_LOGIC_VECTOR(49 downto 0); --array of 3 partial sums of 49 bits
    signal partial_sum_2 : partial_sum_2_array;

    type partial_sum_2_array_fixed is array (0 to 8) of STD_LOGIC_VECTOR(47 downto 0); --array of 8 partial sums of 49 bits
    signal partial_sum_2_fixed : partial_sum_2_array_fixed;

    signal P_TEMP : STD_LOGIC_VECTOR(49 downto 0);
    signal TEMP_A : STD_LOGIC_VECTOR(23 downto 0);
    signal TEMP_B : STD_LOGIC_VECTOR(23 downto 0);

begin

    TEMP_A <= A;
    TEMP_B <= B;

    partial_products(0) <= "00000000000000000000000" & TEMP_A when TEMP_B(0) = '1' else
    "00000000000000000000000000000000000000000000000"; -- For i=0, no zeros on the right
    partial_products(1) <= "0000000000000000000000" & TEMP_A & '0' when TEMP_B(1) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(2) <= "000000000000000000000" & TEMP_A & "00" when TEMP_B(2) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(3) <= "00000000000000000000" & TEMP_A & "000" when TEMP_B(3) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(4) <= "0000000000000000000" & TEMP_A & "0000" when TEMP_B(4) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(5) <= "000000000000000000" & TEMP_A & "00000" when TEMP_B(5) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(6) <= "00000000000000000" & TEMP_A & "000000" when TEMP_B(6) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(7) <= "0000000000000000" & TEMP_A & "0000000" when TEMP_B(7) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(8) <= "000000000000000" & TEMP_A & "00000000" when TEMP_B(8) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(9) <= "00000000000000" & TEMP_A & "000000000" when TEMP_B(9) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(10) <= "0000000000000" & TEMP_A & "0000000000" when TEMP_B(10) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(11) <= "000000000000" & TEMP_A & "00000000000" when TEMP_B(11) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(12) <= "00000000000" & TEMP_A & "000000000000" when TEMP_B(12) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(13) <= "0000000000" & TEMP_A & "0000000000000" when TEMP_B(13) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(14) <= "000000000" & TEMP_A & "00000000000000" when TEMP_B(14) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(15) <= "00000000" & TEMP_A & "000000000000000" when TEMP_B(15) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(16) <= "0000000" & TEMP_A & "0000000000000000" when TEMP_B(16) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(17) <= "000000" & TEMP_A & "00000000000000000" when TEMP_B(17) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(18) <= "00000" & TEMP_A & "000000000000000000" when TEMP_B(18) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(19) <= "0000" & TEMP_A & "0000000000000000000" when TEMP_B(19) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(20) <= "000" & TEMP_A & "00000000000000000000" when TEMP_B(20) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(21) <= "00" & TEMP_A & "000000000000000000000" when TEMP_B(21) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(22) <= "0" & TEMP_A & "0000000000000000000000" when TEMP_B(22) = '1' else
    "00000000000000000000000000000000000000000000000";
    partial_products(23) <= TEMP_A & "00000000000000000000000" when TEMP_B(23) = '1' else
    "00000000000000000000000000000000000000000000000"; --Last case, no zeros on the left
    -- gen_partial_products : for i in 1 to 23 generate
    --   partial_products(i) <= "00000000000000000000000000000000000000000000000" when TEMP_B(i) = '0' else
    --   (23 - i => '0') & TEMP_A & (i => '0');
    --  end generate gen_partial_products;

    --Because a CSA sum three numbers at a time, we'll need 8 CSA to sum 24 numbers
    GEN_CSA : for I in 0 to 7 generate
        CSA_1 : CSA
        generic map(N => 47)
        port map(
            X => partial_products(I * 3),
            Y => partial_products(I * 3 + 1),
            Z => partial_products(I * 3 + 2),
            S => partial_sum_1(I)
        );
    end generate GEN_CSA;

    gen_partial_sum_1_fixed : for i in 0 to 7 generate
        partial_sum_1_fixed(i) <= partial_sum_1(i)(47 downto 0);
    end generate gen_partial_sum_1_fixed;

    partial_sum_1_fixed(8) <= "000000000000000000000000000000000000000000000000"; --initialize the last partial sum to 48 zeros

    --solo la partial sum (7) potra avere 48 bit
    GEN_CSA_2 : for J in 0 to 2 generate
        CSA_2 : CSA
        generic map(N => 48)
        port map(
            X => partial_sum_1_fixed(J * 3),
            Y => partial_sum_1_fixed(J * 3 + 1),
            Z => partial_sum_1_fixed(J * 3 + 2),
            S => partial_sum_2(J)
        );
    end generate GEN_CSA_2;

    gen_partial_sum_2_fixed : for i in 0 to 2 generate
        partial_sum_2_fixed(i) <= partial_sum_2(i)(47 downto 0);
    end generate gen_partial_sum_2_fixed;

    CSA_3 : CSA
    generic map(N => 48)
    port map(
        X => partial_sum_2_fixed(0),
        Y => partial_sum_2_fixed(1),
        Z => partial_sum_2_fixed(2),
        S => P_TEMP
    );

    P <= P_TEMP(47 downto 0);

end architecture RTL;