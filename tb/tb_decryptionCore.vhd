
  library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.Utilities.all;
  
  entity tb_decryptionCore is
  end tb_decryptionCore;

  architecture behavior of tb_decryptionCore is 

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

          signal clock: std_logic;
			 signal reset: std_logic;
			 signal Data_in: MATRIX;
			 signal key: std_logic_vector(127 downto 0);
			 signal Data_out: MATRIX;
			 signal ready: std_logic;
          constant clock_period : time := 10 ns;

  begin

          uut: decryptionCore port map(
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
					 (x"29", x"57", x"40", x"1a"),
					 (x"c3", x"14", x"22", x"02"),
					 (x"50", x"20", x"99", x"d7"),
					 (x"5f", x"f6", x"b3", x"3a")
				)
				,(
					 (x"39", x"02", x"DC", x"19"),
					 (x"25", x"DC", x"11", x"6A"),
					 (x"84", x"09", x"85", x"0B"),
					 (x"1D", x"FB", x"97", x"32")
				) after 10 ns ;
			key <= x"5468617473206D79204B756E67204675", 
			x"2b7e151628aed2a6abf7158809cf4f3c" after 10 ns ;
			reset <= '0';
  end;
