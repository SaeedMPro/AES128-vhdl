
library ieee;
use ieee.std_logic_1164.all;
use work.Utilities.all;
 
entity tb_pipelineRegister is
end tb_pipelineRegister;
 
architecture behavior of tb_pipelineRegister is 
 
    component pipelineRegister
    port(
         clock : in  std_logic;
         reset : in  std_logic;
         Data_in : in  pipelineData;
         Data_out : out  pipelineData
        );
    end component;
    

   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal Data_in : pipelineData;
   signal Data_out : pipelineData;

   constant clock_period : time := 10 ns;
 
begin
 
   uut: pipelineRegister port map (
          clock => clock,
          reset => reset,
          Data_in => Data_in,
          Data_out => Data_out
        );

   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
	
	reset <= '1' after 10 ns, '0' after 20 ns;
	Data_in.state <= (
					 (x"58", x"15", x"59", x"cd"),
					 (x"47", x"b6", x"d4", x"39"),
					 (x"08", x"1c", x"e2", x"df"),
					 (x"8b", x"ba", x"e8", x"ce")
				) after 20 ns; 
	Data_in.key <= X"1A3FE2B47C89D05A23F19B8C4567D2E9" & 
        X"0F3A8B1C7D4E9A2B5C6D8F0E1A2B3C4D" & 
        X"5E6F708192A3B4C5D6E7F8091A2B3C4D" & 
        X"5E6F708192A3B4C5D6E7F8091A2B3C4D" & 
        X"5E6F708192A3B4C5D6E7F8091A2B3C4D" & 
        X"5E6F708192A3B4C5D6E7F8091A2B3C4D" & 
        X"5E6F708192A3B4C5D6E7F8091A2B3C4D" & 
        X"5E6F708192A3B4C5D6E7F8091A2B3C4D" & 
        X"5E6F708192A3B4C5D6E7F8091A2B3C4D" & 
        X"5E6F708192A3B4C5D6E7F8091A2B3C4D" & 
        X"5E6F708192A3B4C5D6E7F8091A2B3C4D"  after 20 ns;
 end;
