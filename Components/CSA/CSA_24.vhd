library ieee;
use ieee.std_logic_1164.all;

entity CSA_24 is

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
            RES : out STD_LOGIC_VECTOR (55-1 downto 0)
      );
end CSA_24;

architecture RTL of CSA_24 is

      
      component CSBlock is
            generic (
                N : integer := 47
                );
            port (
                  X : in STD_LOGIC_VECTOR (N-1 downto 0);
                  Y : in STD_LOGIC_VECTOR (N-1 downto 0);
                  Z : in STD_LOGIC_VECTOR (N-1 downto 0);
                  T : out STD_LOGIC_VECTOR (N downto 0);
                  CS : out STD_LOGIC_VECTOR (N downto 0)
            );
      end component;

		component CLA_54 is
		port (
		 X, Y : in  std_logic_vector(53 downto 0);
		 S    : out std_logic_vector(53 downto 0);
		 Cin  : in  std_logic;
		 Cout : out std_logic
		);
		end component;
      

    type temporary_array is array (0 to 7) of STD_LOGIC_VECTOR(47 downto 0); --array of temporary results from the CSBlock
    signal temporary_res : temporary_array;

    type carry_save_array is array (0 to 7) of STD_LOGIC_VECTOR(47 downto 0); --array of carrysave results from the CSBlock
    signal carry_save : carry_save_array;

    type temporary_array_1 is array (0 to 4) of STD_LOGIC_VECTOR(49-1 downto 0); --array of temporary results from the CSBlock
    signal temporary_res_1 : temporary_array_1;

    type carry_save_array_1 is array (0 to 4) of STD_LOGIC_VECTOR(49-1 downto 0); --array of carrysave results from the CSBlock
    signal carry_save_1 : carry_save_array_1;

    type temporary_array_2 is array (0 to 2) of STD_LOGIC_VECTOR(50-1 downto 0); --array of temporary results from the CSBlock
    signal temporary_res_2 : temporary_array_2;

    type carry_save_array_2 is array (0 to 2) of STD_LOGIC_VECTOR(50-1 downto 0); --array of carrysave results from the CSBlock
    signal carry_save_2 : carry_save_array_2;

    signal temporary_res_3_0 : STD_LOGIC_VECTOR(51-1 downto 0);
    signal temporary_res_3_1 : STD_LOGIC_VECTOR(51-1 downto 0);
    signal carry_save_3_0 : STD_LOGIC_VECTOR(51-1 downto 0);
    signal carry_save_3_1 : STD_LOGIC_VECTOR(51-1 downto 0);
    signal temporary_res_4_0 : STD_LOGIC_VECTOR(52-1 downto 0);
    signal temporary_res_4_1 : STD_LOGIC_VECTOR(52-1 downto 0);
    signal carry_save_4_0 : STD_LOGIC_VECTOR(52-1 downto 0);
    signal carry_save_4_1 : STD_LOGIC_VECTOR(52-1 downto 0);
    signal temporary_res_5 : STD_LOGIC_VECTOR(53-1 downto 0);
    signal carry_save_5 : STD_LOGIC_VECTOR(53-1 downto 0);
    signal temporary_res_6 : STD_LOGIC_VECTOR(54-1 downto 0);
    signal carry_save_6 : STD_LOGIC_VECTOR(54-1 downto 0);


    signal carry_save_7_tmp : STD_LOGIC_VECTOR(49-1 downto 0);
    signal temporary_res_1_tmp : STD_LOGIC_VECTOR(50-1 downto 0);
    signal carry_save_1_tmp : STD_LOGIC_VECTOR(50-1 downto 0);
    signal temporary_res_2_tmp : STD_LOGIC_VECTOR(51-1 downto 0);
    signal carry_save_2_tmp : STD_LOGIC_VECTOR(51-1 downto 0);
    signal carry_save_4_1_tmp : STD_LOGIC_VECTOR(53-1 downto 0);
	 signal Final_Cout: STD_LOGIC;
	 signal Temp_RES: STD_LOGIC_VECTOR(54-1 downto 0);

    begin

      carry_save_7_tmp <= '0' & carry_save(7);
      temporary_res_1_tmp <= '0' & temporary_res_1(0);
      carry_save_1_tmp <= '0' & carry_save_1(0);
      temporary_res_2_tmp <= '0' & temporary_res_2(2);
      carry_save_2_tmp <= '0' & carry_save_2(2);
      carry_save_4_1_tmp <= '0' & carry_save_4_1;
      
      --Primo livello composto da 8 CSL (CSBlocks)
    CSBlock_1_0 : CSBlock
    port map(
        X => O_1,
        Y => O_2,
        Z => O_3,
        T => temporary_res(0),
        CS => carry_save(0)
    );

    CSBlock_1_1 : CSBlock
    port map(
        X => O_4,
        Y => O_5,
        Z => O_6,
        T => temporary_res(1),
        CS => carry_save(1)
    );
    
    CSBlock_1_2 : CSBlock
      port map(
            X => O_7,
            Y => O_8,
            Z => O_9,
            T => temporary_res(2),
            CS => carry_save(2)
      );

      CSBlock_1_3 : CSBlock
      port map(
          X => O_10,
          Y => O_11,
          Z => O_12,
          T => temporary_res(3),
          CS => carry_save(3)
      );

      CSBlock_1_4 : CSBlock
      port map(
          X => O_13,
          Y => O_14,
          Z => O_15,
          T => temporary_res(4),
          CS => carry_save(4)
      );

      CSBlock_1_5 : CSBlock
      port map(
          X => O_16,
          Y => O_17,
          Z => O_18,
          T => temporary_res(5),
          CS => carry_save(5)
      );

      CSBlock_1_6 : CSBlock
      port map(
          X => O_19,
          Y => O_20,
          Z => O_21,
          T => temporary_res(6),
          CS => carry_save(6)
      );

      CSBlock_1_7 : CSBlock
      port map(
          X => O_22,
          Y => O_23,
          Z => O_24,
          T => temporary_res(7),
          CS => carry_save(7)
      );

