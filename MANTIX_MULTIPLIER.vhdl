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
            S : out STD_LOGIC_VECTOR(48 downto 0)
        );
    end component CSA;

    type partial_product_array is array (0 to 23) of STD_LOGIC_VECTOR(46 downto 0); --array of 24 partial products of 48 bits
    signal partial_products : partial_product_array;
    
    type partial_sum_1_array is array (0 to 8) of STD_LOGIC_VECTOR(48 downto 0); --array of 8 partial sums of 49 bits
    signal partial_sum_1 : partial_sum_1_array;
	 
	 type partial_sum_1_array_fixed is array (0 to 8) of STD_LOGIC_VECTOR(47 downto 0); --array of 8 partial sums of 49 bits
    signal partial_sum_1_fixed : partial_sum_1_array_fixed;
	 
    type partial_sum_2_array is array (0 to 2) of STD_LOGIC_VECTOR(48 downto 0); --array of 3 partial sums of 49 bits
    signal partial_sum_2 : partial_sum_2_array;
	 
	 type partial_sum_2_array_fixed is array (0 to 8) of STD_LOGIC_VECTOR(47 downto 0); --array of 8 partial sums of 49 bits
    signal partial_sum_2_fixed : partial_sum_2_array_fixed;
    
	 
begin
    partial_products(0) <= (others => '0') when B(0) = '0' else
    "00000000000000000000000" & A; -- For i=0, no zeros on the right
    partial_products(23) <= (others => '0') when B(23) = '0' else
    A & "00000000000000000000000"; --Last case

    gen_partial_products : for i in 1 to 23 generate
        partial_products(i) <= (others => '0') when B(i) = '0' else
        (23 - i => '0') & A & (i => '0');
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
        S => P
    );

end architecture RTL;