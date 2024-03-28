-------------------------------------------------
--  File:          mulTB.vhd
--
--  Entity:        mulTB
--  Architecture:  Testbench
--  Author:        Jason Blocklove
--  Created:       07/29/19
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                mulTB
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all; -- provides N and M to top level

entity mulTB is
end mulTB;

architecture tb of mulTB is

component mulN IS
    generic (N : integer := 32);
    Port(A, B : in  STD_LOGIC_VECTOR((N/2)-1 downto 0);
         Y    : out STD_LOGIC_VECTOR(N-1 downto 0));
end component;

signal in1  : std_logic_vector(16-1 downto 0);
signal in2  : std_logic_vector(16-1 downto 0);
signal out1 : std_logic_vector(32-1 downto 0);

type mul_tests is record
	-- Test Inputs
	in1 : std_logic_vector(15 downto 0);
	in2 : std_logic_vector(15 downto 0);
	-- Test Outputs
	out1 : std_logic_vector(31 downto 0);
end record;

type test_array is array (natural range <>) of mul_tests;

constant test_vector_array : test_array :=(
    -- 7 general cases
    ( x"0001", x"0001", x"00000001"),
    ( x"0001", x"0002", x"00000002"),
    ( x"0001", x"0003", x"00000003"),
    ( x"0001", x"0004", x"00000004"),
    ( x"0001", x"0005", x"00000005"),
    ( x"0001", x"0006", x"00000006"),
    ( x"0001", x"0007", x"00000007"),
    -- zero operand
    ( x"0001", x"0000", x"00000000"),
    -- max operand
    ( x"FFFF", x"FFFF", x"FFFE0001"),
    -- overflow without maximum operands
    ( x"7FFF", x"7FFF", x"3FFF0001")
);

begin

mulN_0 : mulN
    port map (
			A  => in1,
			B  => in2,
            Y  => out1
		);

	stim_proc:process
	begin
		for i in test_vector_array'range loop
			in1 <= test_vector_array(i).in1;
			in2 <= test_vector_array(i).in2;
			wait for 100 ns;

			assert out1 = test_vector_array(i).out1
			  report "Test " & integer'image(i) & " failed."
			  severity error;
			wait for 100 ns;
		end loop;

		assert false
		  report "Testbench Concluded."
		  severity note;

	end process; -- 2,000ns sim
end tb;
