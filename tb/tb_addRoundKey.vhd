  library ieee;
  use ieee.std_logic_1164.aLL;
  use ieee.numeric_std.aLL;
  use work.Utilities.all;

  entity testbench is
  end testbench;

  architecture behavior of testbench is

         component addRoundKey is
				port(
					state_matrix: in MATRIX;
					key : in MATRIX;
					output_matrix: buffer MATRIX
				);
			end component;

          signal state_matrix:  MATRIX;
          signal key :  MATRIX;
          signal output_matrix :  MATRIX;

  begin

          uut: addRoundKey port map(
                  state_matrix => state_matrix,
						key => key,
                  output_matrix => output_matrix
          );
			state_matrix <=(
					 (x"eb", x"59", x"8b", x"1b"),
					 (x"40", x"2e", x"a1", x"c3"),
					 (x"f2", x"38", x"13", x"42"),
					 (x"1e", x"84", x"e7", x"d6")
				);  
			key <=(
					 (x"ac", x"19", x"28", x"57"),
					 (x"77", x"fa", x"d1", x"5c"),
					 (x"66", x"dc", x"29", x"00"),
					 (x"f3", x"21", x"41", x"6a")
				);  
	end;
	
