
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Utilities.all;

entity encryptionStage is
	port(
		state_in: in MATRIX;
		key : in MATRIX;
		state_out: out MATRIX
	);
end encryptionStage;

architecture Behavioral of encryptionStage is
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
	
	component mixColumn is
		port(
		  state_matrix: in MATRIX;
		  output_matrix: out MATRIX
		);
	end component;
	
	component addRoundKey is
		port(
		  state_matrix: in MATRIX;
		  key : in MATRIX;
		  output_matrix: out MATRIX
		);
	end component;
	signal sb_out,sr_out,mc_out: MATRIX;
begin
	sb:component subbytes port map(state_in,sb_out);
	sr:component shiftrows port map(sb_out,sr_out);
	mc:component mixColumn port map(sr_out,mc_out);
	ark:component addRoundKey port map(mc_out,key,state_out);
end Behavioral;

