


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.aes_sbox_pkg.all;

package key_expansion_utils_pkg is
    function RotWord(word : std_logic_vector(31 downto 0)) return std_logic_vector;
    function SubWord(word : std_logic_vector(31 downto 0)) return std_logic_vector;
end package;

package body key_expansion_utils_pkg is
    function RotWord(word : std_logic_vector(31 downto 0)) return std_logic_vector is
        variable w : std_logic_vector(31 downto 0);
    begin
        w := word(23 downto 0) & word(31 downto 24);
        return w;
    end;

    function SubWord(word : std_logic_vector(31 downto 0)) return std_logic_vector is
        variable w : std_logic_vector(31 downto 0);
    begin
        for i in 0 to 3 loop
            w(8*(3-i)+7 downto 8*(3-i)) := SBOX(to_integer(unsigned(word(8*(3-i)+7 downto 8*(3-i)))));
        end loop;
        return w;
    end;
end package body;
