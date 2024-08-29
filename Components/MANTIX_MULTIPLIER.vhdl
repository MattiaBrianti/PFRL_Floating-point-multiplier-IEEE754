library ieee;
use ieee.std_logic_1164.all;

entity MULTIPLIER_IEEE754 is
    port (
        X : in STD_LOGIC_VECTOR(31 downto 0);
        Y : in STD_LOGIC_VECTOR(31 downto 0);
        RESULT : out STD_LOGIC_VECTOR(31 downto 0);
        INVALID : out STD_LOGIC;
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

    --signals that go Reg3 to output stage
    signal S_R3_to_O : STD_LOGIC;
    signal FLAG_R3_to_O : STD_LOGIC_VECTOR(1 downto 0);
    signal MANT_R3_to_O : STD_LOGIC_VECTOR(47 downto 0);
    signal EXP_R3_to_O : STD_LOGIC_VECTOR(9 downto 0);

    --signals that to output stage to R4
    signal RES_O_to_R4 : STD_LOGIC_VECTOR (31 downto 0);
    signal INVALID_O_to_R4 : STD_LOGIC;

    --signals that go from Reg4 to end
    signal RES_R4_to_E : STD_LOGIC_VECTOR (31 downto 0);
    signal INVALID_R4_to_E : STD_LOGIC;
    component REG is
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

    component PREP_STAGE is
        port (
            X : in STD_LOGIC_VECTOR(31 downto 0);
            Y : in STD_LOGIC_VECTOR(31 downto 0);
            FLAG : out STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            S : out STD_LOGIC;
            EXP_X : out STD_LOGIC_VECTOR (7 downto 0);
            EXP_Y : out STD_LOGIC_VECTOR (7 downto 0);
            FIXED_MANT_X : out STD_LOGIC_VECTOR (23 downto 0); -- 24-bit mantissa
            FIXED_MANT_Y : out STD_LOGIC_VECTOR (23 downto 0) -- 24-bit mantissa
        );
    end component;

    component CALC_STAGE is
        port (
            FLAG : in STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            S : in STD_LOGIC;
            EXP_X : in STD_LOGIC_VECTOR (7 downto 0);
            EXP_Y : in STD_LOGIC_VECTOR (7 downto 0);
            FIXED_MANT_X : in STD_LOGIC_VECTOR (23 downto 0); -- 24-bit mantissa
            FIXED_MANT_Y : in STD_LOGIC_VECTOR (23 downto 0); -- 24-bit mantissa
            S_OUT : out STD_LOGIC;
            FLAG_OUT : out STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            P : out STD_LOGIC_VECTOR(47 downto 0);
            exp_out : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;

    component OUTPUT_STAGE is
        port (
            FLAG : in STD_LOGIC_VECTOR (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            S : in STD_LOGIC;
            exp_out : in STD_LOGIC_VECTOR(9 downto 0);
            P : in STD_LOGIC_VECTOR(47 downto 0);
            RES_FINAL : out STD_LOGIC_VECTOR (31 downto 0);
            INVALID : out STD_LOGIC
        );
    end component;

begin
    --R1
    --REGs in front of prep stage
    REG_X : REG port map(
        CLK => CLK,
        D => X,
        Q => X_R1_to_P,
        RST => RST
    );

    REG_Y : REG port map(
        CLK => CLK,
        D => Y,
        Q => Y_R1_to_P,
        RST => RST
    );
    -- PREP STAGE
    U0 : PREP_STAGE port map(
        X => X_R1_to_P,
        Y => Y_R1_to_P,
        FLAG => FLAG_P_to_R2,
        S => S_P_to_R2,
        EXP_X => EXP_X_P_to_R2,
        EXP_Y => EXP_Y_P_to_R2,
        FIXED_MANT_X => FIXED_MANT_X_P_to_R2,
        FIXED_MANT_Y => FIXED_MANT_Y_P_to_R2
    );

    --R2
    --REGs behind PREP stage and in front of CALC stage
    REG_FLAG : REG
    generic map(N => 2)
    port map(
        CLK => CLK,
        D => FLAG_P_to_R2,
        Q => FLAG_R2_to_C,
        RST => RST
    );

    REG_S : REG_1bit port map(
        CLK => CLK,
        D => S_P_to_R2,
        Q => S_R2_to_C,
        RST => RST
    );

    REG_EXP_X : REG
    generic map(N => 8)
    port map(
        CLK => CLK,
        D => EXP_X_P_to_R2,
        Q => EXP_X_R2_to_C,
        RST => RST
    );

    REG_EXP_Y : REG
    generic map(N => 8)
    port map(
        CLK => CLK,
        D => EXP_Y_P_to_R2,
        Q => EXP_Y_R2_to_C,
        RST => RST
    );

    REG_FIXED_MANT_X : REG
    generic map(N => 24)
    port map(
        CLK => CLK,
        D => FIXED_MANT_X_P_to_R2,
        Q => FIXED_MANT_X_R2_to_C,
        RST => RST
    );

    REG_FIXED_MANT_Y : REG
    generic map(N => 24)
    port map(
        CLK => CLK,
        D => FIXED_MANT_Y_P_to_R2,
        Q => FIXED_MANT_Y_R2_to_C,
        RST => RST
    );

    -- CALC STAGE
    U1 : CALC_STAGE port map(
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
    --REGs behind CALC stage and in front of OUTPUT stage
    REG_S_OUT : REG_1bit port map(
        CLK => CLK,
        D => S_C_to_R3,
        Q => S_R3_to_O,
        RST => RST
    );

    REG_FLAG_OUT : REG
    generic map(N => 2)
    port map(
        CLK => CLK,
        D => FLAG_C_to_R3,
        Q => FLAG_R3_to_O,
        RST => RST
    );

    REG_P : REG
    generic map(N => 48)
    port map(
        CLK => CLK,
        D => MANT_C_to_R3,
        Q => MANT_R3_to_O,
        RST => RST
    );

    REG_EXP_OUT : REG
    generic map(N => 10)
    port map(
        CLK => CLK,
        D => EXP_C_to_R3,
        Q => EXP_R3_to_O,
        RST => RST
    );

    -- OUTPUT STAGE
    U2 : OUTPUT_STAGE port map(
        FLAG => FLAG_R3_to_O,
        S => S_R3_to_O,
        exp_out => EXP_R3_to_O,
        P => MANT_R3_to_O,
        RES_FINAL => RES_O_to_R4,
        INVALID => INVALID_R4_to_E
    );

    --R4
    --REGs behind OUTPUT stage and in front of end
    REG_RES : REG
    generic map(N => 32)
    port map(
        CLK => CLK,
        D => RES_O_to_R4,
        Q => RES_R4_to_E,
        RST => RST
    );

    REG_INVALID : REG_1bit port map(
        CLK => CLK,
        D => INVALID_O_to_R4,
        Q => INVALID_R4_to_E,
        RST => RST
    );

end architecture RTL;