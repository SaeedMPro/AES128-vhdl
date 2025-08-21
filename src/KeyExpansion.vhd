library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Utilities.all;

entity KeyExpansion is
    port(
        key_in     : in  std_logic_vector(127 downto 0);
        round_keys : out std_logic_vector(1407 downto 0)
    );
end KeyExpansion;

architecture Behavioral of KeyExpansion is
    type word_array is array (0 to 43) of std_logic_vector(31 downto 0);
    signal W : word_array;
begin
    process(key_in)
        variable W_var : word_array;
    begin
	 
        W_var(0) := key_in(127 downto 96);
        W_var(1) := key_in(95 downto 64);
        W_var(2) := key_in(63 downto 32);
        W_var(3) := key_in(31 downto 0);

        for i in 4 to 43 loop
            if (i mod 4 = 0) then
                W_var(i) := std_logic_vector(unsigned(W_var(i-4)) xor unsigned(SubWord(RotWord(W_var(i-1)))) xor unsigned(RCON((i/4)-1)));
            else
                W_var(i) := std_logic_vector(unsigned(W_var(i-4)) xor unsigned(W_var(i-1)));
            end if;
        end loop;

        for i in 0 to 43 loop
            W(i) <= W_var(i);
        end loop;

        round_keys <= W_var(0) & W_var(1) & W_var(2) & W_var(3)
                    & W_var(4) & W_var(5) & W_var(6) & W_var(7)
                    & W_var(8) & W_var(9) & W_var(10) & W_var(11)
                    & W_var(12) & W_var(13) & W_var(14) & W_var(15)
                    & W_var(16) & W_var(17) & W_var(18) & W_var(19)
                    & W_var(20) & W_var(21) & W_var(22) & W_var(23)
                    & W_var(24) & W_var(25) & W_var(26) & W_var(27)
                    & W_var(28) & W_var(29) & W_var(30) & W_var(31)
                    & W_var(32) & W_var(33) & W_var(34) & W_var(35)
                    & W_var(36) & W_var(37) & W_var(38) & W_var(39)
                    & W_var(40) & W_var(41) & W_var(42) & W_var(43);
    end process;
end Behavioral;
