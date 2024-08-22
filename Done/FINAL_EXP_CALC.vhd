library ieee;
use ieee.std_logic_1164.all;

entity FINAL_EXP_CALC is
    generic (
        N : positive := 24
    );
    port (
        EXP : in  std_logic_vector(9 downto 0);
        OFFSET : in  std_logic_vector(4 downto 0);
        SUB : in std_logic;
        S   : out std_logic_vector;
    );
    end entity FINAL_EXP_CALC;

    architecture RTL of FINAL_EXP_CALC is

    component CLA is
        generic (N : INTEGER := 10);
        port (
            X : in STD_LOGIC_VECTOR(N - 1 downto 0);
            Y : in STD_LOGIC_VECTOR(N - 1 downto 0);
            S : out STD_LOGIC_VECTOR(N downto 0) -- Output di 11 bit
        );
    end component CLA;

    begin 
        

    end architecture RTL;
