-------------------------------------------------
--  File:          register_file.vhd
--
--  Entity:        RegisterFile
--  Architecture:  Behavioral
--  Author:        Mohammed Fareed
--  Created:       03/06/24
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of
--                 the complete register file
-------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY RegisterFile IS
    PORT (
        clk_n : IN STD_LOGIC;
        we : IN STD_LOGIC;
        Addr1 : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
        Addr2 : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
        Addr3 : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
        wd : IN STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
        RD1 : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
        RD2 : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0));
END RegisterFile;

ARCHITECTURE Behavioral OF RegisterFile IS
    -- Initialize all registers to 0
    TYPE reg_array IS ARRAY (2 ** 5 - 1 DOWNTO 0)
    OF STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
    SIGNAL registers : reg_array := (OTHERS => (OTHERS => '0'));
BEGIN
    PROCESS (clk_n)
    BEGIN
        IF clk_n'event AND clk_n = '0' THEN -- Check for falling edge
            -- Check for write enable and non-zero write address
            IF we = '1' AND Addr3 /= "00000" THEN
                -- Perform write operation
                registers(to_integer(unsigned(Addr3))) <= wd;
            END IF;
        END IF;
    END PROCESS;

    -- Conditional Signal Assignment for read operations
    RD1 <= registers(to_integer(unsigned(Addr1)));
    RD2 <= registers(to_integer(unsigned(Addr2)));
END Behavioral;
