library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub is
    port(
        a        : in  std_logic_vector(31 downto 0);
        b        : in  std_logic_vector(31 downto 0);
        sub_mode : in  std_logic;
        carry    : out std_logic;
        zero     : out std_logic;
        r        : out std_logic_vector(31 downto 0)
    );
end add_sub;

architecture synth of add_sub is

signal s_a: std_logic_vector(31 downto 0);
signal s_b: std_logic_vector(31 downto 0);
signal s_b_final: std_logic_vector(31 downto 0);
signal s_sub_mode: std_logic;
signal s_carry: std_logic;
signal s_xor: std_logic_vector(31 downto 0);
signal s_zero: std_logic;
signal s_r: std_logic_vector(31 downto 0);
signal s_r_aux: std_logic_vector(32 downto 0);
--signal s_one: 

begin

s_a <= a;
s_b <= b;
r <= s_r;
carry <= s_carry;
zero <= s_zero;

add_sub_process: process (sub_mode, s_a, s_b)
	begin
		if sub_mode = '1' then
			s_xor <= s_b XOR (31 downto 0 => '1');
			s_b_final <= s_xor + ((30 downto 0 => '0') & '1');
		else 
			s_b_final <= s_b;
		end if;
				
		s_r_aux <= ("0" & s_a) + ("0" & s_b_final);
		s_carry <= s_r_aux(32);
		s_r <= s_r_aux(31 downto 0);

		if s_r_aux(31 downto 0) = (31 downto 0 => '0') then
			s_zero <= '1';
		else
			s_zero <= '0';	
		end if;
end process;

end synth;
