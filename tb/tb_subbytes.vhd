library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Utilities.all;

entity tb_subbytes is
end tb_subbytes;

architecture sim of tb_subbytes is

    component subbytes is
        port(
            state_in  : in  MATRIX;
            state_out : out MATRIX
        );
    end component;

    signal state_in  : MATRIX;
    signal state_out : MATRIX;

    constant expected_out : std_logic_vector(127 downto 0) :=
        x"d4e0b81e27bfb44111985d52aef1e530";
begin
    uut: subbytes
        port map(
            state_in  => state_in,
            state_out => state_out
        );

    process
    begin
        state_in <=(
    (x"19", x"3d", x"e3", x"be"),
    (x"a0", x"f4", x"e2", x"2b"),
    (x"9a", x"c6", x"8d", x"2a"),
    (x"e9", x"f8", x"48", x"08")
	);
        wait;
    end process;

end architecture;
