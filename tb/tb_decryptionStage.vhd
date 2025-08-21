  library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.Utilities.all;
  
  entity tb_decryptionStage is
  end tb_decryptionStage;

  architecture behavior of tb_decryptionStage is 

          component decryptionStage
          port(
					state_in: in MATRIX;
					key : in MATRIX;
					state_out: out MATRIX
          );
          end component;

          signal state_in :  MATRIX;
          signal key :  MATRIX;
          signal state_out :  MATRIX;

  begin
          uut: decryptionStage port map(
                  state_in => state_in,
						key => key,
						state_out =>state_out
          );
			
			state_in <= (
					 (x"01", x"3a", x"8c", x"21"),
					 (x"3e", x"b0", x"e2", x"33"),
					 (x"8e", x"04", x"3d", x"b8"),
					 (x"a7", x"bc", x"4d", x"1c")
				);
			key <= (
					 (x"bf", x"45", x"a1", x"f7"),
					 (x"e2", x"59", x"64", x"f1"),
					 (x"bf", x"fa", x"80", x"cb"),
					 (x"90", x"b2", x"b4", x"d8")
				);

  end;
-- output
--33 51 79 0A 
--8B 66 8F 3F 
--76 7D EB BE 
--20 92 C2 67
