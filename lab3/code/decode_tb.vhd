-------------------------------------------------
--  File:          InstructionDecodeTB.vhd
--
--  Entity:        InstructionDecodeTB
--  Architecture:  testbench
--  Author:        Jason Blocklove, Mohammed Fareed
--  Created:       09/04/19
--  Modified:      03/06/24
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 testbench for InstructionDecode
--                 stage
-------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY InstructionDecodeTB IS
END InstructionDecodeTB;

ARCHITECTURE Behavioral OF InstructionDecodeTB IS
    TYPE test_vector IS RECORD
        Instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
        RegWriteAddr : STD_LOGIC_VECTOR(4 DOWNTO 0);
        RegWriteData : STD_LOGIC_VECTOR(31 DOWNTO 0);
        RegWriteEn : STD_LOGIC;
        RegWrite : STD_LOGIC;
        MemtoReg : STD_LOGIC;
        MemWrite : STD_LOGIC;
        ALUControl : STD_LOGIC_VECTOR(3 DOWNTO 0);
        ALUSrc : STD_LOGIC;
        RegDst : STD_LOGIC;
        RD1, RD2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
        RtDest : STD_LOGIC_VECTOR(4 DOWNTO 0);
        RdDest : STD_LOGIC_VECTOR(4 DOWNTO 0);
        ImmOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    END RECORD;

    TYPE test_array IS ARRAY (NATURAL RANGE <>) OF test_vector;
    CONSTANT test_vector_array : test_array := (
        --NOOP
        (Instruction => x"00000000",
        RegWriteAddr => "00000",
        RegWriteData => x"00000000",
        RegWriteEn => '0',
        RegWrite => '1',
        MemtoReg => '0',
        MemWrite => '0',
        ALUControl => "1100",
        ALUSrc => '0',
        RegDst => '1',
        RD1 => x"00000000",
        RD2 => x"00000000",
        RtDest => "00000",
        RdDest => "00000",
        ImmOut => x"00000000"),
        --ADD R1, R1, R2 - 000000.00001.00001.00010.00000.100000
        (Instruction => x"00211020",
        RegWriteAddr => "00001",
        RegWriteData => x"12121212",
        RegWriteEn => '1',
        RegWrite => '1',
        MemtoReg => '0',
        MemWrite => '0',
        ALUControl => "0100",
        ALUSrc => '0',
        RegDst => '1',
        RD1 => x"12121212",
        RD2 => x"12121212",
        RtDest => "00001",
        RdDest => "00010",
        ImmOut => x"00001020"),
        --ADDI R1, R1, 13 - 001000.00001.00001.0000000000001101
        (Instruction => x"2021000d",
        RegWriteAddr => "00010",
        RegWriteData => x"00000001",
        RegWriteEn => '1',
        RegWrite => '1',
        MemtoReg => '0',
        MemWrite => '0',
        ALUControl => "0100",
        ALUSrc => '1',
        RegDst => '0',
        RD1 => x"12121212",
        RD2 => x"12121212",
        RtDest => "00001",
        RdDest => "00000",
        ImmOut => x"0000000d"),

        --LW R1, 0(R2) - 100011.00010.00001.0000000000000000
        (Instruction => x"8C410000",
        RegWriteAddr => "00001",
        RegWriteData => x"00000000",
        RegWriteEn => '1',
        RegWrite => '1',
        MemtoReg => '1',
        MemWrite => '0',
        ALUControl => "0100",
        ALUSrc => '1',
        RegDst => '0',
        RD1 => x"00000001",
        RD2 => x"00000000",
        RtDest => "00001",
        RdDest => "00000",
        ImmOut => x"00000000"),
        --SLL R1, R2, 2 - 000000.00010.00001.00010.00000.000000
        (Instruction => x"00411000",
        RegWriteAddr => "00010",
        RegWriteData => x"00000000",
        RegWriteEn => '1',
        RegWrite => '1',
        MemtoReg => '0',
        MemWrite => '0',
        ALUControl => "1100",
        ALUSrc => '0',
        RegDst => '1',
        RD1 => x"00000000",
        RD2 => x"00000000",
        RtDest => "00001",
        RdDest => "00010",
        ImmOut => x"00001000")
    );

    COMPONENT InstructionDecode IS
        PORT (
            --------- INPUTS ------------------
            --Main Input
            Instruction : IN STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
            --CLK
            clk : IN STD_LOGIC;
            --WB Inputs
            RegWriteAddr : IN STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
            RegWriteData : IN STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
            RegWriteEn : IN STD_LOGIC;

            ---------- OUTPUTS ----------------
            --Cotrol Unit Outputs
            RegWrite : OUT STD_LOGIC;
            MemtoReg : OUT STD_LOGIC;
            MemWrite : OUT STD_LOGIC;
            ALUControl : OUT STD_LOGIC_VECTOR(4 - 1 DOWNTO 0);
            ALUSrc : OUT STD_LOGIC;
            RegDst : OUT STD_LOGIC;
            --Register File Outputs
            RD1, RD2 : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0);
            --Other Outputs
            RtDest : OUT STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
            RdDest : OUT STD_LOGIC_VECTOR(5 - 1 DOWNTO 0);
            ImmOut : OUT STD_LOGIC_VECTOR(32 - 1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL Instruction : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL RegWriteEn : STD_LOGIC := '0';
    SIGNAL RegWriteAddr : STD_LOGIC_VECTOR (5 - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL RegWriteData : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0) := (OTHERS => '0');

    SIGNAL RegWrite : STD_LOGIC;
    SIGNAL MemtoReg : STD_LOGIC;
    SIGNAL MemWrite : STD_LOGIC;
    SIGNAL ALUControl : STD_LOGIC_VECTOR (4 - 1 DOWNTO 0);
    SIGNAL ALUSrc : STD_LOGIC;
    SIGNAL RegDst : STD_LOGIC;

    SIGNAL RD1, RD2 : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
    SIGNAL RtDest : STD_LOGIC_VECTOR (5 - 1 DOWNTO 0);
    SIGNAL RdDest : STD_LOGIC_VECTOR (5 - 1 DOWNTO 0);
    SIGNAL ImmOut : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);

