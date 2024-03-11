-------------------------------------------------
--  File:          memory.vhd
--
--  Entity:        InstructionMemory
--  Architecture:  Behavioral
--  Author:        Mohammed Fareed
--  Created:       03/06/24
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of
--                 the complete instruction memory
-------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY InstructionMemory IS
    PORT (
        addr : IN STD_LOGIC_VECTOR(28 - 1 DOWNTO 0); -- instruction address
        d_out : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0)); -- instruction data

END InstructionMemory;

ARCHITECTURE Behavioral OF InstructionMemory IS
    -- memory is byte addressable and holds 1024 bytes
    TYPE memory IS ARRAY(0 TO 1024 - 1)
    OF STD_LOGIC_VECTOR(8 - 1 DOWNTO 0);

    -- initialize memory with instructions
    SIGNAL instructions : memory := (
        x"00", x"00", x"00", x"00",
        x"11", x"11", x"11", x"11",
        x"22", x"22", x"22", x"22",
        x"1f", x"2e", x"3d", x"4c",
        x"12", x"34", x"56", x"78",
        x"00", x"00", x"00", x"01",
        x"00", x"00", x"00", x"02",
        x"00", x"00", x"00", x"03",
        x"5a", x"5a", x"5a", x"5a",
        OTHERS => (OTHERS => '0')
    );

BEGIN
    PROCESS (addr, instructions)
        VARIABLE int_addr : INTEGER;
    BEGIN
        -- convert the address to integer
        int_addr := to_integer(unsigned(addr));
        -- check if addr is within the memory range
        IF (int_addr < 1024 - 3) THEN -- account for 4 byte instructions
            -- retrieve 4 bytes from memory
            d_out <= instructions(int_addr) &
                instructions(int_addr + 1) &
                instructions(int_addr + 2) &
                instructions(int_addr + 3);
        ELSE -- if addr is out of range, return 0s
            d_out <= (OTHERS => '0');
        END IF;
    END PROCESS;
END Behavioral;
