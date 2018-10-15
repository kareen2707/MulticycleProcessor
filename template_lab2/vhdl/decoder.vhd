library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
    port(
        address : in  std_logic_vector(15 downto 0);
        cs_LEDS : out std_logic;
        cs_RAM  : out std_logic;
        cs_ROM  : out std_logic
    );
end decoder;

architecture synth of decoder is
begin

cs_LEDS <= '1' when ((unsigned(address) >= X"2000") and ((unsigned(address) < X"2010"))) else '0';
cs_RAM <= '1' when ((unsigned(address) < X"2000") and ((unsigned(address) >= X"1000"))) else '0';
cs_ROM <= '1' when ((unsigned(address) >= X"0000") and ((unsigned(address) < X"1000"))) else '0';

end synth;
