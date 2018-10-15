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
signal s_one: std_logic_vector(31 downto 0); 

begin

s_a <= a;
s_b <= b;
r <= s_r;
carry <= s_carry;
zero <= s_zero;
s_sub_mode <= sub_mode;


s_b_final <= s_b WHEN s_sub_mode = '0' ELSE not(s_b);

s_r_aux <= std_logic_vector(unsigned('0' & s_a) + unsigned('0' & s_b_final)) WHEN s_sub_mode = '0'
		ELSE std_logic_vector(unsigned('0' & s_a) + unsigned('0' & s_b_final) + 1);
s_r <= s_r_aux(31 DOWNTO 0);
s_carry <= s_r_aux(32);
s_zero <= '1' WHEN (unsigned(s_r) = 0) ELSE '0'; 

end synth;
