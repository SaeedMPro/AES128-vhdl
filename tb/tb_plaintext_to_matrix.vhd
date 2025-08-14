-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  USE work.Utilities.all;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          component plaintext_to_matrix
				port(
					input_text: in std_logic_vector(128-1 downto 0);
					output_matrix : out MATRIX 
				);
          end component;

          SIGNAL input_text :  std_logic_vector(128-1 downto 0);
          SIGNAL output_matrix:  MATRIX;
          

  BEGIN

  -- Component Instantiation
          uut: plaintext_to_matrix PORT MAP(
                  input_text => input_text,
                  output_matrix => output_matrix
          );

		input_text <= x"3243f6a8885a308d313198a2e0370734" after 100 ns 
		,x"54776F204F6E65204E696E652054776F" after 200 ns;

  END;