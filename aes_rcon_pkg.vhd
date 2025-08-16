

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package aes_rcon_pkg is
    type rcon_array is array(0 to 10) of std_logic_vector(31 downto 0);
    constant RCON : rcon_array := (
        x"01000000", x"02000000", x"04000000", x"08000000", x"10000000",
        x"20000000", x"40000000", x"80000000", x"1B000000", x"36000000", x"00000000"
    );
end package aes_rcon_pkg;
