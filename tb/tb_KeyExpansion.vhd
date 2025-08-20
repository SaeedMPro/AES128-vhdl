library ieee;
use ieee.std_logic_1164.all;

entity tb_key_expansion is
end entity;

architecture sim of tb_key_expansion is
    signal key_in     : std_logic_vector(127 downto 0);
    signal round_keys : std_logic_vector(1407 downto 0);

    component key_expansion
        port(
            key_in       : in  std_logic_vector(127 downto 0);
            round_keys   : out std_logic_vector(1407 downto 0)
        );
    end component;
begin
    uut: key_expansion port map (
        key_in => key_in,
        round_keys => round_keys
    );

    process
    begin
        --key_in <= x"2b7e151628aed2a6abf7158809cf4f3c";
		  key_in <= x"5468617473206D79204B756E67204675";
        wait for 100 ns;
        wait;
    end process;
end architecture;
