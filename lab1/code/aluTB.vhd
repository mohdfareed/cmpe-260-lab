-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date : 02/07/2024
-- Design Name : aluTB
-- Module Name : aluTB - behavioral
-- Project Name : Lab1
--
-- Description : Testbench for Partial 32-bit ALU
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all;

entity aluTB is
end aluTB ;

architecture Behavioral of aluTB is
    Component alu4 is
        PORT (
            A  : IN std_logic_vector (N-1 downto 0);
            B  : IN std_logic_vector (N-1 downto 0);
            OP : IN std_logic_vector (4-1 downto 0);
            Y  : OUT std_logic_vector (N-1 downto 0)
        );
    end Component;

    constant delay : time := 20 ns ;
    signal A, B, Y, EXPECTED : std_logic_vector(N-1 downto 0) := (others => '0');
    signal OP : std_logic_vector(4-1 downto 0) := (others => '0');

    type test_case is record
        op: std_logic_vector(4-1 downto 0);
        a_val: std_logic_vector(32-1 downto 0);
        b_val: std_logic_vector(32-1 downto 0);
        expected_result: std_logic_vector(32-1 downto 0);
    end record;
    type test_case_array is array(natural range <>) of test_case;

    -- Define test cases
    constant tests: test_case_array := (
        -- Generic NOT cases
        (op => "0110", a_val => x"0000000F", b_val => x"00000000", expected_result => x"FFFFFFF0"),
        (op => "0110", a_val => x"0F0F0F0F", b_val => x"00000000", expected_result => x"F0F0F0F0"),
        (op => "0110", a_val => x"12345678", b_val => x"00000000", expected_result => x"EDCBA987"),
        (op => "0110", a_val => x"ABCDEF01", b_val => x"00000000", expected_result => x"543210FE"),

        -- Generic SLL cases
        (op => "1100", a_val => x"00000001", b_val => x"00000002", expected_result => x"00000004"),
        (op => "1100", a_val => x"00000002", b_val => x"00000001", expected_result => x"00000004"),
        (op => "1100", a_val => x"0000000F", b_val => x"00000004", expected_result => x"000000F0"),
        (op => "1100", a_val => x"40000000", b_val => x"00000001", expected_result => x"80000000"),

        -- SRL edge cases
        (op => "1101", a_val => x"00000006", b_val => x"00000002", expected_result => x"00000001"),
        -- Generic SRL cases
        (op => "1101", a_val => x"00000008", b_val => x"00000001", expected_result => x"00000004"),
        (op => "1101", a_val => x"00000010", b_val => x"00000002", expected_result => x"00000004"),
        (op => "1101", a_val => x"000000FF", b_val => x"00000004", expected_result => x"0000000F"),
        (op => "1101", a_val => x"80000000", b_val => x"00000001", expected_result => x"40000000"),

        -- SRA edge cases
        (op => "1110", a_val => x"00000006", b_val => x"00000001", expected_result => x"00000003"),
        (op => "1110", a_val => x"00000006", b_val => x"00000002", expected_result => x"00000001"),
        (op => "1110", a_val => x"F0000000", b_val => x"00000001", expected_result => x"F8000000"),
        -- Generic SRA cases
        (op => "1110", a_val => x"80000000", b_val => x"00000001", expected_result => x"C0000000"),
        (op => "1110", a_val => x"80000001", b_val => x"00000001", expected_result => x"C0000000"),
        (op => "1110", a_val => x"FFFFFFFF", b_val => x"00000001", expected_result => x"FFFFFFFF"),
        (op => "1110", a_val => x"7FFFFFFF", b_val => x"00000001", expected_result => x"3FFFFFFF"),

        -- OR edge cases
        (op => "1000", a_val => x"00000000", b_val => x"00000000", expected_result => x"00000000"),
        (op => "1000", a_val => x"00000000", b_val => x"0000000F", expected_result => x"0000000F"),
        (op => "1000", a_val => x"0000000F", b_val => x"0000000F", expected_result => x"0000000F"),
        (op => "1000", a_val => x"00000005", b_val => x"0000000A", expected_result => x"0000000F"),
        (op => "1000", a_val => x"0000000A", b_val => x"00000005", expected_result => x"0000000F"),
        -- Generic OR cases
        (op => "1000", a_val => x"0F0F0F0F", b_val => x"F0F0F0F0", expected_result => x"FFFFFFFF"),
        (op => "1000", a_val => x"A5A5A5A5", b_val => x"5A5A5A5A", expected_result => x"FFFFFFFF"),
        (op => "1000", a_val => x"12345678", b_val => x"00000000", expected_result => x"12345678"),
        (op => "1000", a_val => x"ABCDEF01", b_val => x"12345678", expected_result => x"BBFDFF79"),

        -- XOR edge cases
        (op => "1011", a_val => x"00000000", b_val => x"00000000", expected_result => x"00000000"),
        (op => "1011", a_val => x"00000000", b_val => x"0000000F", expected_result => x"0000000F"),
        (op => "1011", a_val => x"0000000F", b_val => x"00000000", expected_result => x"0000000F"),
        (op => "1011", a_val => x"0000000F", b_val => x"0000000F", expected_result => x"00000000"),
        (op => "1011", a_val => x"00000005", b_val => x"0000000A", expected_result => x"0000000F"),
        (op => "1011", a_val => x"0000000A", b_val => x"00000005", expected_result => x"0000000F"),
        -- Generic XOR cases
        (op => "1011", a_val => x"0F0F0F0F", b_val => x"F0F0F0F0", expected_result => x"FFFFFFFF"),
        (op => "1011", a_val => x"A5A5A5A5", b_val => x"5A5A5A5A", expected_result => x"FFFFFFFF"),
        (op => "1011", a_val => x"12345678", b_val => x"12345678", expected_result => x"00000000"),
        (op => "1011", a_val => x"ABCDEF01", b_val => x"12345678", expected_result => x"B9F9B979"),

        -- AND edge cases
        (op => "1010", a_val => x"00000000", b_val => x"00000000", expected_result => x"00000000"),
        (op => "1010", a_val => x"00000000", b_val => x"0000000F", expected_result => x"00000000"),
        (op => "1010", a_val => x"0000000F", b_val => x"00000000", expected_result => x"00000000"),
        (op => "1010", a_val => x"0000000F", b_val => x"0000000F", expected_result => x"0000000F"),
        -- Generic AND cases
        (op => "1010", a_val => x"0F0F0F0F", b_val => x"F0F0F0F0", expected_result => x"00000000"),
        (op => "1010", a_val => x"A5A5A5A5", b_val => x"5A5A5A5A", expected_result => x"00000000"),
        (op => "1010", a_val => x"12345678", b_val => x"87654321", expected_result => x"02244220"),
        (op => "1010", a_val => x"FFFFFFFF", b_val => x"12345678", expected_result => x"12345678")
    );

    type test_case_4bit is record
        op: std_logic_vector(4-1 downto 0);
        a_val: std_logic_vector(4-1 downto 0);
        b_val: std_logic_vector(4-1 downto 0);
        expected_result: std_logic_vector(4-1 downto 0);
    end record;
    type test_case_4bit_array is array(natural range <>) of test_case_4bit;

    -- Define 4-bit test cases
    constant tests_4bits: test_case_4bit_array := (
        -- Generic NOT cases for 4 bits
        (op => "0110", a_val => x"0", b_val => x"0", expected_result => x"F"), -- NOT 0 = F
        (op => "0110", a_val => x"1", b_val => x"0", expected_result => x"E"), -- NOT 1 = E
        (op => "0110", a_val => x"2", b_val => x"0", expected_result => x"D"), -- NOT 2 = D
        (op => "0110", a_val => x"3", b_val => x"0", expected_result => x"C"), -- NOT 3 = C

        -- Generic SLL cases for 4 bits
        (op => "1100", a_val => x"1", b_val => x"1", expected_result => x"2"), -- 1 << 1 = 2
        (op => "1100", a_val => x"2", b_val => x"1", expected_result => x"4"), -- 2 << 1 = 4
        (op => "1100", a_val => x"4", b_val => x"1", expected_result => x"8"), -- 4 << 1 = 8
        (op => "1100", a_val => x"8", b_val => x"1", expected_result => x"0"), -- 8 << 1 = 0 (overflow)

        -- Generic SRL cases for 4 bits
        (op => "1101", a_val => x"2", b_val => x"1", expected_result => x"1"), -- 2 >> 1 = 1
        (op => "1101", a_val => x"4", b_val => x"1", expected_result => x"2"), -- 4 >> 1 = 2
        (op => "1101", a_val => x"8", b_val => x"1", expected_result => x"4"), -- 8 >> 1 = 4
        (op => "1101", a_val => x"F", b_val => x"1", expected_result => x"7"), -- F >> 1 = 7

        -- Generic SRA cases for 4 bits
        (op => "1110", a_val => x"2", b_val => x"1", expected_result => x"1"), -- 2 >>> 1 = 1
        (op => "1110", a_val => x"4", b_val => x"1", expected_result => x"2"), -- 4 >>> 1 = 2
        (op => "1110", a_val => x"8", b_val => x"1", expected_result => x"C"), -- 8 >>> 1 = C (sign extended)
        (op => "1110", a_val => x"F", b_val => x"1", expected_result => x"F"), -- F >>> 1 = F (sign extended)

        -- OR edge cases for 4 bits
        (op => "1000", a_val => x"0", b_val => x"0", expected_result => x"0"),
        (op => "1000", a_val => x"1", b_val => x"2", expected_result => x"3"),
        (op => "1000", a_val => x"4", b_val => x"8", expected_result => x"C"),
        (op => "1000", a_val => x"F", b_val => x"F", expected_result => x"F"),

        -- XOR edge cases for 4 bits
        (op => "1011", a_val => x"0", b_val => x"0", expected_result => x"0"),
        (op => "1011", a_val => x"1", b_val => x"1", expected_result => x"0"),
        (op => "1011", a_val => x"2", b_val => x"3", expected_result => x"1"),
        (op => "1011", a_val => x"F", b_val => x"F", expected_result => x"0"),

        -- AND edge cases for 4 bits
        (op => "1010", a_val => x"0", b_val => x"0", expected_result => x"0"),
        (op => "1010", a_val => x"1", b_val => x"1", expected_result => x"1"),
        (op => "1010", a_val => x"2", b_val => x"3", expected_result => x"2"),
        (op => "1010", a_val => x"F", b_val => x"F", expected_result => x"F")
    );

