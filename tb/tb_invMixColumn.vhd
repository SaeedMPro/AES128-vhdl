  library ieee;
  use ieee.std_logic_1164.aLL;
  use ieee.numeric_std.aLL;
  use work.Utilities.all;

  entity tb_invMixColumn is
  end tb_invMixColumn;

  architecture behavior of tb_invMixColumn is

         component invMixColumn is
				port(
					state_matrix: in MATRIX;
					output_matrix: out MATRIX
				);
			end component;

          signal state_matrix:  MATRIX;
          signal output_matrix :  MATRIX;
          

  begin

          uut: invMixColumn port map(
                  state_matrix => state_matrix,
                  output_matrix => output_matrix
          );
			state_matrix <=(
					 (x"4d", x"ec", x"76", x"49"),
					 (x"25", x"f7", x"58", x"bc"),
					 (x"cb", x"16", x"c7", x"c9"),
					 (x"1e", x"46", x"3b", x"e9")
				);   
	end;
	
--	output
--	912C7676 3AF956DE C0F2CE2E A93E98DA
