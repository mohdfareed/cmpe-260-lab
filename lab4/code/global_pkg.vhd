-- ----------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date: 02/07/2024
-- Design Name: globals
-- Module Name: globals-package (library)
-- Project Name: Lab1
-- Target Devices: Basys3
--
-- Description: Constants used in top and test bench
-- level Xilinx does not like generics in the top level
-- of a design
-- ----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package globals is
    -- constant N : INTEGER := 4;
    -- constant M : INTEGER := 2; -- 2^M = N
    constant N : INTEGER := 32;
    constant M : INTEGER := 5; -- 2^M = N
end ;
