library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.aes_sbox_pkg.all;

entity subbytes is
    port(
        state_in  : in  std_logic_vector(127 downto 0);
        state_out : out std_logic_vector(127 downto 0)
    );
end entity;

architecture rtl of subbytes is
begin
    process(state_in)
        variable temp_state : std_logic_vector(127 downto 0);
        variable byte_val   : std_logic_vector(7 downto 0);
    begin
        for i in 0 to 15 loop
            byte_val := state_in(8*i+7 downto 8*i);
            temp_state(8*i+7 downto 8*i) := SBOX(to_integer(unsigned(byte_val)));
        end loop;
        state_out <= temp_state;
    end process;
end architecture;
