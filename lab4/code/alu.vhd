-- ----------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date: 02/07/2024
-- Design Name: alu4
-- Module Name: alu4 - structural
-- Project Name: Lab1
-- Target Devices: Basys3
--
-- Description: Complete 32-bit Arithmetic Logic Unit
-- ----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all; -- provides N and M to top level

entity alu is
    PORT (
        A  : IN  std_logic_vector(N-1 downto 0);
        B  : IN  std_logic_vector(N-1 downto 0);
        OP : IN  std_logic_vector(4-1 downto 0); -- 4-bit opcode
        Y  : OUT std_logic_vector(N-1 downto 0)
    );
end alu;

architecture structural of alu is

signal not_result : std_logic_vector(N-1 downto 0);
signal and_result : std_logic_vector(N-1 downto 0);
signal or_result  : std_logic_vector(N-1 downto 0);
signal xor_result : std_logic_vector(N-1 downto 0);

signal sll_result : std_logic_vector(N-1 downto 0);
signal srl_result : std_logic_vector(N-1 downto 0);
signal sra_result : std_logic_vector(N-1 downto 0);

signal add_result : std_logic_vector(N-1 downto 0);
signal sub_result : std_logic_vector(N-1 downto 0);
signal mul_result : std_logic_vector(N-1 downto 0);

begin
    not_comp : entity work.notN
        generic map (N => N)
        port map (A => A, Y => not_result);
    and_comp : entity work.andN
        generic map (N => N)
        port map (A => A, B => B, Y => and_result);
    or_comp : entity work.orN
        generic map (N => N)
        port map (A => A, B => B, Y => or_result);
    xor_comp : entity work.xorN
        generic map (N => N)
        port map (A => A, B => B, Y => xor_result);

    sll_comp : entity work.sllN
        generic map (N => N, M => M)
        port map (A => A, SHIFT_AMT => B (M-1 downto 0), Y => sll_result);
    srl_comp : entity work.srlN
        generic map (N => N, M => M)
        port map (A => A, SHIFT_AMT => B (M-1 downto 0), Y => srl_result);
    sra_comp : entity work.sraN
        generic map (N => N, M => M)
        port map (A => A, SHIFT_AMT => B (M-1 downto 0), Y => sra_result);

    add_comp : entity work.addN
        generic map (N => N)
        port map (A => A, B => B, OP => '0', Y => add_result);

    sub_comp : entity work.addN
        generic map (N => N)
        port map (A => A, B => B, OP => '1', Y => sub_result);

    mul_comp : entity work.mulN
        generic map (N => N)
        -- take only the lower N/2 bits of the operands
        port map (A => A(N/2-1 downto 0), B => B(N/2-1 downto 0), Y => mul_result);

    with OP select
        Y <= add_result when "0100",
             and_result when "1010",
             mul_result when "0110",
             or_result  when "1000",
             xor_result when "1011",
             sll_result when "1100",
             sra_result when "1110",
             srl_result when "1101",
             sub_result when "0101",
             not_result when others; -- default to NOT
end structural;
