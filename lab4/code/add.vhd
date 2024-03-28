-- ----------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date: 03/27/2024
-- Design Name: add
-- Module Name: add - behavioral
-- Project Name: Lab4
-- Target Devices: Basys3
--
-- Description: N-bit adder/subtractor unit
-- ----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity addN is
    GENERIC (N : INTEGER := 32); -- shift bits
    PORT (A, B : IN  std_logic_vector(N-1 downto 0);
          OP   : IN  std_logic; -- 0 for add, 1 for subtract
          Y    : OUT std_logic_vector(N-1 downto 0));
end addN;

architecture structural of addN is
    signal carry : std_logic_vector(N downto 0);
    signal sum : std_logic_vector(N-1 downto 0);
    signal b_comp : std_logic_vector(N-1 downto 0);
begin
    carry(0) <= OP;
    FA: for i in 0 to N-1 generate
        b_comp(i) <=  B(i) xor OP;
        FAi: entity work.full_adder
            port map (A => A(i), B => b_comp(i), Cin => carry(i),
                      Sum => sum(i), Cout => carry(i+1));
    end generate FA;
    Y <= sum;
end structural;
