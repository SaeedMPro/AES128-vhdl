library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Utilities.all;

entity mixColumn is
	port(
		state_matrix: in MATRIX;
		output_matrix: buffer MATRIX
	);
end mixColumn;

architecture Behavioral of mixColumn is
	constant mixColumn_matrix : MATRIX :=(
    (x"02", x"03", x"01", x"01"),
    (x"01", x"02", x"03", x"01"),
    (x"01", x"01", x"02", x"03"),
    (x"03", x"01", x"01", x"02")
);
		
begin
		process(state_matrix)
			variable shifted: WORD_8BIT;
			variable temp: WORD_8BIT;
		begin
			for i in 0 to 3 loop
				for j in 0 to 3 loop
					temp := x"00";
					for k in 0 to 3 loop
						shifted := state_matrix(k,j)(6 downto 0)&'0';
						if mixColumn_matrix(i,k) = x"01" then
							temp := temp xor state_matrix(k,j);
						elsif mixColumn_matrix(i,k) = x"02" then
							if state_matrix(k,j)(7) = '1' then
								temp := temp xor (x"1b" xor shifted);
							else
								temp := temp xor shifted;
							end if;
						else
							if state_matrix(k,j)(7) = '1' then
								temp := temp xor ((x"1b" xor shifted) xor state_matrix(k,j));
							else
								temp := temp xor (shifted xor state_matrix(k,j));
							end if;
						end if;
					end loop;
					output_matrix(i,j) <= temp;
				end loop;
			end loop;
		end process;
end Behavioral;

