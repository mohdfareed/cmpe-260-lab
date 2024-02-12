-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date : 02/07/2024
-- Design Name : alu4
-- Module Name : alu4 - structural
-- Project Name : Lab1
-- Target Devices : Basys3
--
-- Description : Partial 4 - bit Arithmetic Logic Unit
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all; -- provides N and M to top level

entity alu4 is
    PORT (
        A  : IN std_logic_vector(N-1 downto 0);
        B  : IN std_logic_vector(N-1 downto 0);
        OP : IN std_logic_vector(4-1 downto 0); -- 4-bit opcode
        Y  : OUT std_logic_vector(N-1 downto 0)
    );
end alu4 ;

architecture structural of alu4 is
-- inverter component declaration
    Component notN is
        GENERIC (N : INTEGER := 4); -- bit width
        PORT (
            A : IN std_logic_vector (N-1 downto 0);
            Y : OUT std_logic_vector (N-1 downto 0)
        ) ;
end Component ;

signal not_result : std_logic_vector(N-1 downto 0);
signal sll_result : std_logic_vector(N-1 downto 0);
signal and_result : std_logic_vector(N-1 downto 0);
signal or_result  : std_logic_vector(N-1 downto 0);
signal xor_result : std_logic_vector(N-1 downto 0);
signal srl_result : std_logic_vector(N-1 downto 0);
signal sra_result : std_logic_vector(N-1 downto 0);

begin
    -- Instantiate the inverter, using component
    not_comp : notN
        generic map (N => N)
        port map (A => A , Y => not_result);

    sll_comp : entity work.sllN
        generic map (N => N, M => M)
        port map (A => A , SHIFT_AMT => B (M-1 downto 0) , Y => sll_result);
    and_comp : entity work.andN
        generic map (N => N)
        port map (A => A , B => B , Y => and_result);
    or_comp : entity work.orN
        generic map (N => N)
        port map (A => A , B => B , Y => or_result);
    xor_comp : entity work.xorN
        generic map (N => N)
        port map (A => A , B => B , Y => xor_result);
    srl_comp : entity work.srlN
        generic map (N => N, M => M)
        port map (A => A , SHIFT_AMT => B (M-1 downto 0) , Y => srl_result);
    sra_comp : entity work.sraN
        generic map (N => N, M => M)
        port map (A => A , SHIFT_AMT => B (M-1 downto 0) , Y => sra_result);

    -- Use OP to control which operation to show / perform
    with OP select
        Y <= not_result when "0000",
             or_result  when "1000",
             and_result when "1010",
             xor_result when "1011",
             sll_result when "1100",
             srl_result when "1101",
             sra_result when "1110",
             (others => '0') when others;
end structural;
