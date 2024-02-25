-------------------------------------------------
--  File:          RegisterFile.vhd
--
--  Entity:        RegisterFile
--  Architecture:  testbench
--  Author:        Mohammed Fareed
--  Created:       02/21/24
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of
--                 the complete register file
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all;

entity RegisterFile is
    PORT (
        clk_n   : in  std_logic;
        we      : in  std_logic;
        Addr1   : in  std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
        Addr2   : in  std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
        Addr3   : in  std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
        wd      : in  std_logic_vector(BIT_DEPTH-1 downto 0);
        RD1     : out std_logic_vector(BIT_DEPTH-1 downto 0);
        RD2     : out std_logic_vector(BIT_DEPTH-1 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    type reg_array is array (2**LOG_PORT_DEPTH-1 downto 0) of std_logic_vector(BIT_DEPTH-1 downto 0);
    -- Initialize all registers to 0
    signal registers : reg_array := (others => (others => '0'));

begin
    process(clk_n)
    begin
        if clk_n'event and clk_n = '0' then -- Check for falling edge
            -- Check for write enable and non-zero write address
            if we = '1' and Addr3 /= "000" then
                -- Perform write operation
                registers(to_integer(unsigned(Addr3))) <= wd;
            end if;
        end if;
    end process;

    -- Conditional Signal Assignment for read operations
    RD1 <= registers(to_integer(unsigned(Addr1))) when Addr1 /= "000" else (others => '0');
    RD2 <= registers(to_integer(unsigned(Addr2))) when Addr2 /= "000" else (others => '0');
end Behavioral;
