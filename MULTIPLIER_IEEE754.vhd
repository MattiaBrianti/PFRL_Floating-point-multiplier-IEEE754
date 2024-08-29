library ieee;
use ieee.std.logic_1164.all;

entity MULTIPLIER_IEEE754 is
    port (
        X : in std.logic_vector(31 downto 0);
        Y : in std.logic_vector(31 downto 0);
        RESULT : out std.logic_vector(31 downto 0);
        INVALID : out std.logic
        RST: in std.logic;
        CLK: in std.logic;
    );
end entity MULTIPLIER_IEEE754;

architecture RTL of MULTIPLIER_IEEE754 is

    --signals that go through prep stage 
    signal T_X_IN : std.logic_vector(31 downto 0);
    signal T_Y_IN : std.logic_vector(31 downto 0);
    signal T_FLAG_PREP : std.logic_vector(1 downto 0);
    signal S_PREP : std.logic;
    signal T_EXP_X_PREP : std.logic_vector(7 downto 0);
    signal T_EXP_Y_PREP : std.logic_vector(7 downto 0);
    signal T_FIXED_MANT_X_PREP : std.logic_vector(23 downto 0);
    signal T_FIXED_MANT_Y_PREP : std.logic_vector(23 downto 0);
    --signals that enter PREP stage
    signal T_S_PREP : std.logic; 
    signal T_FLAG_PREP : std.logic_vector(1 downto 0); 
    signal T_EXP_X_PREP : std.logic_vector(7 downto 0);
    signal T_EXP_Y_PREP : std.logic_vector(7 downto 0);
    signal T_FIXED_MANT_X_PREP : std.logic_vector(23 downto 0);
    signal T_FIXED_MANT_Y_PREP : std.logic_vector(23 downto 0);
    --signals that enter output stage
    signal T_S_OUT : std.logic; -- sign for output stage
    signal T_FLAG_OUT : std.logic_vector(1 downto 0);
    signal T_EXP_OUT : std.logic_vector(9 downto 0);
    SIGNAL T_MANT_OUT : std.logic_vector(47 downto 0);
    --signals that enter final stage
    signal T_RES_FINAL : std.logic_vector(31 downto 0);
    signal T_INVALID : std.logic;

    signal FLAG : std.logic_vector (1 downto 0);
    signal S : std.logic;
    signal EXP_X : std.logic_vector (7 downto 0);
    signal EXP_Y : std.logic_vector (7 downto 0);
    signal FIXED_MANT_X : std.logic_vector (23 downto 0);
    signal FIXED_MANT_Y : std.logic_vector (23 downto 0);
    signal S_OUT : std.logic;
    signal FLAG_OUT : std.logic_vector (1 downto 0);
    signal P : std.logic_vector(47 downto 0);
    signal exp_out : std.logic_vector(9 downto 0);
    

    component REGISTER is
        generic (N : INTEGER := 32);
        port (
            CLK : in std.logic;
            D : in std.logic_vector (N - 1 downto 0);
            Q : out std.logic_vector (N - 1 downto 0);
            RST : in std.logic
        );
    end component;

    component PREP_STAGE is
        port (
            X : in std.logic_vector(31 downto 0);
            Y : in std.logic_vector(31 downto 0);
            FLAG : out std.logic_vector (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            S : out std.logic;
            EXP_X : out std.logic_vector (7 downto 0);
            EXP_Y : out std.logic_vector (7 downto 0);
            FIXED_MANT_X : out std.logic_vector (23 downto 0); -- 24-bit mantissa
            FIXED_MANT_Y : out std.logic_vector (23 downto 0) -- 24-bit mantissa
        );
    end component;

    component PREP_STAGE is
        port (
            FLAG : in std.logic_vector (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            S : in std.logic;
            EXP_X : in std.logic_vector (7 downto 0);
            EXP_Y : in std.logic_vector (7 downto 0);
            FIXED_MANT_X : in std.logic_vector (23 downto 0); -- 24-bit mantissa
            FIXED_MANT_Y : in std.logic_vector (23 downto 0); -- 24-bit mantissa
            S_OUT : out std.logic;
            FLAG_OUT : out std.logic_vector (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            P : out std.logic_vector(47 downto 0);
            exp_out : out std.logic_vector(9 downto 0)
        );
    end component;

    component OUTPUT_STAGE is
        port (
            FLAG : in std.logic_vector (1 downto 0); -- 2-bit flag for INF, NAN, ZERO and DENORM
            S : in std.logic;
            exp_out : in std.logic_vector(9 downto 0);
            P : in std.logic_vector(47 downto 0);
            RES_FINAL : out std.logic_vector (31 downto 0);
            INVALID : out std.logic
        );
    end component;

begin

    --Registers in front of prep stage
    REG_X : REGISTER port map(
        CLK => CLK,
        D => X,
        Q => T_X,
        RST => RST
    );

    REG_Y : REGISTER port map(
        CLK => CLK,
        D => Y,
        Q => T_Y,
        RST => RST
    );

    U0 : PREP_STAGE port map(
        X => T_X,
        Y => T_Y,
        FLAG => T_FLAG_PREP,
        S => S_PREP,
        EXP_X => T_EXP_X_PREP,
        EXP_Y => T_EXP_Y_PREP,
        FIXED_MANT_X => T_FIXED_MANT_X_PREP,
        FIXED_MANT_Y => T_FIXED_MANT_Y_PREP
    );

    --registers behind PREP stage and in front of CALC stage
    REG_FLAG: REGISTER port map(
        CLK => CLK,
        D => T_FLAG_PREP,
        Q => T_FLAG_CALC,
        RST => RST
    );

    -- SIGN REGISTER
    REG_S: REGISTER port map(
        CLK => CLK,
        D => T_S_PREP,
        Q => T_S_CALC,
        RST => RST
    );

    REG_EXP_X: REGISTER port map(
        CLK => CLK,
        D => EXP_X_PREP,
        Q => exp_out(7 downto 0),
        RST => RST
    );

    REG_EXP_Y: REGISTER port map(
        CLK => CLK,
        D => EXP_Y,
        Q => exp_out(15 downto 8),
        RST => RST
    );

    REG_FIXED_MANT_X: REGISTER port map(
        CLK => CLK,
        D => FIXED_MANT_X,
        Q => exp_out(23 downto 16),
        RST => RST
    );

    REG_FIXED_MANT_Y: REGISTER port map(
        CLK => CLK,
        D => FIXED_MANT_Y,
        Q => exp_out(31 downto 24),
        RST => RST
    );

    U1 : PREP_STAGE port map(
        FLAG => FLAG,
        S => S,
        EXP_X => EXP_X,
        EXP_Y => EXP_Y,
        FIXED_MANT_X => FIXED_MANT_X,
        FIXED_MANT_Y => FIXED_MANT_Y,
        S_OUT => S_OUT,
        FLAG_OUT => FLAG_OUT,
        P => P,
        exp_out => exp_out
    );

    U2 : OUTPUT_STAGE port map(
        FLAG => FLAG_OUT,
        S => S_OUT,
        exp_out => exp_out,
        P => P,
        RES_FINAL => RESULT,
        INVALID => INVALID
    );

end architecture RTL;