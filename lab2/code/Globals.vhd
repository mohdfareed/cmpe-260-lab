------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date : 02/21/24
-- Design Name : globals
-- Module Name : globals - package (library)
-- Project Name : Lab2
-- Target Devices : Basys3
--
-- Description : Constants used in top and test bench level
-- Xilinx does not like generics in the top level of a design
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package globals is
constant BIT_DEPTH : INTEGER := 8;      -- data bus size
constant LOG_PORT_DEPTH : INTEGER := 3; -- address bus size
end;