begin
    -- Instantiate an instance of the ALU
    alu_inst : alu4 PORT MAP(
        A  => A,
        B  => B,
        OP => OP,
        Y  => Y
    );

    data_proc : process is
    begin
        -- Determine which test array to use based on N
        if N = 4 then
            -- Use tests_4bits for 4-bit inputs
            for i in tests_4bits'range loop
                -- Apply the 4-bit test case
                OP <= tests_4bits(i).op;
                A <= std_logic_vector(resize(unsigned(tests_4bits(i).a_val), N));
                B <= std_logic_vector(resize(unsigned(tests_4bits(i).b_val), N));
                EXPECTED <= std_logic_vector(resize(unsigned(tests_4bits(i).expected_result), N));
                wait for delay;

                -- Check the result
                assert Y = EXPECTED
                report "4-bit Test " & integer'image(i) & " failed."
                severity error;
            end loop;
        elsif N = 32 then
            -- Use tests for 32-bit inputs
            for i in tests'range loop
                -- Apply the 32-bit test case
                OP <= tests(i).op;
                A <= tests(i).a_val;
                B <= tests(i).b_val;
                EXPECTED <= tests(i).expected_result;
                wait for delay;

                -- Check the result
                assert Y = EXPECTED
                report "32-bit Test " & integer'image(i) & " failed."
                severity error;
            end loop;
        end if;

        assert false report "Tests completed successfully" severity note;
        wait;
    end process;
end Behavioral ;
