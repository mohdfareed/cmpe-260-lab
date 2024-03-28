-- ----------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Mohammed Fareed (mff9108@rit.edu)
--
-- Create Date: 03/27/2024
-- Design Name: mul
-- Module Name: mul - structural
-- Project Name: Lab4
-- Target Devices: Basys3
--
-- Description: Complete 32-bit Binary Multiplier
-- ----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mulN is
    GENERIC (N : INTEGER := 32); -- bit width
    Port(A, B : in  STD_LOGIC_VECTOR((N/2)-1 downto 0);
         Y    : out STD_LOGIC_VECTOR(N-1 downto 0));
end mulN;

architecture structural of mulN is
    type sum_matrix is array (0 to (N/2)-1) of std_logic_vector((N/2)-1 downto 0);
    type product_matrix is array (1 to (N/2)-1) of std_logic_vector((N/2)-1 downto 0);
    type carry_vector is array (1 to (N/2)-1) of std_logic_vector((N/2)-1 downto 0);

    signal sum: sum_matrix := (others => (others => '0'));
    signal partial_product: product_matrix := (others => (others => '0'));
    signal carry_bits: carry_vector := (others => (others => '0'));
    
    function construct_output_vector(carry_bits: carry_vector; sum: sum_matrix; N: integer) return std_logic_vector is
    variable result: std_logic_vector(((N/2) * 2) - 1 downto 0); -- Adjust size based on your needs
    variable index: integer := 0;
    begin
        -- Add the last carry bit
        result(result'high) := carry_bits((N/2)-1)((N/2)-1);
        index := result'high - 1;
        
        -- Add the entire sum array from the last row
        for i in sum((N/2)-1)'range loop
            result(index) := sum((N/2)-1)(i);
            index := index - 1;
        end loop;
        
        -- Add the first bit of each sum row, from the second-to-last row back to the first row
        for row in (N/2)-2 downto 0 loop
            result(index) := sum(row)(0);
            index := index - 1;
        end loop;
    
        return result;
    end function;

begin
    -- first row
    gen_first_row: for j in 0 to (N/2)-1 generate
        and_gate: entity work.andN
        generic map(N => 1)
        port map(
            A => A(j downto j),
            B => B(0 downto 0),
            Y => sum(0)(j downto j)
        );
    end generate;

    -- partial products
    gen_pp: for i in 1 to (N/2)-1 generate
        gen_pp: for j in 0 to (N/2)-1 generate
            and_gate: entity work.andN
            generic map(N => 1)
            port map(
                A => A(j downto j),
                B => B(i downto i),
                Y => partial_product(i)(j downto j)
            );
        end generate;
    end generate;

    -- first column
    gen_first_col: for i in 1 to (N/2)-1 generate
        half_adder: entity work.half_adder port map(
            A => sum(i - 1)(1),
            B => partial_product(i)(0),
            Sum => sum(i)(0),
            Carry => carry_bits(i)(0)
        );
    end generate;

    -- last column
    gen_last_col: for i in 1 to (N/2)-1 generate
        gen_half_adder: if i = 1 generate
            half_adder: entity work.half_adder port map(
                A => carry_bits(1)((N/2)-2),
                B => partial_product(1)((N/2)-1),
                Sum => sum(1)((N/2)-1),
                Carry => carry_bits(1)((N/2)-1)
            );
        end generate;
        gen_full_adder: if i > 1 generate
            full_adder: entity work.full_adder port map(
                A => carry_bits(i)((N/2)-2),
                B => carry_bits(i - 1)((N/2)-1),
                Cin => partial_product(i)((N/2)-1),
                Sum => sum(i)((N/2)-1),
                Cout => carry_bits(i)((N/2)-1)
            );
        end generate;
    end generate;

    -- remaining cells
    gen_row: for i in 1 to (N/2)-1 generate
        gen_col: for j in 1 to (N/2)-2 generate
            full_adder: entity work.full_adder port map(
                A => sum(i - 1)(j + 1),
                B => carry_bits(i)(j - 1),
                Cin => partial_product(i)(j),
                Sum => sum(i)(j),
                Cout => carry_bits(i)(j)
            );
        end generate;
    end generate;

    Y <= construct_output_vector(carry_bits, sum, N);
end structural;


