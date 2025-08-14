library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Utilities.all;

entity plaintext_to_matrix is
	generic(
		constant n: integer := 128
	);
	port(
		input_text: in std_logic_vector(n-1 downto 0);
		output_matrix : out MATRIX 
	);
end plaintext_to_matrix; 

architecture Behavioral of plaintext_to_matrix is
begin
	process(input_text)
	begin
		for j in 3 downto 0 loop 
			for i in 3 downto 0 loop
				output_matrix(i,j) <= input_text((n-1)-(j*32 + i*8) downto ((n-1)-(j*32 + i*8))-7);
			end loop;
		end loop;
	end process;
end Behavioral;

