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
            X, Y, Z : in STD_LOGIC_VECTOR(46 downto 0);
            S : out STD_LOGIC_VECTOR(47 downto 0)
        );
    end component CSA;

    type partial_product_array is array (0 to N - 1) of STD_LOGIC_VECTOR(2 * N - 1 downto 0); --array of 24 partial products of 48 bits
    signal partial_products : partial_product_array;
    --signal S : STD_LOGIC_VECTOR(2 * N - 1 downto 0); --sum of partial products
    type partial_sum_1_array is array (0 to 7) of STD_LOGIC_VECTOR(2 * N downto 0); --array of 8 partial sums of 48 bits
    signal partial_sum_1 : partial_sum_1_array;
    type partial_sum_2_array is array (0 to 3) of STD_LOGIC_VECTOR(2 * N  downto 0); --array of 8 partial sums of 48 bits
    signal partial_sum_2 : partial_sum_2_array;
    signal Cout : STD_LOGIC;
begin
    gen_partial_products : for i in 0 to 23 generate
    gen_if : if (i = 0) generate
        partial_products(i) <= (others => '0') when B(i) = '0' else (46 downto 24 + i => '0') & A; -- For i=0, no zeros on the right
    end generate;
    gen_else : if (i /= 0) generate
        partial_products(i) <= (46 downto 24 + i => '0') & A & (i - 1 downto 0 => '0');
    end generate;
end generate gen_partial_products;
    -- Because a CSA sum three numbers at a time, we'll need 8 CSA to sum 24 numbers
    GEN_CSA : for I in 0 to 7 generate
        CSA_1 : CSA
        generic map(N => 47) -- il problema 'e che qua sto dicendo che s sara di 50 bit, come da specifica del CSA
        port map(
            X => partial_products(I * 3),
            Y => partial_products(I * 3 + 1),
            Z => partial_products(I * 3 + 2),
            S => partial_sum_1(I)
        );
    end generate GEN_CSA;

    partial_sum_1(7) <= "00000000000000000000000000000000000000000000000"; --initialize the last partial sum to 48 zeros

    GEN_CSA_2 : for J in 0 to 2 generate
        CSA_2 : CSA
        generic map(N => 47)
        port map(
            X => partial_sum_1(J * 3),
            Y => partial_sum_1(J * 3 + 1),
            Z => partial_sum_1(J * 3 + 2),
            S => partial_sum_2(J)
        );
    end generate GEN_CSA_2;

    CSA_3 : CSA
    generic map(N => 47)
    port map(
        X => partial_sum_2(0),
        Y => partial_sum_2(1),
        Z => partial_sum_2(2),
        S => P
    );

end architecture RTL;
