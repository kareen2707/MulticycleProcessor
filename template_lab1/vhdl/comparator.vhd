library ieee;
use ieee.std_logic_1164.all;

entity comparator is
    port(
        a_31    : in  std_logic;
        b_31    : in  std_logic;
        diff_31 : in  std_logic;
        carry   : in  std_logic;
        zero    : in  std_logic;
        op      : in  std_logic_vector(2 downto 0);
        r       : out std_logic
    );
end comparator;

architecture synth of comparator is

signal s_a_31: std_logic;
signal s_b_31: std_logic;
signal s_diff_31: std_logic;
signal s_carry: std_logic;
signal s_zero: std_logic;
signal s_op: std_logic_vector(2 downto 0);
signal s_r: std_logic;
signal s_temp0: std_logic;
signal s_temp1: std_logic;
signal s_temp2: std_logic;

begin

s_a_31 <= a_31;
s_b_31 <= b_31;
s_diff_31 <= diff_31;
s_carry <= carry;
s_zero <= zero;
s_op <= op;
r <= s_r;

with s_op select
	s_r <=
	(s_a_31 and not s_b_31) or ( (s_a_31 xnor s_b_31) and (s_diff_31 or s_zero)) when "001",
	(s_b_31 and not s_a_31) or ((s_a_31 xnor s_b_31) and (not s_diff_31 and not s_zero)) when "010",
	not(s_zero) when "011",
	s_zero when "100",
	(not(s_carry)) or s_zero when "101",
	s_carry and (not(s_zero)) when "110",
	s_zero when others;


end synth;
