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

        elsif (CLA_result(9) = '0') then
            case EXP_IN is
                when "1111101010" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "00000000000000000000001";
                when "1111101011" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "0000000000000000000001" & MANT_IN(22 downto 22);
                when "1111101100" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "000000000000000000001" & MANT_IN(22 downto 21);
                when "1111101101" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "00000000000000000001" & MANT_IN(22 downto 20);
                when "1111101110" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "0000000000000000001" & MANT_IN(22 downto 19);
                when "1111101111" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "000000000000000001" & MANT_IN(22 downto 18);
                when "1111110000" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "00000000000000001" & MANT_IN(22 downto 17);
                when "1111110001" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "0000000000000001" & MANT_IN(22 downto 16);
                when "1111110010" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "000000000000001" & MANT_IN(22 downto 15);
                when "1111110011" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "00000000000001" & MANT_IN(22 downto 14);
                when "1111110100" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "0000000000001" & MANT_IN(22 downto 13);
                when "1111110101" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "000000000001" & MANT_IN(22 downto 12);
                when "1111110110" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "00000000001" & MANT_IN(22 downto 11);
                when "1111110111" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "0000000001" & MANT_IN(22 downto 10);
                when "1111111000" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "000000001" & MANT_IN(22 downto 9);
                when "1111111001" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "00000001" & MANT_IN(22 downto 8);
                when "1111111010" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "0000001" & MANT_IN(22 downto 7);
                when "1111111011" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "000001" & MANT_IN(22 downto 6);
                when "1111111100" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "00001" & MANT_IN(22 downto 5);
                when "1111111101" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "0001" & MANT_IN(22 downto 4);
                when "1111111110" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "001" & MANT_IN(22 downto 3);
                when "1111111111" =>
                    EXP_OUT <= "00000000";
                    MANT_OUT <= "01" & MANT_IN(22 downto 2);
                when others =>
                    EXP_OUT <= EXP_IN(7 downto 0);
                    MANT_OUT <= MANT_IN;
            end case;
        end if;
    end process;

end architecture RTL;