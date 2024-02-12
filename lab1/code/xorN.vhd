-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date : 02/07/2024
-- Design Name : xorN
-- Module Name : xorN - dataflow
-- Project Name : Lab1
-- Target Devices : Basys3
--
-- Description : N-bit bitwise XOR unit
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xorN is
    GENERIC (N : INTEGER := 4); -- bit width
    PORT (
        A : IN std_logic_vector (N-1 downto 0);
        B : IN std_logic_vector (N-1 downto 0);
        Y : OUT std_logic_vector (N-1 downto 0)
    );
end xorN;

architecture dataflow of xorN is
begin
    Y <= A xor B;
end dataflow;
