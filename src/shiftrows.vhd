library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Utilities.all;

entity shiftrows is
    port (
        state_in  : in  MATRIX;
        state_out : out MATRIX
    );
end shiftrows;

architecture Behavioral of shiftrows is

begin
    process(state_in)
        variable shifted_matrix : MATRIX;
    begin
        for col in 0 to 3 loop
            shifted_matrix(0, col) := state_in(0, col);
            shifted_matrix(1, col) := state_in(1, (col + 1) mod 4);
            shifted_matrix(2, col) := state_in(2, (col + 2) mod 4);
            shifted_matrix(3, col) := state_in(3, (col + 3) mod 4);
        end loop;
		  state_out <= shifted_matrix;
    end process;
end Behavioral;
