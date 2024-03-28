-------------------------------------------------
--  File:          executeTB.vhd
--
--  Entity:        execute_tb
--  Architecture:  testbench
--  Author:        Jason Blocklove, Mohammed Fareed
--  Created:       09/04/19
--  Modified:      03/06/24
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 testbench for the Execute stage
-------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY execute_tb IS
END execute_tb;

ARCHITECTURE Behavioral OF execute_tb IS

    component execute is
    PORT (
        RegWrite   : IN STD_LOGIC;
        MemtoReg   : IN STD_LOGIC;
        MemWrite   : IN STD_LOGIC;
        ALUControl : IN STD_LOGIC_VECTOR (4 - 1 DOWNTO 0);
        ALUSrc     : IN STD_LOGIC;
        RegDst     : IN STD_LOGIC;

        RegSrcA : IN STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
        RegSrcB : IN STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);

        RtDest  : IN STD_LOGIC_VECTOR (5 - 1 DOWNTO 0);
        RdDest  : IN STD_LOGIC_VECTOR (5 - 1 DOWNTO 0);
        SignImm : IN STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);

        RegWriteOut : OUT STD_LOGIC;
        MemtoRegOut : OUT STD_LOGIC;
        MemWriteOut : OUT STD_LOGIC;
        ALUResult   : OUT STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
        WriteData   : OUT STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
        WriteReg    : OUT STD_LOGIC_VECTOR (5 - 1 DOWNTO 0)
    );
    end component;

    TYPE test_vector IS RECORD
        RegWrite : STD_LOGIC;
        MemtoReg : STD_LOGIC;
        MemWrite : STD_LOGIC;
        ALUControl : STD_LOGIC_VECTOR(3 DOWNTO 0);
        ALUSrc : STD_LOGIC;
        RegDst : STD_LOGIC;
        RegSrcA, RegSrcB : STD_LOGIC_VECTOR(31 DOWNTO 0);
        RtDest : STD_LOGIC_VECTOR(4 DOWNTO 0);
        RdDest : STD_LOGIC_VECTOR(4 DOWNTO 0);
        SignImm : STD_LOGIC_VECTOR(31 DOWNTO 0);
        -- outputs
        ALUResult : STD_LOGIC_VECTOR(31 DOWNTO 0);
        WriteReg : STD_LOGIC_VECTOR(4 DOWNTO 0);
    END RECORD;

    TYPE test_array IS ARRAY (NATURAL RANGE <>) OF test_vector;
    -- test for each ALU operation
    CONSTANT test_vector_array : test_array := (
        -- ADD/ADDI/SW/LW
        (RegWrite => '0', MemtoReg => '0', MemWrite => '0',
        ALUControl => "0100", ALUSrc => '0', RegDst => '1',
        RegSrcA => X"00000001", RegSrcB => X"00000002",
        RtDest => "00010", RdDest => "00100", SignImm => X"00000000",
        ALUResult => X"00000003", WriteReg => "00100"),
        -- AND/ANDI
        (RegWrite => '0', MemtoReg => '1', MemWrite => '0',
        ALUControl => "1010", ALUSrc => '1', RegDst => '0',
        RegSrcA => X"00000001", RegSrcB => X"00000002",
        RtDest => "00001", RdDest => "00010", SignImm => X"00000003",
        ALUResult => X"00000001", WriteReg => "00001"),
        -- MULTU
        (RegWrite => '1', MemtoReg => '0', MemWrite => '0',
        ALUControl => "0110", ALUSrc => '0', RegDst => '0',
        RegSrcA => X"00000001", RegSrcB => X"00000002",
        RtDest => "00000", RdDest => "00000", SignImm => X"00000000",
        ALUResult => X"00000002", WriteReg => "00000"),
        -- OR/ORI
        (RegWrite => '0', MemtoReg => '0', MemWrite => '0',
        ALUControl => "1000", ALUSrc => '0', RegDst => '0',
        RegSrcA => X"00000001", RegSrcB => X"00000002",
        RtDest => "00000", RdDest => "00000", SignImm => X"00000000",
        ALUResult => X"00000003", WriteReg => "00000"),
        -- XOR/XORI
        (RegWrite => '0', MemtoReg => '0', MemWrite => '0',
        ALUControl => "1011", ALUSrc => '0', RegDst => '0',
        RegSrcA => X"00000001", RegSrcB => X"00000002",
        RtDest => "00000", RdDest => "00000", SignImm => X"00000000",
        ALUResult => X"00000003", WriteReg => "00000"),
        -- SLL/SLLI
        (RegWrite => '0', MemtoReg => '0', MemWrite => '0',
        ALUControl => "1100", ALUSrc => '0', RegDst => '0',
        RegSrcA => X"00000001", RegSrcB => X"00000002",
        RtDest => "00000", RdDest => "00000", SignImm => X"00000000",
        ALUResult => X"00000004", WriteReg => "00000"),
        -- SRL/SRLI
        (RegWrite => '0', MemtoReg => '0', MemWrite => '0',
        ALUControl => "1101", ALUSrc => '0', RegDst => '0',
        RegSrcA => X"00000003", RegSrcB => X"00000001",
        RtDest => "00000", RdDest => "00000", SignImm => X"00000000",
        ALUResult => X"00000001", WriteReg => "00000"),
        -- SRA/SRAI
        (RegWrite => '0', MemtoReg => '0', MemWrite => '0',
        ALUControl => "1110", ALUSrc => '0', RegDst => '0',
        RegSrcA => X"F0000000", RegSrcB => X"00000001",
        RtDest => "00000", RdDest => "00000", SignImm => X"00000000",
        ALUResult => X"F8000000", WriteReg => "00000")
    );

    SIGNAL RegWrite : STD_LOGIC;
    SIGNAL MemtoReg : STD_LOGIC;
    SIGNAL MemWrite : STD_LOGIC;
    SIGNAL ALUControl : STD_LOGIC_VECTOR (4 - 1 DOWNTO 0);
    SIGNAL ALUSrc : STD_LOGIC;
    SIGNAL RegDst : STD_LOGIC;

    SIGNAL RegSrcA, RegSrcB : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
    SIGNAL RtDest : STD_LOGIC_VECTOR (5 - 1 DOWNTO 0);
    SIGNAL RdDest : STD_LOGIC_VECTOR (5 - 1 DOWNTO 0);
    SIGNAL SignImm : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);

    SIGNAL RegWriteOut : STD_LOGIC;
    SIGNAL MemtoRegOut : STD_LOGIC;
    SIGNAL MemWriteOut : STD_LOGIC;
    SIGNAL ALUResult : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
    SIGNAL WriteData : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
    SIGNAL WriteReg : STD_LOGIC_VECTOR (5 - 1 DOWNTO 0);

