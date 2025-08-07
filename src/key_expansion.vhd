library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity key_expansion is
    Port (
            clk        : in  std_logic;
            key_in     : in  std_logic_vector(127 downto 0);
            round_keys : out std_logic_vector(1407 downto 0); -- 11 x 128 bits
            done       : out std_logic
        );
end key_expansion;

architecture Behavioral of key_expansion is
begin

end Behavioral;
