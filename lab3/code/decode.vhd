-------------------------------------------------
--  File:          decode.vhd
--
--  Entity:        IntructionDecode
--  Architecture:  Behavioral
--  Author:        Mohammed Fareed
--  Created:       03/06/24
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of
--                 the instruction decode stage
-------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY InstructionDecode IS
    PORT (
        clk : IN STD_LOGIC;
        Instruction : IN STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
        RegWriteAddr : IN STD_LOGIC_VECTOR (5 - 1 DOWNTO 0);
        RegWriteData : IN STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
        RegWriteEn : IN STD_LOGIC;

        RegWrite : OUT STD_LOGIC;
        MemtoReg : OUT STD_LOGIC;
        MemWrite : OUT STD_LOGIC;
        ALUControl : OUT STD_LOGIC_VECTOR (4 - 1 DOWNTO 0);
        ALUSrc : OUT STD_LOGIC;
        RegDst : OUT STD_LOGIC;

        RD1 : OUT STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
        RD2 : OUT STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);

        RtDest : OUT STD_LOGIC_VECTOR (5 - 1 DOWNTO 0);
        RdDest : OUT STD_LOGIC_VECTOR (5 - 1 DOWNTO 0);
        ImmOut : OUT STD_LOGIC_VECTOR (32 - 1 DOWNTO 0));
END InstructionDecode;

ARCHITECTURE Structural OF InstructionDecode IS
    COMPONENT RegisterFile
        PORT (
            clk_n : IN STD_LOGIC;
            we : IN STD_LOGIC;
            Addr1 : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
            Addr2 : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
            Addr3 : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
            wd : IN STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
            RD1 : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
            RD2 : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0));
    END COMPONENT;

    COMPONENT ControlUnit
        PORT (
            opcode : IN STD_LOGIC_VECTOR (6 - 1 DOWNTO 0);
            funct : IN STD_LOGIC_VECTOR (6 - 1 DOWNTO 0);
            RegWrite : OUT STD_LOGIC;
            MemtoReg : OUT STD_LOGIC;
            MemWrite : OUT STD_LOGIC;
            ALUControl : OUT STD_LOGIC_VECTOR (4 - 1 DOWNTO 0);
            ALUSrc : OUT STD_LOGIC;
            RegDst : OUT STD_LOGIC);
    END COMPONENT;

BEGIN
    rf : RegisterFile PORT MAP(
        clk_n => clk,
        we => RegWriteEn,
        Addr1 => Instruction(25 DOWNTO 21),
        Addr2 => Instruction(20 DOWNTO 16),
        Addr3 => RegWriteAddr,
        wd => RegWriteData,
        RD1 => RD1,
        RD2 => RD2);

    cu : ControlUnit PORT MAP(
        opcode => Instruction(31 DOWNTO 26),
        funct => Instruction(5 DOWNTO 0),
        RegWrite => RegWrite,
        MemtoReg => MemtoReg,
        MemWrite => MemWrite,
        ALUControl => ALUControl,
        ALUSrc => ALUSrc,
        RegDst => RegDst);

    RtDest <= Instruction(20 DOWNTO 16);
    RdDest <= Instruction(15 DOWNTO 11);
    ImmOut <= (15 DOWNTO 0 => Instruction(15)) & Instruction(15 DOWNTO 0);
END Structural;