--Secondo livello composto da 5 CSL (CSBlocks)
CSBlock_2_0 : CSBlock
generic map (
      N => 48
)
port map(
    X => temporary_res(0),
    Y => carry_save(0),
    Z => temporary_res(1),
    T => temporary_res_1(0),
    CS => carry_save_1(0)
);

CSBlock_2_1 : CSBlock
generic map (
      N => 48
)
port map(
    X => carry_save(1),
    Y => temporary_res(2),
    Z => carry_save(2),
    T => temporary_res_1(1),
    CS => carry_save_1(1)
);

CSBlock_2_2 : CSBlock
generic map (
      N => 48
)
port map(
    X => temporary_res(3),
    Y => carry_save(3),
    Z => temporary_res(4),
    T => temporary_res_1(2),
    CS => carry_save_1(2)
);

CSBlock_2_3 : CSBlock
generic map (
      N => 48
)
port map(
    X => carry_save(4),
    Y => temporary_res(5),
    Z => carry_save(5),
    T => temporary_res_1(3),
    CS => carry_save_1(3)
);

CSBlock_2_4 : CSBlock
generic map (
      N => 48
)
port map(
    X => temporary_res(6),
    Y => carry_save(6),
    Z => temporary_res(7),
    T => temporary_res_1(4),
    CS => carry_save_1(4)
);

--Terzo livello composto da 3 CSL (CSBlocks)
CSBlock_3_0 : CSBlock
generic map (
      N => 49
)
port map(
      X => temporary_res_1(1),
      Y => carry_save_1(1),
      Z => temporary_res_1(2),
      T => temporary_res_2(0),
      CS => carry_save_2(0)
);

CSBlock_3_1 : CSBlock
generic map (
      N => 49
)
port map(
      X => carry_save_1(2),
      Y => temporary_res_1(3),
      Z => carry_save_1(3),
      T => temporary_res_2(1),
      CS => carry_save_2(1)
);

CSBlock_3_2 : CSBlock
generic map (
      N => 49
)
port map(
      X => temporary_res_1(4),
      Y => carry_save_1(4),
      Z => carry_save_7_tmp, 
      T => temporary_res_2(2),
      CS => carry_save_2(2)
);

--Quarto livello composto da 2 CSL (CSBlocks)
CSBlock_4_0 : CSBlock
generic map (
      N => 50
)
port map(
      X => temporary_res_1_tmp,
      Y => carry_save_1_tmp,
      Z => temporary_res_2(0),
      T => temporary_res_3_0,
      CS => carry_save_3_0
);

CSBlock_4_1 : CSBlock
generic map (
      N => 50
)
port map(
      X => carry_save_2(0),
      Y => temporary_res_2(1),
      Z => carry_save_2(1),
      T => temporary_res_3_1,
      CS => carry_save_3_1
);

--Quinto livello composto da 2 CSL (CSBlock)
CSBlock_5_0 : CSBlock
generic map (
      N => 51
)
port map(
      X => temporary_res_3_0,
      Y => carry_save_3_0,
      Z => temporary_res_3_1,
      T => temporary_res_4_0,
      CS => carry_save_4_0
);

CSBlock_5_1 : CSBlock
generic map (
      N => 51
)
port map(
      X => carry_save_3_1,
      Y => temporary_res_2_tmp,
      Z => carry_save_2_tmp,
      T => temporary_res_4_1,
      CS => carry_save_4_1
);

--Sesto livello composto da 1 CSL (CSBlock)
CSBlock_6_0 : CSBlock
generic map (
      N => 52
)
port map(
      X => temporary_res_4_0,
      Y => carry_save_4_0,
      Z => temporary_res_4_1,
      T => temporary_res_5,
      CS => carry_save_5
);

--Settimo livello composto da 1 CSL (CSBlock)
CSBlock_7_0 : CSBlock
generic map (
      N => 53
)
port map(
      X => temporary_res_5,
      Y => carry_save_5,
      Z => carry_save_4_1_tmp,
      T => temporary_res_6,
      CS => carry_save_6
);

--Ottavo livello composto da 1 CLA (CSBlock)
CLA_inst : CLA_54

	port map(
      X => temporary_res_6,
      Y => carry_save_6,
		Cin => '0',
      S => Temp_RES,
		Cout => Final_Cout
);

RES <= Final_Cout & TEMP_RES;
end RTL;