library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Utilities.all;

entity addRoundKey is
		port(
		state_matrix: in MATRIX;
		key : in MATRIX;
		output_matrix: buffer MATRIX
	);
end addRoundKey;

architecture Behavioral of addRoundKey is

begin
	process(state_matrix)
	begin
		for i in 0 to 3 loop 
			for j in 0 to 3 loop
				output_matrix(i,j) <= state_matrix(i,j) xor key(i,j);
			end loop;
		end loop;
	end process;

end Behavioral;

