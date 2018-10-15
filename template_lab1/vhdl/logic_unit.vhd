library ieee;
use ieee.std_logic_1164.all;

entity logic_unit is
    port(
        a  : in  std_logic_vector(31 downto 0);
        b  : in  std_logic_vector(31 downto 0);
        op : in  std_logic_vector(1 downto 0);
        r  : out std_logic_vector(31 downto 0)
    );
end logic_unit;

architecture synth of logic_unit is

signal s_a: std_logic_vector(31 downto 0);
signal s_b: std_logic_vector(31 downto 0);
signal s_op: std_logic_vector(1 downto 0);
signal s_r: std_logic_vector(31 downto 0);


begin

s_a <= a;
s_b <= b;

logic_unit_process: process (op, s_a, s_b)

	begin

		case op is
		
			when "00" => 
				s_r <= s_a NOR s_b;
			when "01" => 
				s_r <= s_a AND s_b;
			when "10" => 
				s_r <= s_a OR s_b;
			when "11" => 
				s_r <= s_a XNOR s_b;
			when others =>
				s_r <= s_a;
		end case;
		
	end process;

r <= s_r;	


end synth;
