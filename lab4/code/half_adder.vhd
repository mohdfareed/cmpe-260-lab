-- ----------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date: 03/27/2024
-- Design Name: half_adder
-- Module Name: half_adder - structural
-- Project Name: Lab4
-- Target Devices: Basys3
--
-- Description: Complete 32-bit Half Adder
-- ----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    Port(A, B      : in  STD_LOGIC;
         Sum, Carry: out STD_LOGIC);
end half_adder;

architecture structural of half_adder is
begin
    Sum <= A xor B;
    Carry <= A and B;
end structural;
