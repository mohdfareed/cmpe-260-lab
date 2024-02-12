-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date : 02/07/2024
-- Design Name : sRAN
-- Module Name : sRAN - behavioral
-- Project Name : Lab1
-- Target Devices : Basys3
--
-- Description : N-bit arithmetic right shift (SRA) unit
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sraN is
    GENERIC (N : INTEGER := 4; -- bit width
             M : INTEGER := 2); -- shift bits
    PORT (
        A : IN std_logic_vector (N-1 downto 0);
        SHIFT_AMT : IN std_logic_vector (M-1 downto 0);
        Y : OUT std_logic_vector (N-1 downto 0)
    );
end sraN;

architecture behavioral of sraN is
begin
    Y <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(SHIFT_AMT))));
end behavioral;
