library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity aes_tb is
end aes_tb;

architecture tb of aes_tb is
    component aes_top
        port (
            clk      : in  std_logic;
            reset    : in  std_logic;
            start    : in  std_logic;
            mode     : in  std_logic;  -- 0: encrypt, 1: decrypt
            key      : in  std_logic_vector(127 downto 0);
            data_in  : in  std_logic_vector(127 downto 0);
            data_out : out std_logic_vector(127 downto 0);
            ready    : out std_logic
        );
    end component;

    signal clk      : std_logic := '0';
    signal reset    : std_logic := '1';
    signal start    : std_logic := '0';
    signal mode     : std_logic := '0'; -- encrypt
    signal key      : std_logic_vector(127 downto 0);
    signal data_in  : std_logic_vector(127 downto 0);
    signal data_out : std_logic_vector(127 downto 0);
    signal ready    : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    uut: aes_top
        port map (
            clk      => clk,
            reset    => reset,
            start    => start,
            mode     => mode,
            key      => key,
            data_in  => data_in,
            data_out => data_out,
            ready    => ready
        );


    stimulus: process
    begin
        wait for 20 ns;
        reset <= '0';

        key     <= x"2b7e151628aed2a6abf7158809cf4f3c";
        data_in <= x"3243f6a8885a308d313198a2e0370734";
        mode    <= '0'; -- encryption

        wait for 20 ns;
        start <= '1';
        wait for CLK_PERIOD;
        start <= '0';

        wait until ready = '1';

        report "Encrypted Output: " & to_hstring(data_out);

        -- Compare with expected result
        if data_out = x"3925841d02dc09fbdc118597196a0b32" then
            report "Test passed!" severity note;
        else
            report "Test failed! Output does not match expected ciphertext." severity error;
        end if;

        wait;
    end process;

end tb;
