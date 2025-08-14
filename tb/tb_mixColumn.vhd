  library ieee;
  use ieee.std_logic_1164.aLL;
  use ieee.numeric_std.aLL;
  use work.Utilities.all;

  entity testbench is
  end testbench;

  architecture behavior of testbench is

         component mixColumn is
				port(
					state_matrix: in MATRIX;
					output_matrix: buffer MATRIX
				);
			end component;

          signal state_matrix:  MATRIX;
          signal output_matrix :  MATRIX:= (
					 (x"00", x"00", x"00", x"00"),
					 (x"00", x"00", x"00", x"00"),
					 (x"00", x"00", x"00", x"00"),
					 (x"00", x"00", x"00", x"00")
					);
          

  begin

          uut: mixColumn port map(
                  state_matrix => state_matrix,
                  output_matrix => output_matrix
          );
			state_matrix <=(
					 (x"63", x"eb", x"9f", x"a0"),
					 (x"2f", x"93", x"92", x"c0"),
					 (x"af", x"c7", x"ab", x"30"),
					 (x"a2", x"20", x"cb", x"2b")
				);  
	end;
	
--	output
--	BA 84 E8 1B 
--	75 A4 8D 40 
--	F4 8D 06 7D 
--	7A 32 0E 5D
