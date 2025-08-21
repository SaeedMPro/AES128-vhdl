library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Utilities.all;

entity tb_shiftrows is
end tb_shiftrows;

architecture sim of tb_shiftrows is
    component invShiftRows is
        port(
            state_in  : in  MATRIX;
            state_out : out MATRIX
        );
    end component;

    signal state_in  : MATRIX;
    signal state_out : MATRIX;

    constant expected_out : std_logic_vector(127 downto 0) := 
	 x"BB36C7EB88334D49A4E7112E74F182C4"; 
begin
    uut: invShiftRows
        port map(
            state_in  => state_in,
            state_out => state_out
        );

        state_in <=(
    (x"bb", x"88", x"a4", x"74"),
    (x"33", x"e7", x"f1", x"36"),
    (x"11", x"82", x"c7", x"4d"),
    (x"c4", x"eb", x"49", x"2e")
	);
end architecture;

