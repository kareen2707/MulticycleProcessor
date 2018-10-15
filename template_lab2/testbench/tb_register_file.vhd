library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_register_file is
end;

architecture bench of tb_register_file is

    -- declaration of register_file interface
    -- INSERT COMPONENT DECLARATION HERE

Component register_file is
	port( clk, wren : IN std_logic;
		aa, ab, aw : IN std_logic_vector(4 downto 0);
		wrdata: IN  std_logic_vector(31 downto 0);
		a, b    : OUT std_logic_vector(31 downto 0));
end component;

    signal aa, ab, aw   : std_logic_vector(4 downto 0);
    signal a, b, wrdata : std_logic_vector(31 downto 0);
    signal wren         : std_logic := '0';
    -- clk initialization
    signal clk, stop    : std_logic := '0';
    -- clk period definition
    constant CLK_PERIOD : time      := 40 ns;

begin

    -- register_file instance
    -- INSERT REGISTER FILE INSTANCE HERE

	regifile : register_file
	port map(
		aa => aa,
		ab => ab,
		aw => aw,
		wrdata => wrdata,
		clk => clk,
		wren => wren,
		a => a,
		b => b);
	
    clock_gen : process
    begin
        -- it only works if clk has been initialized
        if stop = '0' then
            clk <= not clk;
            wait for (CLK_PERIOD / 2);
        else
            wait;
        end if;
    end process;

    process
    begin
        -- init
        wren   <= '0';
        aa     <= "00000";
        ab     <= "00001";
        aw     <= "00000";
        wrdata <= (others => '0');
        wait for 5 ns;
	--ask about the first WRONG

        -- write in the register file
        wren <= '1';
        for i in 0 to 31 loop
            -- std_logic_vector(to_unsigned(number, bitwidth))
            aw     <= std_logic_vector(to_unsigned(i, 5));
            wrdata <= std_logic_vector(to_unsigned(i + 1, 32));
            wait for CLK_PERIOD;
        end loop;

        -- read in the register file
        -- INSERT CODE THAT READS THE REGISTER FILE HERE
	

	for j in 0 to 31 loop
		aa <= std_logic_vector(to_unsigned(j, 5));
		wait for CLK_PERIOD;
		assert std_logic_vector(to_unsigned(j + 1, 32)) = a
			report "ITS WRONG"
			severity note;
		wait for CLK_PERIOD;
	end loop;

        stop <= '1';
        wait;
    end process;
end bench;

