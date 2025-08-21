
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Utilities.all;


entity encryptionCore is
	port(
		clock: in std_logic;
		reset: in std_logic;
		Data_in: in MATRIX;
		key: in std_logic_vector(127 downto 0);
		Data_out: out MATRIX;
		ready: out std_logic
	);
end encryptionCore;

architecture Behavioral of encryptionCore is
	component subbytes is
		port(
		  state_in  : in  MATRIX;
        state_out : out MATRIX
		);
	end component;
	
	component shiftrows is
		port(
		  state_in  : in  MATRIX;
        state_out : out MATRIX
		);
	end component;
	
	component addRoundKey is
		port(
		  state_matrix: in MATRIX;
		  key : in MATRIX;
		  output_matrix: out MATRIX
		);
	end component;
	component encryptionStage is
		port(
			state_in: in MATRIX;
			key : in MATRIX;
			state_out: out MATRIX
		);
	end component;
	component KeyExpansion is
    port(
        key_in     : in  std_logic_vector(127 downto 0);
        round_keys : out std_logic_vector(1407 downto 0)
    );
	end component;
	component pipelineRegister is
	 port(
	   clock: in std_logic;
		reset: in std_logic;
		Data_in: in pipelineData;
		Data_out: out pipelineData
	 );
	 end component;
	 
	 
	signal temp_out : stateOut;
	signal pipeline_din: pipelineDataArray;
	signal pipeline_dout: pipelineDataArray;
	signal r_key: std_logic_vector(1407 downto 0);
	signal r_key_matrix : roundKeyMatrix;
	
	
begin
		roundKeyGen:KeyExpansion port map(key,r_key);
	--round 0
	
		r_key_matrix(0)<= plaintext_to_matrix(r_key(1407 downto 1280));
		init:addRoundKey port map(Data_in,r_key_matrix(0),temp_out(0));
		pipeline_din(0).state <= temp_out(0);
		pipeline_din(0).key <= r_key;
		pipeline_din(0).valid <= '1';
		stage0Register:pipelineRegister port map(clock,reset,pipeline_din(0),pipeline_dout(0));
		
		
	--round 1-9
	
	
		gen: for i in 1 to 9 generate
				r_key_matrix(i)<= plaintext_to_matrix(pipeline_dout(i-1).key(1407-(i*128) downto 1408-((i+1)*128)));
				stage:encryptionStage port map(pipeline_dout(i-1).state,r_key_matrix(i),temp_out(i));
				pipeline_din(i).state <= temp_out(i);
				pipeline_din(i).key <= pipeline_dout(i-1).key;
				pipeline_din(i).valid <= pipeline_dout(i-1).valid;
				stages1to9Register:pipelineRegister port map(clock,reset,pipeline_din(i),pipeline_dout(i));
		end generate gen;
		
		
--	--round 10

		r_key_matrix(10) <= plaintext_to_matrix(pipeline_dout(9).key(1407-(10*128) downto 1408-((10+1)*128)));
		last_sb:subbytes port map (pipeline_dout(9).state,temp_out(10));
		last_sr:shiftrows port map (temp_out(10),temp_out(11));
		last_addrk:addRoundKey port map (temp_out(11),r_key_matrix(10),pipeline_din(10).state);
		pipeline_din(10).key <= pipeline_dout(9).key;
		pipeline_din(10).valid <= pipeline_dout(9).valid;
		stage10Register:pipelineRegister port map(clock,reset,pipeline_din(10),pipeline_dout(10));
		ready <= pipeline_dout(10).valid;
		Data_out <= pipeline_dout(10).state;
		
end Behavioral;

