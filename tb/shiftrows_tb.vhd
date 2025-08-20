library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Utilities.all;


entity shiftrows_tb is
end shiftrows_tb;

architecture sim of shiftrows_tb is

    component shiftrows is
        port(
            state_in  : in  MATRIX;
            state_out : out MATRIX
        );
    end component;

    signal state_in  : MATRIX;
    signal state_out : MATRIX;

    --constant expected_out : std_logic_vector(127 downto 0) := x"d4bf5d30e0b452aeb84111f11e2798e5"; 
begin
    uut: shiftrows
        port map(
            state_in  => state_in,
            state_out => state_out
        );

    process
    begin
        state_in <=(
    (x"d4", x"e0", x"b8", x"1e"),
    (x"27", x"bf", x"b4", x"41"),
    (x"11", x"98", x"5d", x"52"),
    (x"ae", x"f1", x"e5", x"30")
	);
        wait;
    end process;
end architecture;
