library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity aes_top is
    Port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        start    : in  std_logic;
        mode     : in  std_logic;  -- 0: encryption, 1: decryption
        key      : in  std_logic_vector(127 downto 0);
        data_in  : in  std_logic_vector(127 downto 0);
        data_out : out std_logic_vector(127 downto 0);
        ready    : out std_logic
    );
end aes_top;

architecture Behavioral of aes_top is
    component key_expansion
        Port (
            clk        : in  std_logic;
            key_in     : in  std_logic_vector(127 downto 0);
            round_keys : out std_logic_vector(1407 downto 0); -- 11 x 128 bits
            done       : out std_logic
        );
    end component;
    component encryption_core
        Port (
            clk        : in  std_logic;
            start      : in  std_logic;
            plain_text : in  std_logic_vector(127 downto 0);
            round_keys : in  std_logic_vector(1407 downto 0);
            cipher_out : out std_logic_vector(127 downto 0);
            ready      : out std_logic
        );
    end component;

    signal round_keys  : std_logic_vector(1407 downto 0);
    signal key_ready   : std_logic := '0';
    signal enc_ready   : std_logic := '0';
    signal cipher_out  : std_logic_vector(127 downto 0);
    signal start_reg   : std_logic := '0';

    type state_type is (IDLE, KEY_EXPAND, ENCRYPT, DONE);
    signal state : state_type := IDLE;

begin
    key_exp_inst: key_expansion
        port map (
            clk        => clk,
            key_in     => key,
            round_keys => round_keys,
            done       => key_ready
        );

    enc_inst: encryption_core
        port map (
            clk        => clk,
            start      => start_reg,
            plain_text => data_in,
            round_keys => round_keys,
            cipher_out => cipher_out,
            ready      => enc_ready
        );

    data_out <= cipher_out;
    ready    <= '1' when state = DONE else '0';

    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            start_reg <= '0';

        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if start = '1' then
                        state <= KEY_EXPAND;
                    end if;

                when KEY_EXPAND =>
                    if key_ready = '1' then
                        state <= ENCRYPT;
                        start_reg <= '1'; 
                    end if;

                when ENCRYPT =>
                    start_reg <= '0';    
                    if enc_ready = '1' then
                        state <= DONE;
                    end if;

                when DONE =>
                    null;
            end case;
        end if;
    end process;

end Behavioral;
