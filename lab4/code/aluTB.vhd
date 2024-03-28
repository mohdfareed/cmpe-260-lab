-------------------------------------------------
--  File:          aluTB.vhd
--
--  Entity:        aluTB
--  Architecture:  Testbench
--  Author:        Jason Blocklove
--  Created:       07/29/19
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                aluTB
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all; -- provides N and M to top level

entity aluTB is
end aluTB;

architecture tb of aluTB is

component alu IS
    Port (
        A  : in  std_logic_vector(N-1 downto 0);
        B  : in  std_logic_vector(N-1 downto 0);
        OP : in  std_logic_vector(4-1 downto 0);
        Y  : out std_logic_vector(N-1 downto 0)
    );
end component;

signal in1 : std_logic_vector(N-1 downto 0);
signal in2 : std_logic_vector(N-1 downto 0);
signal control : std_logic_vector(3 downto 0);
signal out1 : std_logic_vector(N-1 downto 0);

type alu_tests is record
	-- Test Inputs
	in1 : std_logic_vector(31 downto 0);
	in2 : std_logic_vector(31 downto 0);
	control : std_logic_vector(3 downto 0);
	-- Test Outputs
	out1 : std_logic_vector(31 downto 0);
end record;

type test_array is array (natural range <>) of alu_tests;

constant test_vector_array : test_array :=(
	-- ADD
	(in1 => x"00000001", in2 => x"00000001", control => "0100", out1 => x"00000002"),
	(in1 => x"00000001", in2 => x"00000000", control => "0100", out1 => x"00000001"),
    (in1 => x"7FFFFFFF", in2 => x"00000001", control => "0100", out1 => x"80000000"),
	-- AND
	(in1 => x"00000001", in2 => x"00000001", control => "1010", out1 => x"00000001"),
	(in1 => x"00000001", in2 => x"00000000", control => "1010", out1 => x"00000000"),
    (in1 => x"7FFFFFFF", in2 => x"00000001", control => "1010", out1 => x"00000001"),
	-- OR
	(in1 => x"00000001", in2 => x"00000001", control => "1000", out1 => x"00000001"),
	(in1 => x"00000001", in2 => x"00000000", control => "1000", out1 => x"00000001"),
    (in1 => x"7FFFFFFF", in2 => x"00000001", control => "1000", out1 => x"7FFFFFFF"),
	-- XOR
	(in1 => x"00000001", in2 => x"00000001", control => "1011", out1 => x"00000000"),
	(in1 => x"00000001", in2 => x"00000000", control => "1011", out1 => x"00000001"),
    (in1 => x"7FFFFFFF", in2 => x"00000001", control => "1011", out1 => x"7FFFFFFE"),
	-- SLL
	(in1 => x"00000001", in2 => x"00000001", control => "1100", out1 => x"00000002"),
	(in1 => x"00000001", in2 => x"00000000", control => "1100", out1 => x"00000001"),
    (in1 => x"7FFFFFFF", in2 => x"00000001", control => "1100", out1 => x"FFFFFFFE"),
	-- SRA
	(in1 => x"00000001", in2 => x"00000001", control => "1110", out1 => x"00000000"),
	(in1 => x"FFFFFFFE", in2 => x"00000001", control => "1110", out1 => x"FFFFFFFF"),
    (in1 => x"7FFFFFFF", in2 => x"00000001", control => "1110", out1 => x"3FFFFFFF"),
	-- SRL
	(in1 => x"00000001", in2 => x"00000001", control => "1101", out1 => x"00000000"),
	(in1 => x"FFFFFFFE", in2 => x"00000001", control => "1101", out1 => x"7FFFFFFF"),
    (in1 => x"7FFFFFFF", in2 => x"00000001", control => "1101", out1 => x"3FFFFFFF"),
	-- SUB
	(in1 => x"00000001", in2 => x"00000001", control => "0101", out1 => x"00000000"),
	(in1 => x"00000001", in2 => x"00000000", control => "0101", out1 => x"00000001"),
    (in1 => x"7FFFFFFF", in2 => x"00000001", control => "0101", out1 => x"7FFFFFFE"),
    -- adder/subtractor overflow/underflow tests
    (in1 => x"FFFFFFFF", in2 => x"00000001", control => "0100", out1 => x"00000000"),
    (in1 => x"00000000", in2 => x"00000001", control => "0101", out1 => x"FFFFFFFF"),
    -- multiplier tests
    (in1 => x"00000001", in2 => x"00000001", control => "0110", out1 => x"00000001"),
    (in1 => x"00000001", in2 => x"00000002", control => "0110", out1 => x"00000002"),
    (in1 => x"00000001", in2 => x"00000003", control => "0110", out1 => x"00000003"),
    -- zero operand
    (in1 => x"00000001", in2 => x"00000000", control => "0110", out1 => x"00000000"),
    -- max operand
    (in1 => x"0000FFFF", in2 => x"0000FFFF", control => "0110", out1 => x"FFFE0001")
);

begin
    aluN_0 : alu port map (
        A  => in1,
        B  => in2,
        OP => control,
        Y  => out1
    );

	stim_proc : process
	begin
		for i in test_vector_array'range loop
			in1 <= test_vector_array(i).in1;
			in2 <= test_vector_array(i).in2;
			control <= test_vector_array(i).control;
			wait for 100 ns;

			assert out1 = test_vector_array(i).out1
			  report "Test " & integer'image(i) & " failed."
			  severity error;
			wait for 100 ns;
		end loop;

		assert false
		  report "Testbench Concluded."
		  severity note;

	end process; -- 6,200ns sim
end tb;
