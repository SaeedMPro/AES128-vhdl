
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Utilities.all;

entity tb_encryptionCore is
end tb_encryptionCore;

architecture behavior of tb_encryptionCore is 
	component encryptionCore
	port(
		clock: in std_logic;
		reset: in std_logic;
		Data_in: in MATRIX;
		key: in std_logic_vector(127 downto 0);
		Data_out: out MATRIX;
		ready: out std_logic
	);
	end component;

	signal clock: std_logic;
	signal reset: std_logic;
	signal Data_in: MATRIX;
	signal key: std_logic_vector(127 downto 0);
	signal Data_out: MATRIX;
	signal ready: std_logic;
	constant clock_period : time := 10 ns;
begin
	uut: encryptionCore port map(
		clock => clock,
		reset => reset,
		Data_in => Data_in,
		key => key,
		Data_out => Data_out,
		ready => ready
	);

	clock_process :process
	begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
	end process;

	Data_in <= (
		(x"54", x"4f", x"4e", x"20"),
		(x"77", x"6e", x"69", x"54"),
		(x"6f", x"65", x"6e", x"77"),
		(x"20", x"20", x"65", x"6f")
	), (
		(x"32", x"88", x"31", x"e0"),
		(x"43", x"5a", x"31", x"37"),
		(x"f6", x"30", x"98", x"07"),
		(x"a8", x"8d", x"a2", x"34")
	) after 10 ns ,	(
		(x"6b", x"2e", x"e9", x"73"),
		(x"c1", x"40", x"3d", x"93"),
		(x"be", x"9f", x"7e", x"17"),
		(x"e2", x"96", x"11", x"2a") ) after 20 ns
	,(
		(x"54", x"4f", x"4e", x"20"),
		(x"77", x"6e", x"69", x"54"),
		(x"6f", x"65", x"6e", x"77"),
		(x"20", x"20", x"65", x"6f")
	) after 30 ns, (
		(x"32", x"88", x"31", x"e0"),
		(x"43", x"5a", x"31", x"37"),
		(x"f6", x"30", x"98", x"07"),
		(x"a8", x"8d", x"a2", x"34")
	) after 40 ns, (
		(x"6b", x"2e", x"e9", x"73"),
		(x"c1", x"40", x"3d", x"93"),
		(x"be", x"9f", x"7e", x"17"),
		(x"e2", x"96", x"11", x"2a") ) after 50 ns
	,(
		(x"54", x"4f", x"4e", x"20"),
		(x"77", x"6e", x"69", x"54"),
		(x"6f", x"65", x"6e", x"77"),
		(x"20", x"20", x"65", x"6f")
	) after 60 ns, (
		(x"32", x"88", x"31", x"e0"),
		(x"43", x"5a", x"31", x"37"),
		(x"f6", x"30", x"98", x"07"),
		(x"a8", x"8d", x"a2", x"34")
	) after 70 ns, ( 
		(x"6b", x"2e", x"e9", x"73"),
		(x"c1", x"40", x"3d", x"93"),
		(x"be", x"9f", x"7e", x"17"),
		(x"e2", x"96", x"11", x"2a") ) after 80 ns,
	(
		(x"54", x"4f", x"4e", x"20"),
		(x"77", x"6e", x"69", x"54"),
		(x"6f", x"65", x"6e", x"77"),
		(x"20", x"20", x"65", x"6f")
	) after 90 ns; 

	key <= x"5468617473206D79204B756E67204675" , x"2b7e151628aed2a6abf7158809cf4f3c" after 10 ns , x"2B7E151628AED2A6ABF7158809CF4F3C" after 20 ns,
		x"5468617473206D79204B756E67204675" after 30 ns, x"2b7e151628aed2a6abf7158809cf4f3c" after 40 ns , x"2B7E151628AED2A6ABF7158809CF4F3C" after 50 ns,
		x"5468617473206D79204B756E67204675" after 60 ns, x"2b7e151628aed2a6abf7158809cf4f3c" after 70 ns , x"2B7E151628AED2A6ABF7158809CF4F3C" after 80 ns,
		x"5468617473206D79204B756E67204675" after 90 ns;
	reset <= '0','1' after 210 ns;
end;
