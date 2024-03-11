-------------------------------------------------
--  File:          contorl_unit.vhd
--
--  Entity:        ControlUnit
--  Architecture:  Behavioral
--  Author:        Mohammed Fareed
--  Created:       03/06/24
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of
--                 the complete control unit
-------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY ControlUnit IS
    PORT (
        opcode : IN STD_LOGIC_VECTOR (6 - 1 DOWNTO 0);
        funct : IN STD_LOGIC_VECTOR (6 - 1 DOWNTO 0);
        RegWrite : OUT STD_LOGIC;
        MemtoReg : OUT STD_LOGIC;
        MemWrite : OUT STD_LOGIC;
        ALUControl : OUT STD_LOGIC_VECTOR (4 - 1 DOWNTO 0);
        ALUSrc : OUT STD_LOGIC;
        RegDst : OUT STD_LOGIC);
END ControlUnit;

ARCHITECTURE Behavioral OF ControlUnit IS
BEGIN
    -- RegWrite
    PROCESS (opcode, funct)
    BEGIN
        CASE opcode IS
            WHEN "101011" => -- sw instruction
                RegWrite <= '0';
            WHEN OTHERS => -- all other instructions
                RegWrite <= '1';
        END CASE;
    END PROCESS;

    -- MemtoReg
    PROCESS (opcode, funct)
    BEGIN
        CASE opcode IS
            WHEN "100011" => -- lw instruction
                MemtoReg <= '1';
            WHEN OTHERS =>
                MemtoReg <= '0';
        END CASE;
    END PROCESS;

    -- MemWrite
    PROCESS (opcode, funct)
    BEGIN
        CASE opcode IS
            WHEN "101011" => -- sw instruction
                MemWrite <= '1';
            WHEN OTHERS =>
                MemWrite <= '0';
        END CASE;
    END PROCESS;

    -- ALUControl
    PROCESS (opcode, funct)
    BEGIN
        CASE opcode IS
            WHEN "000000" => -- R-type instructions
                CASE funct IS
                    WHEN "100100" => -- AND
                        ALUControl <= "1010";
                    WHEN "011000" => -- MULTU
                        ALUControl <= "0110";
                    WHEN "100101" => -- OR
                        ALUControl <= "1000";
                    WHEN "100110" => -- XOR
                        ALUControl <= "1011";
                    WHEN "000000" => -- SLL
                        ALUControl <= "1100";
                    WHEN "000011" => -- SRA
                        ALUControl <= "1110";
                    WHEN "000010" => -- SRL
                        ALUControl <= "1101";
                    WHEN "100010" => -- SUB
                        ALUControl <= "0101";
                    WHEN OTHERS => -- ADD
                        ALUControl <= "0100";
                END CASE;
            WHEN "001100" => -- ANDI
                ALUControl <= "1010";
            WHEN "001101" => -- ORI
                ALUControl <= "1000";
            WHEN "001110" => -- XORI
                ALUControl <= "1011";
            WHEN OTHERS => -- ADDI/SW/LW
                ALUControl <= "0100";
        END CASE;
    END PROCESS;

    -- ALUSrc
    PROCESS (opcode, funct)
    BEGIN
        CASE opcode IS
            WHEN "000000" => -- R-type instructions
                ALUSrc <= '0';
            WHEN OTHERS => -- I-type instructions
                ALUSrc <= '1';
        END CASE;
    END PROCESS;

    -- RegDst
    PROCESS (opcode, funct)
    BEGIN
        CASE opcode IS
            WHEN "000000" => -- R-type instructions
                RegDst <= '1';
            WHEN OTHERS => -- I-type instructions
                RegDst <= '0';
        END CASE;
    END PROCESS;
END Behavioral;
