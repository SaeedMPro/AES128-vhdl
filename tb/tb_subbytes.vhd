library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Utilities.all;

entity tb_subbytes is
end tb_subbytes;

architecture sim of tb_subbytes is
    component invSubBytes is
        port(
            state_in  : in  MATRIX;
            state_out : out MATRIX
        );
    end component;

    signal state_in  : MATRIX;
    signal state_out : MATRIX;
    constant expected_out : std_logic_vector(127 downto 0) := x"BB3311C488E782EBA4F1C74974364D2E";
begin
    uut: invSubBytes
    port map(
        state_in  => state_in,
        state_out => state_out
    );
		  
    state_in <=(
        (x"ea", x"c4", x"49", x"92"),
        (x"c3", x"94", x"a1", x"05"),
        (x"82", x"13", x"c6", x"e3"),
        (x"1c", x"e9", x"3b", x"31")
	);
end architecture;
