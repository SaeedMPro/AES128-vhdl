
library ieee;
use ieee.std_logic_1164.all;

entity tb_aes128 is
end tb_aes128;

architecture behavior of tb_aes128 is 

	component aes128
	port(
		clock : in  std_logic;
		reset : in  std_logic;
		start : in  std_logic;
		mode : in  std_logic;
		Data_in : in  std_logic_vector(127 downto 0);
		key : in  std_logic_vector(127 downto 0);
		Data_out : out  std_logic_vector(127 downto 0);
		ready : out  std_logic
		);
	end component;
	

signal clock : std_logic := '0';
signal reset : std_logic := '0';
signal start : std_logic := '0';
signal mode : std_logic := '0';
signal Data_in : std_logic_vector(127 downto 0) := (others => '0');
signal key : std_logic_vector(127 downto 0) := (others => '0');

signal Data_out : std_logic_vector(127 downto 0) := (others => 'X');
signal ready : std_logic := '0';

constant clock_period : time := 10 ns;

begin

	uut: aes128 port map (
		clock => clock,
		reset => reset,
		start => start,
		mode => mode,
		Data_in => Data_in,
		key => key,
		Data_out => Data_out,
		ready => ready
	);
		
	clock_process: process
	begin
			clock <= '0';
			wait for clock_period/2;
			clock <= '1';
			wait for clock_period/2;
	end process;

	start <= '1';
	mode <= '0','1' after 230 ns;

	-- encryption input test
	Data_in <= x"3243f6a8885a308d313198a2e0370734",
	x"54776F204F6E65204E696E652054776F" after 10 ns,
	x"6BC1BEE22E409F96E93D7E117393172A" after 20 ns,
	x"AE2D8A571E03AC9C9EB76FAC45AF8E51" after 30 ns,
	x"30C81C46A35CE411E5FBC1191A0A52EF" after 40 ns,
	x"F69F2445DF4F9B17AD2B417BE66C3710" after 50 ns,
	x"6BC1BEE22E409F96E93D7E117393172A" after 60 ns,
	x"AE2D8A571E03AC9C9EB76FAC45AF8E51" after 70 ns,
	x"30C81C46A35CE411E5FBC1191A0A52EF" after 80 ns,
	x"00112233445566778899aabbccddeeff" after 90 ns,
	x"00000000000000000000000000000000" after 100 ns,
	x"ffffffffffffffffffffffffffffffff" after 110 ns,

	-- decryption input test
	x"3925841d02dc09fbdc118597196a0b32" after 240 ns,
	x"29C3505F571420F6402299B31A02D73A" after 250 ns,
	x"3AD77BB40D7A3660A89ECAF32466EF97" after 260 ns,
	x"F5D3D58503B9699DE785895A96FDBAAF" after 270 ns,
	x"43B1CD7F598ECE23881B00E3ED030688" after 280 ns,
	x"7B0C785E27E8AD3F8223207104725DD4" after 290 ns,
	x"3AD77BB40D7A3660A89ECAF32466EF97" after 300 ns,
	x"F5D3D58503B9699DE785895A96FDBAAF" after 310 ns,
	x"43B1CD7F598ECE23881B00E3ED030688" after 320 ns,
	x"69C4E0D86A7B0430D8CDB78070B4C55A" after 330 ns,
	x"6D251E6944B051E04EAA6FB4DBF78465" after 340 ns,
	x"bcbf217cb280cf30b2517052193ab979" after 350 ns; 


	-- encryption input test
	key <= x"2b7e151628aed2a6abf7158809cf4f3c",
	x"5468617473206D79204B756E67204675" after 10 ns,
	x"2B7E151628AED2A6ABF7158809CF4F3C" after 20 ns,
	x"000102030405060708090a0b0c0d0e0f" after 90 ns,
	x"10a58869d74be5a374cf867cfb473859" after 100 ns,
	x"ffffffffffffffffffffffffffffffff" after 110 ns,

	-- decryption input test
	x"2b7e151628aed2a6abf7158809cf4f3c" after 240 ns,
	x"5468617473206D79204B756E67204675" after 250 ns,
	x"2B7E151628AED2A6ABF7158809CF4F3C" after 260 ns,
	x"000102030405060708090a0b0c0d0e0f" after 330 ns,
	x"10a58869d74be5a374cf867cfb473859" after 340 ns,
	x"ffffffffffffffffffffffffffffffff" after 350 ns;

	reset <= '1' after 230 ns , '0' after 240 ns,'1' after 475 ns; 
END;
