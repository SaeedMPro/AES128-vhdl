----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:21:43 08/21/2025 
-- Design Name: 
-- Module Name:    decryptionCore - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decryptionCore is
end decryptionCore;

architecture Behavioral of decryptionCore is

begin


end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Utilities.all;


entity decryptionCore is
	port(
		clock: in std_logic;
		reset: in std_logic;
		Data_in: in MATRIX;
		key: in std_logic_vector(127 downto 0);
		Data_out: out MATRIX;
		ready: out std_logic
	);
end decryptionCore;

architecture Behavioral of decryptionCore is
	component invSubBytes is
    port(
        state_in  : in  MATRIX;
        state_out : out MATRIX
    );
	end component;
	component invShiftRows is
    port (
        state_in  : in  MATRIX;
        state_out : out MATRIX
    );
	end component;
	component invMixColumn is
    port(
        state_matrix : in MATRIX;
        output_matrix : out MATRIX
    );
	end component;
	component addRoundKey is
		port(
		state_matrix: in MATRIX;
		key : in MATRIX;
		output_matrix: out MATRIX
	);
	end component;
	component decryptionStage is
		port(
			state_in: in MATRIX;
			key : in MATRIX;
			state_out: out MATRIX
		);
	end component;
	component key_expansion is
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
		roundKeyGen:key_expansion port map(key,r_key);
	--round 0
	
		r_key_matrix(0)<= plaintext_to_matrix(r_key(127 downto 0));
		init:addRoundKey port map(Data_in,r_key_matrix(0),temp_out(0));
		pipeline_din(0).state <= temp_out(0);
		pipeline_din(0).key <= r_key;
		pipeline_din(0).valid <= '1';
		stage0Register:pipelineRegister port map(clock,reset,pipeline_din(0),pipeline_dout(0));
		
		
	--round 1-9
	
	
		gen: for i in 1 to 9 generate
				r_key_matrix(i)<= plaintext_to_matrix(pipeline_dout(i-1).key(127+(i*128) downto ((i)*128)));
				stage:decryptionStage port map(pipeline_dout(i-1).state,r_key_matrix(i),temp_out(i));
				pipeline_din(i).state <= temp_out(i);
				pipeline_din(i).key <= pipeline_dout(i-1).key;
				pipeline_din(i).valid <= pipeline_dout(i-1).valid;
				stages1to9Register:pipelineRegister port map(clock,reset,pipeline_din(i),pipeline_dout(i));
		end generate gen;
		
		
--	--round 10

		r_key_matrix(10) <= plaintext_to_matrix(pipeline_dout(9).key(1407 downto 1280));
		last_inv_sr:invShiftRows port map(pipeline_dout(9).state,temp_out(10));
		last_inv_sb:invSubBytes port map(temp_out(10),temp_out(11));
		last_addrk:addRoundKey port map (temp_out(11),r_key_matrix(10),pipeline_din(10).state);
		pipeline_din(10).key <= pipeline_dout(9).key;
		pipeline_din(10).valid <= pipeline_dout(9).valid;
		stage10Register:pipelineRegister port map(clock,reset,pipeline_din(10),pipeline_dout(10));
		ready <= pipeline_dout(10).valid;
		Data_out <= pipeline_dout(10).state;

		
end Behavioral;

