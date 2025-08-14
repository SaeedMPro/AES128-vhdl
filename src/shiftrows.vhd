library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shiftrows is
    port (
        state_in  : in  std_logic_vector(127 downto 0);
        state_out : out std_logic_vector(127 downto 0)
    );
end shiftrows;

architecture Behavioral of shiftrows is
    type byte_array is array (0 to 3, 0 to 3) of std_logic_vector(7 downto 0);
begin
    process(state_in)
        variable state_matrix   : byte_array;
        variable shifted_matrix : byte_array;
    begin
        -- map input vector to 4x4 state
        for col in 0 to 3 loop
            for row in 0 to 3 loop
                state_matrix(row, col) := state_in(127 - (col*32 + row*8) downto 120 - (col*32 + row*8));
            end loop;
        end loop;

        -- perform ShiftRows
        for col in 0 to 3 loop
            shifted_matrix(0, col) := state_matrix(0, col);
            shifted_matrix(1, col) := state_matrix(1, (col + 1) mod 4);
            shifted_matrix(2, col) := state_matrix(2, (col + 2) mod 4);
            shifted_matrix(3, col) := state_matrix(3, (col + 3) mod 4);
        end loop;

        for col in 0 to 3 loop
            for row in 0 to 3 loop
                state_out(127 - (col*32 + row*8) downto 120 - (col*32 + row*8)) <= shifted_matrix(row, col);
            end loop;
        end loop;
    end process;
end Behavioral;
