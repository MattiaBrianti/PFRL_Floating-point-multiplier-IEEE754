library ieee;
use ieee.std_logic_1164.all;

entity MULTIPLIER_IEEE754 is
    port (
        X : in STD_LOGIC_VECTOR(31 downto 0);
        Y : in STD_LOGIC_VECTOR(31 downto 0);
        RESULT : out STD_LOGIC_VECTOR(31 downto 0);
        NaN_flag : out std_logic;
        zero_flag : out std_logic;
        inf_flag : out std_logic;
        RST : in STD_LOGIC;
        CLK : in STD_LOGIC
    );
end entity MULTIPLIER_IEEE754;

architecture RTL of MULTIPLIER_IEEE754 is

    -- signals that go from Reg1 to prep stage
    signal X_R1_to_P : STD_LOGIC_VECTOR(31 downto 0);
    signal Y_R1_to_P : STD_LOGIC_VECTOR(31 downto 0);

    -- signals that go from prep stage to Reg2
    signal FLAG_P_to_R2 : STD_LOGIC_VECTOR(1 downto 0);
    signal S_P_to_R2 : STD_LOGIC;
    signal EXP_X_P_to_R2 : STD_LOGIC_VECTOR(7 downto 0);
    signal EXP_Y_P_to_R2 : STD_LOGIC_VECTOR(7 downto 0);
    signal FIXED_MANT_X_P_to_R2 : STD_LOGIC_VECTOR(23 downto 0);
    signal FIXED_MANT_Y_P_to_R2 : STD_LOGIC_VECTOR(23 downto 0);
    --signals that go Reg2 to calc stage
    signal S_R2_to_C : STD_LOGIC;
    signal FLAG_R2_to_C : STD_LOGIC_VECTOR(1 downto 0);
    signal EXP_X_R2_to_C : STD_LOGIC_VECTOR(7 downto 0);
    signal EXP_Y_R2_to_C : STD_LOGIC_VECTOR(7 downto 0);
    signal FIXED_MANT_X_R2_to_C : STD_LOGIC_VECTOR(23 downto 0);
    signal FIXED_MANT_Y_R2_to_C : STD_LOGIC_VECTOR(23 downto 0);

    --signals that go calc stage to Reg3
    signal S_C_to_R3 : STD_LOGIC;
    signal FLAG_C_to_R3 : STD_LOGIC_VECTOR(1 downto 0);
    signal MANT_C_to_R3 : STD_LOGIC_VECTOR(47 downto 0);
    signal EXP_C_to_R3 : STD_LOGIC_VECTOR(9 downto 0);

    --signals that go Reg3 to Rounder stage
    signal S_R3_to_RO : STD_LOGIC;
    signal FLAG_R3_to_RO : STD_LOGIC_VECTOR(1 downto 0);
    signal MANT_R3_to_RO : STD_LOGIC_VECTOR(47 downto 0);
    signal EXP_R3_to_RO : STD_LOGIC_VECTOR(9 downto 0);

    --signals that to Rounder stage to Reg4
    --signal S_RO_to_R4 : STD_LOGIC;
    --signal FLAG_RO_to_R4 : STD_LOGIC_VECTOR(1 downto 0);
    --signal MANT_RO_to_R4 : STD_LOGIC_VECTOR(22 downto 0);
    --signal EXP_RO_to_R4 : STD_LOGIC_VECTOR(9 downto 0);

    --signals that go from Reg4 to Output stage
   -- signal S_R4_to_O : STD_LOGIC;
   -- signal FLAG_R4_to_O : STD_LOGIC_VECTOR(1 downto 0);
    --signal MANT_R4_to_O : STD_LOGIC_VECTOR(22 downto 0);
    --signal EXP_R4_TO_O : STD_LOGIC_VECTOR(9 downto 0);

    --signals that go from Output stage to Reg5
    signal RES_O_TO_R5 : STD_LOGIC_VECTOR(31 downto 0);
    signal NaN_flag_int : std_logic;
    signal zero_flag_int : std_logic;
    signal inf_flag_int : std_logic;
    
    --signals that go from Reg5 to End
    signal RESULT_R5_TO_E : std_logic_vector(31 downto 0);

    component REG_Nbit is
        generic (N : INTEGER := 32);
        port (
            CLK : in STD_LOGIC;
            D : in STD_LOGIC_VECTOR (N - 1 downto 0);
            Q : out STD_LOGIC_VECTOR (N - 1 downto 0);
            RST : in STD_LOGIC
        );
    end component;

    component REG_1bit is
        port (
            CLK : in STD_LOGIC;
            D : in STD_LOGIC;
            Q : out STD_LOGIC;
            RST : in STD_LOGIC
        );
    end component;

    component PREP_COMPONENT is
        port (
            X : in STD_LOGIC_VECTOR(31 downto 0);
            Y : in STD_LOGIC_VECTOR(31 downto 0);
            MANT_EXT_X : out STD_LOGIC_VECTOR (23 downto 0);
            MANT_EXT_Y : out STD_LOGIC_VECTOR (23 downto 0);
            EXP_X : out STD_LOGIC_VECTOR (7 downto 0);
            EXP_Y : out STD_LOGIC_VECTOR (7 downto 0);
            S : out STD_LOGIC;
            FLAG : out STD_LOGIC_VECTOR (1 downto 0)
        );
    end component;

    component CALC_STAGE is
        port (
            FLAG : in STD_LOGIC_VECTOR (1 downto 0);
            S : in STD_LOGIC;
            EXP_X : in STD_LOGIC_VECTOR (7 downto 0);
            EXP_Y : in STD_LOGIC_VECTOR (7 downto 0);
            FIXED_MANT_X : in STD_LOGIC_VECTOR (23 downto 0);
            FIXED_MANT_Y : in STD_LOGIC_VECTOR (23 downto 0);
            S_OUT : out STD_LOGIC;
            FLAG_OUT : out STD_LOGIC_VECTOR (1 downto 0);
            P : out STD_LOGIC_VECTOR(47 downto 0);
            exp_out : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;


    component OUTPUT_STAGE is
        port (
            FLAG : in STD_LOGIC_VECTOR (1 downto 0);
            S : in STD_LOGIC;
            exp_out : in STD_LOGIC_VECTOR(9 downto 0);
            P : in STD_LOGIC_VECTOR(47 downto 0);
            RES_FINAL : out STD_LOGIC_VECTOR (31 downto 0);
            NaN_flag : out std_logic;
            zero_flag : out std_logic;
            inf_flag : out std_logic
        );
        end component;

begin
    --R1
    --REGs in front of prep stage
    INPUT_REG_X : REG_Nbit port map(
        CLK => CLK,
        D => X,
        Q => X_R1_to_P,
        RST => RST
    );

    INPUT_REG_Y : REG_Nbit port map(
        CLK => CLK,
        D => Y,
        Q => Y_R1_to_P,
        RST => RST
    );
    -- PREP STAGE
    PREP_STAGE_inst : PREP_COMPONENT port map(
        X => X_R1_to_P,
        Y => Y_R1_to_P,
        FLAG => FLAG_P_to_R2,
        S => S_P_to_R2,
        EXP_X => EXP_X_P_to_R2,
        EXP_Y => EXP_Y_P_to_R2,
        MANT_EXT_X => FIXED_MANT_X_P_to_R2,
        MANT_EXT_Y => FIXED_MANT_Y_P_to_R2
    );

    --R2
    --REGs behind PREP stage and in front of CALC stage
    PREP_STAGE_REG_FLAG : REG_Nbit
    generic map(N => 2)
    port map(
        CLK => CLK,
        D => FLAG_P_to_R2,
        Q => FLAG_R2_to_C,
        RST => RST
    );

    PREP_STAGE_REG_S : REG_1bit port map(
        CLK => CLK,
        D => S_P_to_R2,
        Q => S_R2_to_C,
        RST => RST
    );

    PREP_STAGE_REG_EXP_X : REG_Nbit
    generic map(N => 8)
    port map(
        CLK => CLK,
        D => EXP_X_P_to_R2,
        Q => EXP_X_R2_to_C,
        RST => RST
    );

    PREP_STAGE_REG_EXP_Y : REG_Nbit
    generic map(N => 8)
    port map(
        CLK => CLK,
        D => EXP_Y_P_to_R2,
        Q => EXP_Y_R2_to_C,
        RST => RST
    );

    PREP_STAGE_REG_FIXED_MANT_X : REG_Nbit
    generic map(N => 24)
    port map(
        CLK => CLK,
        D => FIXED_MANT_X_P_to_R2,
        Q => FIXED_MANT_X_R2_to_C,
        RST => RST
    );

    PREP_STAGE_PREP_STAGE_REG_FIXED_MANT_Y : REG_Nbit
    generic map(N => 24)
    port map(
        CLK => CLK,
        D => FIXED_MANT_Y_P_to_R2,
        Q => FIXED_MANT_Y_R2_to_C,
        RST => RST
    );

    -- CALC STAGE
    CALC_STAGE_inst : CALC_STAGE port map(
        FLAG => FLAG_R2_to_C,
        S => S_R2_to_C,
        EXP_X => EXP_X_R2_to_C,
        EXP_Y => EXP_Y_R2_to_C,
        FIXED_MANT_X => FIXED_MANT_X_R2_to_C,
        FIXED_MANT_Y => FIXED_MANT_Y_R2_to_C,
        S_OUT => S_C_to_R3,
        FLAG_OUT => FLAG_C_to_R3,
        P => MANT_C_to_R3,
        exp_out => EXP_C_to_R3
    );

    -- R3
    --REGs behind CALC stage and in front of ROUNDER stage
    CALC_STAGE_REG_S_OUT : REG_1bit port map(
        CLK => CLK,
        D => S_C_to_R3,
        Q => S_R3_to_RO,
        RST => RST
    );

    CALC_STAGE_REG_FLAG_OUT : REG_Nbit
    generic map(N => 2)
    port map(
        CLK => CLK,
        D => FLAG_C_to_R3,
        Q => FLAG_R3_to_RO,
        RST => RST
    );

    CALC_STAGE_REG_P : REG_Nbit
    generic map(N => 48)
    port map(
        CLK => CLK,
        D => MANT_C_to_R3,
        Q => MANT_R3_to_RO,
        RST => RST
    );

    CALC_STAGE_REG_EXP_OUT : REG_Nbit
    generic map(N => 10)
    port map(
        CLK => CLK,
        D => EXP_C_to_R3,
        Q => EXP_R3_to_RO,
        RST => RST
    );

    -- -- ROUNDER STAGE
    -- ROUNDER_STAGE_inst : ROUNDER_STAGE port map(
    --     FLAG => FLAG_R3_to_RO,
    --     S => S_R3_to_RO,
    --     exp_out => EXP_R3_to_RO,
    --     P => MANT_R3_to_RO,
    --     MANT_OUT => MANT_RO_to_R4,
    --     RES_FINAL_1 => EXP_RO_to_R4,
    --     FLAG_OUT => FLAG_RO_to_R4,
    --     S_OUT => S_RO_to_R4
    -- );


    OUTPUT_STAGE_inst: OUTPUT_STAGE port map(
        FLAG => FLAG_R3_to_RO,
        S => S_R3_to_RO,
        exp_out => EXP_R3_to_RO,
        P => MANT_R3_to_RO,
        RES_FINAL => RES_O_TO_R5,
        NaN_flag => NaN_flag_int,
        zero_flag => zero_flag_int,
        inf_flag => inf_flag_int
    );

    -- -- OUTPUT STAGE
    -- OUTPUT_STAGE_inst : OUTPUT_STAGE port map(
    --     FLAG_OUT => FLAG_RO_to_R4,
    --     S_OUT => S_RO_to_R4,
    --     MANT_OUT => MANT_RO_to_R4,
    --     RES_FINAL_1 => EXP_RO_to_R4,
    --     RES_FINAL => RES_O_TO_R5,
    --     NaN_flag => NaN_flag_int,
    --     zero_flag => zero_flag_int,
    --     inf_flag => inf_flag_int
    -- );

    --R5
    --REG behind OUTPUT stage
    OUTPUT_STAGE_REG_RESULT : REG_Nbit port map(
        CLK => CLK,
        D => RES_O_TO_R5,
        Q => RESULT_R5_TO_E,
        RST => RST
    );

    OUTPUT_STAGE_NaN_flag : REG_1bit port map(
        CLK => CLK,
        D => NaN_flag_int,
        Q => NaN_flag,
        RST => RST
    );

    OUTPUT_STAGE_zero_flag : REG_1bit port map(
        CLK => CLK,
        D => zero_flag_int,
        Q => zero_flag,
        RST => RST
    );

    OUTPUT_STAGE_inf_flag : REG_1bit port map(
        CLK => CLK,
        D => inf_flag_int,
        Q => inf_flag,
        RST => RST
    );

    RESULT <= RESULT_R5_TO_E;

end architecture RTL;