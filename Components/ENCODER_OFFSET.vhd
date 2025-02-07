library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
 
 
entity ENCODER_OFFSET is
    port(
        MANT_IN : in  std_logic_vector(23 downto 0);
        OFFSET : out std_logic_vector(4 downto 0)
    );
end ENCODER_OFFSET;
 
architecture rtl of ENCODER_OFFSET is
begin
    OFFSET <= "00001"  when MANT_IN(23)='1'
         else "00010"  when MANT_IN(23 downto 22)="01"
         else "00011"  when MANT_IN(23 downto 21)="001"
         else "00100"  when MANT_IN(23 downto 20)="0001"
         else "00101"  when MANT_IN(23 downto 19)="00001"
         else "00110"  when MANT_IN(23 downto 18)="000001"
         else "00111"  when MANT_IN(23 downto 17)="0000001"
         else "01000"  when MANT_IN(23 downto 16)="00000001"
         else "01001"  when MANT_IN(23 downto 15)="000000001"
         else "01010"  when MANT_IN(23 downto 14)="0000000001"
         else "01011"  when MANT_IN(23 downto 13)="00000000001"
         else "01100"  when MANT_IN(23 downto 12)="000000000001"
         else "01101"  when MANT_IN(23 downto 11)="0000000000001"
         else "01110"  when MANT_IN(23 downto 10)="00000000000001"
         else "01111"  when MANT_IN(23 downto 9)="000000000000001"
         else "10000"  when MANT_IN(23 downto 8)="0000000000000001"
         else "10001"  when MANT_IN(23 downto 7)="00000000000000001"
         else "10010"  when MANT_IN(23 downto 6)="000000000000000001"
         else "10011"  when MANT_IN(23 downto 5)="0000000000000000001"
         else "10100"  when MANT_IN(23 downto 4)="00000000000000000001"
         else "10101"  when MANT_IN(23 downto 3)="000000000000000000001"
         else "10110"  when MANT_IN(23 downto 2)="0000000000000000000001"
         else "10111"  when MANT_IN(23 downto 1)="00000000000000000000001"
         else "11000"  when MANT_IN(23 downto 0)="000000000000000000000001"
         else "11001"; -- caso in cui non troviamo un uno nei 24 bit della mantissa 
 
end rtl;