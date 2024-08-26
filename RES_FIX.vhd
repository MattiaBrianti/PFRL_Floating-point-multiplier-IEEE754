library ieee;
use ieee.std_logic_1164.all;

entity RES_FIX is
    port (
        EXP_IN : in STD_LOGIC_VECTOR(9 downto 0);
        MANT_IN : in STD_LOGIC_VECTOR(22 downto 0);
        EXP_OUT : out STD_LOGIC_VECTOR(7 downto 0);
        MANT_OUT : out STD_LOGIC_VECTOR(22 downto 0);
    );
end entity RES_FIX;

architecture RTL of RES_FIX is

    component CLA is
        generic (N : INTEGER := 10);
        port (
            X : in STD_LOGIC_VECTOR(N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR(N - 1 downto 0);
            S : out STD_LOGIC_VECTOR(N downto 0)
        );
    end component CLA;

begin

    signal CLA_result : STD_LOGIC_VECTOR(N downto 0); -- Segnale intermedio da 11 bit

    U1_SOMMA : CLA
    generic map(N => 10)
    port map(
        X => "0000010110",
        Y => EXP_IN,
        S => CLA_result
    );

    -- caso Overflow
    EXP_OUT = "11111111" and MANT_OUT = "00000000000000000000000" when (EXP_IN(9) = "0" and (EXP_IN(8) = "1" or EXP_IN(7) = "1"))

    -- Caso underflow
    EXP_OUT = "00000000" and MANT_OUT = "00000000000000000000000" when CLA_result(9) = '1' else
    -- Caso denormalizzato
    EXP_OUT = "00000000" and MANT_OUT = "0" & MANT_IN(8 downto 0) when CLA_result(8) = '1' else
end architecture RTL;