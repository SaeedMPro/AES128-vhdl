library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Utilities.all;

entity decryptionStage is
	port(
		state_in: in MATRIX;
		key : in MATRIX;
		state_out: out MATRIX
	);
end decryptionStage;

architecture Behavioral of decryptionStage is
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
	signal inv_sb_out,inv_sr_out,ark_out: MATRIX;
begin
		invSr:component invShiftRows port map(state_in,inv_sr_out);
		invSb:component invSubBytes port map(inv_sr_out,inv_sb_out);
		ark:component addRoundKey port map(inv_sb_out,key,ark_out);
		invMc:component invMixColumn port map(ark_out,state_out);
end Behavioral;

