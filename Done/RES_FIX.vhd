library ieee;
use ieee.std_logic_1164.all;

entity RES_FIX is
    port (
        EXP_IN : in STD_LOGIC_VECTOR(9 downto 0);
        MANT_IN : in STD_LOGIC_VECTOR(22 downto 0);
        EXP_OUT : out STD_LOGIC_VECTOR(7 downto 0);
        MANT_OUT : out STD_LOGIC_VECTOR(22 downto 0)
    );
end entity RES_FIX;

architecture RTL of RES_FIX is
    signal CLA_result : STD_LOGIC_VECTOR(10 downto 0); -- Segnale intermedio da 11 bit

    component CLA is
        generic (N : INTEGER := 10);
        port (
            X : in STD_LOGIC_VECTOR(N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR(N - 1 downto 0);
            S : out STD_LOGIC_VECTOR(N downto 0)
        );
    end component CLA;

begin

    U1_SOMMA : CLA
    generic map(N => 10)
    port map(
        X => "0000010110",
        Y => EXP_IN,
        S => CLA_result
    );

    -- Assegnazioni con corretta sintassi VHDL
    process (EXP_IN, MANT_IN, CLA_result)
    begin
        -- Caso Overflow
        if (EXP_IN(9) = '0' and (EXP_IN(8) = '1' or (EXP_IN = "0011111111"))) then
            EXP_OUT <= "11111111";
            MANT_OUT <= "00000000000000000000000";

            -- Caso Underflow
        elsif (CLA_result(9) = '1') then
            EXP_OUT <= "00000000";
            MANT_OUT <= "00000000000000000000000";

            -- Caso Denormalizzato
        elsif (CLA_result = "10000000001") then
            EXP_OUT <= "00000000";
            MANT_OUT <= '0' & MANT_IN(22 downto 1);

        elsif (CLA_result = "10000000010") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "00" & MANT_IN(22 downto 2);

        elsif (CLA_result = "10000000011") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "000" & MANT_IN(22 downto 3);

        elsif (CLA_result = "10000000100") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "0000" & MANT_IN(22 downto 4);

        elsif (CLA_result = "10000000101") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "00000" & MANT_IN(22 downto 5);

        elsif (CLA_result = "10000000110") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "000000" & MANT_IN(22 downto 6);

        elsif (CLA_result = "10000000111") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "0000000" & MANT_IN(22 downto 7);

        elsif (CLA_result = "10000001000") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "00000000" & MANT_IN(22 downto 8);

        elsif (CLA_result = "10000001001") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "000000000" & MANT_IN(22 downto 9);

        elsif (CLA_result = "10000001010") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "0000000000" & MANT_IN(22 downto 10);

        elsif (CLA_result = "10000001011") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "00000000000" & MANT_IN(22 downto 11);

        elsif (CLA_result = "10000001100") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "000000000000" & MANT_IN(22 downto 12);

        elsif (CLA_result = "10000001101") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "0000000000000" & MANT_IN(22 downto 13);

        elsif (CLA_result = "10000001110") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "00000000000000" & MANT_IN(22 downto 14);

        elsif (CLA_result = "10000001111") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "000000000000000" & MANT_IN(22 downto 15);

        elsif (CLA_result = "10000010000") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "0000000000000000" & MANT_IN(22 downto 16);

        elsif (CLA_result = "10000010001") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "00000000000000000" & MANT_IN(22 downto 17);

        elsif (CLA_result = "10000010010") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "000000000000000000" & MANT_IN(22 downto 18);

        elsif (CLA_result = "10000010011") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "0000000000000000000" & MANT_IN(22 downto 19);

        elsif (CLA_result = "10000010100") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "00000000000000000000" & MANT_IN(22 downto 20);

        elsif (CLA_result = "10000010101") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "000000000000000000000" & MANT_IN(22 downto 21);

        elsif (CLA_result = "10000010110") then
            EXP_OUT <= "00000000";
            MANT_OUT <= "0000000000000000000000" & MANT_IN(22 downto 22);

            -- Caso normale
        else
            EXP_OUT <= EXP_IN(7 downto 0);
            MANT_OUT <= MANT_IN;
        end if;
    end process;

end architecture RTL;
01001011111101100101000100110101011110011000101