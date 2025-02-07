library ieee;
use ieee.std_logic_1164.all;

entity MANTIX_MULTIPLIER is
    port (
        A, B : in STD_LOGIC_VECTOR(23 downto 0);
        P : out STD_LOGIC_VECTOR(47 downto 0)
    );
end entity MANTIX_MULTIPLIER;

architecture RTL of MANTIX_MULTIPLIER is
    component CSA_24 is
        port (
            O_1 : in STD_LOGIC_VECTOR (46 downto 0);
            O_2 : in STD_LOGIC_VECTOR (46 downto 0);
            O_3: in STD_LOGIC_VECTOR (46 downto 0);
            O_4: in STD_LOGIC_VECTOR (46 downto 0);
            O_5: in STD_LOGIC_VECTOR (46 downto 0);
            O_6: in STD_LOGIC_VECTOR (46 downto 0);
            O_7: in STD_LOGIC_VECTOR (46 downto 0);
            O_8: in STD_LOGIC_VECTOR (46 downto 0);
            O_9: in STD_LOGIC_VECTOR (46 downto 0);
            O_10: in STD_LOGIC_VECTOR (46 downto 0);
            O_11: in STD_LOGIC_VECTOR (46 downto 0);
            O_12: in STD_LOGIC_VECTOR (46 downto 0);
            O_13: in STD_LOGIC_VECTOR (46 downto 0);
            O_14: in STD_LOGIC_VECTOR (46 downto 0);
            O_15: in STD_LOGIC_VECTOR (46 downto 0);
            O_16: in STD_LOGIC_VECTOR (46 downto 0);
            O_17: in STD_LOGIC_VECTOR (46 downto 0);
            O_18: in STD_LOGIC_VECTOR (46 downto 0);
            O_19: in STD_LOGIC_VECTOR (46 downto 0);
            O_20: in STD_LOGIC_VECTOR (46 downto 0);
            O_21: in STD_LOGIC_VECTOR (46 downto 0);
            O_22: in STD_LOGIC_VECTOR (46 downto 0);
            O_23: in STD_LOGIC_VECTOR (46 downto 0);
            O_24: in STD_LOGIC_VECTOR (46 downto 0);
            RES : out STD_LOGIC_VECTOR (54 downto 0)
        );
    end component CSA_24;

    type partial_product_array is array (0 to 23) of STD_LOGIC_VECTOR(46 downto 0); --array di 24 partial products da 47 bits
    signal partial_products : partial_product_array;

    signal TEMP_A : STD_LOGIC_VECTOR(23 downto 0);
    signal TEMP_B : STD_LOGIC_VECTOR(23 downto 0);
    signal TEMP_P : STD_LOGIC_VECTOR(54 downto 0);

begin

    TEMP_A <= A;
    TEMP_B <= B;

    partial_products(0) <= "00000000000000000000000" & TEMP_A when TEMP_B(0) = '1' else
    "00000000000000000000000000000000000000000000000"; -- Per i=0, non ci sono zeri a destra
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
    "00000000000000000000000000000000000000000000000"; --Ultimo caso, non ci sono zeri a sinistra

    CSA_1: CSA_24
    port map(
        O_1 => partial_products(0),
        O_2 => partial_products(1),
        O_3 => partial_products(2),
        O_4 => partial_products(3),
        O_5 => partial_products(4),
        O_6 => partial_products(5),
        O_7 => partial_products(6),
        O_8 => partial_products(7),
        O_9 => partial_products(8),
        O_10 => partial_products(9),
        O_11 => partial_products(10),
        O_12 => partial_products(11),
        O_13 => partial_products(12),
        O_14 => partial_products(13),
        O_15 => partial_products(14),
        O_16 => partial_products(15),
        O_17 => partial_products(16),
        O_18 => partial_products(17),
        O_19 => partial_products(18),
        O_20 => partial_products(19),
        O_21 => partial_products(20),
        O_22 => partial_products(21),
        O_23 => partial_products(22),
        O_24 => partial_products(23),
        RES => TEMP_P
    );

    P <= TEMP_P(47 downto 0);

end architecture RTL;