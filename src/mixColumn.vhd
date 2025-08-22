library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Utilities.all;

entity mixColumn is
	port(
		state_matrix: in MATRIX;
		output_matrix: out MATRIX
	);
end mixColumn;

architecture Behavioral of mixColumn is
		
begin
	process(state_matrix)
		variable shifted: BYTE;
		variable temp: BYTE;
	begin
		for i in 0 to 3 loop
			for j in 0 to 3 loop
				temp := x"00";
				for k in 0 to 3 loop
					temp := temp xor mul_GF(state_matrix(k,j),mixColumn_matrix(i,k));
				end loop;
				output_matrix(i,j) <= temp;
			end loop;
		end loop;
	end process;
end Behavioral;

