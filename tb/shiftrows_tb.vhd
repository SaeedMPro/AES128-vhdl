library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftrows_tb is
end shiftrows_tb;

architecture sim of shiftrows_tb is

    component shiftrows is
        port(
            state_in  : in  std_logic_vector(127 downto 0);
            state_out : out std_logic_vector(127 downto 0)
        );
    end component;

    -- helper: convert std_logic_vector to hex string
    function to_hstring(vec: std_logic_vector) return string is
        variable result: string(1 to (vec'length+3)/4);
        variable nibble: std_logic_vector(3 downto 0);
    begin
        for i in 0 to (vec'length/4)-1 loop
            nibble := vec(vec'length-1 - i*4 downto vec'length-4 - i*4);
            case nibble is
                when "0000" => result(i+1) := '0';
                when "0001" => result(i+1) := '1';
                when "0010" => result(i+1) := '2';
                when "0011" => result(i+1) := '3';
                when "0100" => result(i+1) := '4';
                when "0101" => result(i+1) := '5';
                when "0110" => result(i+1) := '6';
                when "0111" => result(i+1) := '7';
                when "1000" => result(i+1) := '8';
                when "1001" => result(i+1) := '9';
                when "1010" => result(i+1) := 'A';
                when "1011" => result(i+1) := 'B';
                when "1100" => result(i+1) := 'C';
                when "1101" => result(i+1) := 'D';
                when "1110" => result(i+1) := 'E';
                when others => result(i+1) := 'F';
            end case;
        end loop;
        return result;
    end function;

    signal state_in  : std_logic_vector(127 downto 0);
    signal state_out : std_logic_vector(127 downto 0);

    constant expected_out : std_logic_vector(127 downto 0) := x"d4bf5d30e0b452aeb84111f11e2798e5"; 
begin
    uut: shiftrows
        port map(
            state_in  => state_in,
            state_out => state_out
        );

    process
    begin
        state_in <= x"d42711aee0bf98f1b8b45de51e415230";
        wait for 10 ns;
        if state_out = expected_out then
            report "ShiftRows test PASSED" severity note;
        else
            report "ShiftRows test FAILED. Got: " &
                   to_hstring(state_out) &
                   " Expected: " & to_hstring(expected_out)
                   severity error;
        end if;
        wait;
    end process;
end architecture;
