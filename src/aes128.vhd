
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Utilities.all;

entity aes128 is
	port(
		clock: in std_logic;
		reset: in std_logic;
		start: in std_logic;
		mode: in std_logic; --0 for encryption and 1 for decryption
		Data_in: in std_logic_vector(127 downto 0);
		key: in std_logic_vector(127 downto 0);
		Data_out: out std_logic_vector(127 downto 0);
		ready: out std_logic
	);
end aes128;

architecture Behavioral of aes128 is
	component encryptionCore is
		port(
			clock: in std_logic;
			reset: in std_logic;
			Data_in: in MATRIX;
			key: in std_logic_vector(127 downto 0);
			Data_out: out MATRIX;
			ready: out std_logic
		);
	end component;
	component decryptionCore
		port(
			clock: in std_logic;
			reset: in std_logic;
			Data_in: in MATRIX;
			key: in std_logic_vector(127 downto 0);
			Data_out: out MATRIX;
			ready: out std_logic
		);
	end component;

	signal input_matrix,dec_output_matrix,enc_output_matrix: MATRIX;
	signal enc_ready_signal,dec_ready_signal: std_logic;
begin
	input_matrix <= plaintext_to_matrix(Data_in);

	encryptioning: encryptionCore port map(clock,reset,input_matrix,key,enc_output_matrix,enc_ready_signal);
	decryptioning: decryptionCore port map(clock,reset,input_matrix,key,dec_output_matrix,dec_ready_signal);

	process(clock, reset)
    begin
        if reset = '1' then
            Data_out <= (others => '0');
            ready    <= '0';
        elsif rising_edge(clock) then
            if start = '1' then
                if mode = '0' then   -- encryption
                    Data_out <= matrix_to_plaintext(enc_output_matrix);
					ready <= enc_ready_signal; 
                elsif mode = '1' then -- decryption
					Data_out <= matrix_to_plaintext(dec_output_matrix);
					ready <= dec_ready_signal;  
                end if;
            else
                ready <= '0';
            end if;
        end if;
    end process;
end Behavioral;

