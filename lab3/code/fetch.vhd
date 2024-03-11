-------------------------------------------------
--  File:          fetch.vhd
--
--  Entity:        InstructionFetch
--  Architecture:  Behavioral
--  Author:        Mohammed Fareed
--  Created:       03/06/24
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of
--                 the fetch stage of the pipeline
-------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY InstructionFetch IS
    PORT (
        clk, rst : IN STD_LOGIC;
        Instruction : OUT STD_LOGIC_VECTOR (32 - 1 DOWNTO 0));
END InstructionFetch;

ARCHITECTURE Behavioral OF InstructionFetch IS
    COMPONENT InstructionMemory IS
        PORT (
            addr : IN STD_LOGIC_VECTOR (28 - 1 DOWNTO 0);
            d_out : OUT STD_LOGIC_VECTOR (32 - 1 DOWNTO 0));
    END COMPONENT;
    SIGNAL pc : STD_LOGIC_VECTOR(28 - 1 DOWNTO 0) := (OTHERS => '0');

BEGIN
    -- instantiate instruction memory
    memory : InstructionMemory PORT MAP(addr => pc, d_out => Instruction);
    PROCESS (clk, rst)
    BEGIN -- fetch instructions each clock cycle
        IF rst = '1' THEN -- asynchronous reset
            pc <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN -- update pc on rising edge
            pc <= STD_LOGIC_VECTOR(unsigned(pc) + 4);
        END IF;
    END PROCESS;
END Behavioral;