BEGIN
    UUT : InstructionDecode
    PORT MAP(
        --------- INPUTS ------------------
        --Main Input
        Instruction => Instruction,
        --CLK
        clk => clk,
        --WB Inputs
        RegWriteAddr => RegWriteAddr,
        RegWriteData => RegWriteData,
        RegWriteEn => RegWriteEn,

        ---------- OUTPUTS ----------------
        --Cotrol Unit Outputs
        RegWrite => RegWrite,
        MemtoReg => MemtoReg,
        MemWrite => MemWrite,
        ALUControl => ALUControl,
        ALUSrc => ALUSrc,
        RegDst => RegDst,
        --Register File Outputs
        RD1 => RD1,
        RD2 => RD2,
        --Other Outputs
        RtDest => RtDest,
        RdDest => RdDest,
        ImmOut => ImmOut
    );

    clk_proc : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 50 ns;
        clk <= '1';
        WAIT FOR 50 ns;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
        WAIT UNTIL clk = '0';
        FOR i IN test_vector_array'RANGE LOOP
            WAIT UNTIL clk = '1';
            Instruction <= test_vector_array(i).Instruction;
            RegWriteAddr <= test_vector_array(i).RegWriteAddr;
            RegWriteData <= test_vector_array(i).RegWriteData;
            RegWriteEn <= test_vector_array(i).RegWriteEn;
            WAIT UNTIL clk = '0';
            WAIT FOR 5 ns;

            ASSERT (RegWrite = test_vector_array(i).RegWrite) AND
            (MemtoReg = test_vector_array(i).MemtoReg) AND
            (MemWrite = test_vector_array(i).MemWrite) AND
            (ALUControl = test_vector_array(i).ALUControl) AND
            (ALUSrc = test_vector_array(i).ALUSrc) AND
            (RegDst = test_vector_array(i).RegDst) AND
            (RD1 = test_vector_array(i).RD1) AND
            (RD2 = test_vector_array(i).RD2) AND
            (RtDest = test_vector_array(i).RtDest) AND
            (RdDest = test_vector_array(i).RdDest) AND
            (ImmOut = test_vector_array(i).ImmOut)
            REPORT "Test vector " & INTEGER'IMAGE(i) & " failed"
                SEVERITY failure;
        END LOOP;
        WAIT UNTIL clk = '0';

        ASSERT false
        REPORT "Testbench Concluded"
            SEVERITY note;
    END PROCESS;
END Behavioral;
