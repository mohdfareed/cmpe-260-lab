-------------------------------------------------
--  File:          fetch_tb.vhd
--
--  Entity:        InstructionFetchTB
--  Architecture:  BEHAVIORAL
--  Author:        Jason Blocklove, Mohammed Fareed
--  Created:       07/26/19
--  Modified:      03/06/24
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 Testbench for Instruction Fetch
--                 stage.
-------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY InstructionFetchTB IS
END InstructionFetchTB;

ARCHITECTURE Behavioral OF InstructionFetchTB IS
    TYPE test_vector IS RECORD
        rst : STD_LOGIC;
        Instruction : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    END RECORD;

    TYPE test_array IS ARRAY (NATURAL RANGE <>) OF test_vector;
    CONSTANT test_vector_array : test_array := (
    (rst => '1', Instruction => x"00000000"), -- reset value
        (rst => '0', Instruction => x"11111111"),
        (rst => '0', Instruction => x"22222222"),
        (rst => '0', Instruction => x"1f2e3d4c"),
        -- Prelab test cases
        (rst => '0', Instruction => x"12345678"),
        (rst => '0', Instruction => x"00000001"),
        (rst => '0', Instruction => x"00000002"),
        (rst => '0', Instruction => x"00000003"),
        (rst => '0', Instruction => x"5a5a5a5a"),
        -- Lab test cases
        (rst => '1', Instruction => x"00000000"),
        (rst => '0', Instruction => x"11111111"),
        (rst => '0', Instruction => x"22222222")
    );

    COMPONENT InstructionFetch
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            Instruction : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0));
    END COMPONENT;

    SIGNAL rst : STD_LOGIC := '1';
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL Instruction : STD_LOGIC_VECTOR(32 - 1 DOWNTO 0) := (OTHERS => '0');

BEGIN
    uut : InstructionFetch
    PORT MAP(
        clk => clk,
        rst => rst,
        Instruction => Instruction);

    clk_proc : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 50 ns;
        clk <= '1';
        WAIT FOR 50 ns;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
        WAIT FOR 100 ns;
        FOR i IN test_vector_array'RANGE LOOP
            rst <= test_vector_array(i).rst;
            WAIT FOR 100 ns;

            ASSERT (Instruction = test_vector_array(i).Instruction)
            REPORT "Test Vector " & INTEGER'image(i) & " failed"
                SEVERITY failure;
        END LOOP;

        ASSERT false -- 1500 ns simulation time
        REPORT "Testbench Concluded"
            SEVERITY note;
    END PROCESS;
END Behavioral;
