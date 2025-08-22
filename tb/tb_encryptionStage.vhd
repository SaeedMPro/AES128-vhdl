library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Utilities.all;

entity tb_encryptionStage is
end tb_encryptionStage;

architecture behavior of tb_encryptionStage is 
    component encryptionStage
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
    uut: encryptionStage port map(
		state_in => state_in,
		key => key,
		state_out =>state_out
    );
            
	state_in <= (
		(x"58", x"15", x"59", x"cd"),
		(x"47", x"b6", x"d4", x"39"),
		(x"08", x"1c", x"e2", x"df"),
		(x"8b", x"ba", x"e8", x"ce")
	);  

	key <= (
		(x"56", x"c7", x"76", x"a0"),
		(x"08", x"1a", x"43", x"3a"),
		(x"20", x"b1", x"55", x"f7"),
		(x"07", x"8f", x"69", x"fa")
	);

end;

-- output
-- 43 0E 09 3D
-- C6 57 08 F8
-- A9 C0 EB 7F
-- 62 C8 FE 37
