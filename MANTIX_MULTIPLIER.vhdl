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
            N : POSITIVE
        );
        port (
            X, Y, Z : in STD_LOGIC_VECTOR(N - 1 downto 0);
            S : out STD_LOGIC_VECTOR(N downto 0);
            Cout : out STD_LOGIC
        );
    end component CSA;

    type partial_product_array is array (0 to N - 1) of STD_LOGIC_VECTOR(2 * N - 1 downto 0); --array of 24 partial products of 48 bits
    signal partial_products : partial_product_array;
    signal S : STD_LOGIC_VECTOR(2 * N - 1 downto 0); --sum of partial products
    type partial_sum_1_array is array (0 to 7) of STD_LOGIC_VECTOR(2 * N - 1 downto 0); --array of 8 partial sums of 48 bits
    signal partial_sum_1 : partial_sum_1_array;
    type partial_sum_2_array is array (0 to 3) of STD_LOGIC_VECTOR(2 * N - 1 downto 0); --array of 8 partial sums of 48 bits
    signal partial_sum_2 : partial_sum_2_array;
    signal Cout : STD_LOGIC;
begin
    -- Generate partial products, padding the result to do the sum
    gen_partial_products : for i in 0 to N - 1 generate
        partial_products(i) <= (others => '0') when B(i) = '0' else
        A; --when B(i) is 0, partial product is 48 zeros
        partial_products(i) <= (23 - i downto 0 => '0') & A & (others => '0'); --create a partial product by appending 23-i zeros to A and i zeros to the right
    end generate;

    -- Because a CSA sum three numbers at a time, we'll need 8 CSA to sum 24 numbers
    GEN_CSA : for I in 0 to 7 generate
        CSA_1 : CSA
        generic map(N => 48)
        port map(
            X => partial_products(I * 3),
            Y => partial_products(I * 3 + 1),
            Z => partial_products(I * 3 + 2),
            S => partial_sum_1(I)
        );
    end generate GEN_CSA;

    partial_sum_1(7) <= "000000000000000000000000000000000000000000000000"; --initialize the last partial sum to 48 zeros

    GEN_CSA_2 : for J in 0 to 2 generate
        CSA_2 : CSA
        generic map(N => 48)
        port map(
            X => partial_sum_1(J * 3),
            Y => partial_sum_1(J * 3 + 1),
            Z => partial_sum_1(J * 3 + 2),
            S => partial_sum_2(J)
        );
    end generate GEN_CSA_2;

    CSA_3 : CSA
    generic map(N => 48)
    port map(
        X => partial_sum_2(0),
        Y => partial_sum_2(1),
        Z => partial_sum_2(2),
        S => P
    );

end architecture RTL;