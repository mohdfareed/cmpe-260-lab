-- ----------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date: 03/27/2024
-- Design Name: full_adder
-- Module Name: full_adder - structural
-- Project Name: Lab4
-- Target Devices: Basys3
--
-- Description: Complete 32-bit Full Adder
-- ----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port(A, B, Cin: in  STD_LOGIC;
         Sum, Cout: out STD_LOGIC);
end full_adder;

architecture structural of full_adder is
begin
    Sum <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A xor B));
end structural;
