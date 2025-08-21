
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Utilities.all;

entity invMixColumn is
    port(
        state_matrix : in MATRIX;
        output_matrix : out MATRIX
    );
end invMixColumn;

architecture Behavioral of invMixColumn is

begin
    process(state_matrix)
        variable temp : BYTE;
    begin
	     
        for col in 0 to 3 loop
            for row in 0 to 3 loop
                temp := (others => '0');
                for k in 0 to 3 loop
                    temp := temp xor mul_GF(state_matrix(k, col), inv_mixColumn_matrix(row, k));
                end loop; 
                output_matrix(row, col) <= temp;
            end loop;
        end loop;
    end process;
	 
end Behavioral;


