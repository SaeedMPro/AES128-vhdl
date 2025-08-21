library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Utilities.all;

entity subbytes is
    port(
        state_in  : in  MATRIX;
        state_out : out MATRIX
    );
end entity;

architecture rtl of subbytes is
	
begin
    process(state_in)
		  variable temp_state : MATRIX;
    begin
			for i in 0 to 3 loop
				for j in 0 to 3 loop
					temp_state(i,j) := SBOX(to_integer(unsigned(state_in(i,j))));
				end loop;
			end loop;
			state_out <= temp_state;
    end process;
end architecture;
