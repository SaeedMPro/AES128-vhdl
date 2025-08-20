
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Utilities.all;

entity pipelineRegister is
	port(
		clock: in std_logic;
		reset: in std_logic;
		Data_in: in pipelineData;
		Data_out: out pipelineData
	);
end pipelineRegister;

architecture Behavioral of pipelineRegister is

begin
	process(clock, reset)
        begin
            if reset = '1' then
					 Data_out.state <= (others => (others => x"00"));
					 Data_out.key <= (others => '0');
					 Data_out.valid <= '0';
            elsif rising_edge(clock) then
                Data_out <= Data_in;
            end if;
        end process;
end Behavioral;

