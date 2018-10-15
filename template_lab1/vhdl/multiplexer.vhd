library ieee;
use ieee.std_logic_1164.all;

entity multiplexer is
    port(
        i0  : in  std_logic_vector(31 downto 0);
        i1  : in  std_logic_vector(31 downto 0);
        i2  : in  std_logic_vector(31 downto 0);
        i3  : in  std_logic_vector(31 downto 0);
        sel : in  std_logic_vector(1 downto 0);
        o   : out std_logic_vector(31 downto 0)
    );
end multiplexer;

architecture synth of multiplexer is

signal s_i0: std_logic_vector(31 downto 0);
signal s_i1: std_logic_vector(31 downto 0);
signal s_i2: std_logic_vector(31 downto 0);
signal s_i3: std_logic_vector(31 downto 0);
signal s_sel: std_logic_vector(1 downto 0);
signal s_o: std_logic_vector(31 downto 0);

begin

s_i0 <= i0;
s_i1 <= i1;
s_i2 <= i2;
s_i3 <= i3;
s_sel <= sel;
o <= s_o;

	multiplexer_process : process(s_i0, s_i1, s_i2, s_i3, s_sel) 
	begin
		case s_sel is 
		
			when "00" => s_o <= s_i0;
			when "01" => s_o <= s_i1;
			when "10" => s_o <= s_i2;
			when "11" => s_o <= s_i3;
			when others => s_o <= s_i0;
		end case;

	end process;
end synth;

