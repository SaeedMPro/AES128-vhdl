library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity encryption_core is
    Port (
            clk        : in  std_logic;
            start      : in  std_logic;
            plain_text : in  std_logic_vector(127 downto 0);
            round_keys : in  std_logic_vector(1407 downto 0);
            cipher_out : out std_logic_vector(127 downto 0);
            ready      : out std_logic
        );
end encryption_core;

architecture Behavioral of encryption_core is
begin

end Behavioral;