BEGIN
    UUT : execute
    PORT MAP(
        --------- INPUTS ------------------
        RegWrite => RegWrite,
        MemtoReg => MemtoReg,
        MemWrite => MemWrite,
        ALUControl => ALUControl,
        ALUSrc => ALUSrc,
        RegDst => RegDst,
        RegSrcA => RegSrcA,
        RegSrcB => RegSrcB,
        RtDest => RtDest,
        RdDest => RdDest,
        SignImm => SignImm,
        ---------- OUTPUTS ----------------
        RegWriteOut => RegWriteOut,
        MemtoRegOut => MemtoRegOut,
        MemWriteOut => MemWriteOut,
        ALUResult => ALUResult,
        WriteData => WriteData,
        WriteReg => WriteReg
    );

    stim_proc : PROCESS
    BEGIN
        FOR i IN test_vector_array'RANGE LOOP
            RegWrite <= test_vector_array(i).RegWrite;
            MemtoReg <= test_vector_array(i).MemtoReg;
            MemWrite <= test_vector_array(i).MemWrite;
            ALUControl <= test_vector_array(i).ALUControl;
            ALUSrc <= test_vector_array(i).ALUSrc;
            RegDst <= test_vector_array(i).RegDst;
            RegSrcA <= test_vector_array(i).RegSrcA;
            RegSrcB <= test_vector_array(i).RegSrcB;
            RtDest <= test_vector_array(i).RtDest;
            RdDest <= test_vector_array(i).RdDest;
            SignImm <= test_vector_array(i).SignImm;
            wait for 100 ns;

            ASSERT (RegWriteOut = test_vector_array(i).RegWrite) AND
                     (MemtoRegOut = test_vector_array(i).MemtoReg) AND
                     (MemWriteOut = test_vector_array(i).MemWrite) AND
                     (ALUResult = test_vector_array(i).ALUResult) AND
                     (WriteData = test_vector_array(i).RegSrcB) AND
                     (WriteReg = test_vector_array(i).WriteReg)
            REPORT "Test vector " & INTEGER'IMAGE(i) & " failed"
                SEVERITY failure;
            wait for 100 ns;
        END LOOP;

        ASSERT false
        REPORT "Testbench Concluded"
            SEVERITY note;
    END PROCESS; --1,600ns sim
END Behavioral;
