-- ----------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date: 02/07/2024
-- Design Name: alu4
-- Module Name: alu4 - structural
-- Project Name: Lab1
-- Target Devices: Basys3
--
-- Description: MIPS execute stage
-- ----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all; -- provides N and M to top level

entity execute is
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
end execute;

architecture structural of execute is
    signal ALUSrcB: STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
begin
    ALUSrcB <= SignImm when ALUSrc = '1' else RegSrcB;
    alu_comp : entity work.alu
        port map (
            A => RegSrcA,
            B => ALUSrcB,
            OP => ALUControl,
            Y => ALUResult
        );

    RegWriteOut <= RegWrite;
    MemtoRegOut <= MemtoReg;
    MemWriteOut <= MemWrite;
    WriteData <= RegSrcB;
    WriteReg <= RdDest when RegDst = '1' else RtDest;
end structural;
