library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity data_memory_tb is
end data_memory_tb;

architecture behavioral of data_memory_tb is

component data_memory is
	port(	clk :	in std_logic; 
		rst :	in std_logic;
		we :	in std_logic;
		wd, a : in std_logic_vector(31 downto 0);
		rd :	out std_logic_vector(31 downto 0)
	);
end component;

	signal wd_tb, rd_tb, a_tb : 	std_logic_vector(31 downto 0)	:= (others => '0');
	signal clk_tb, rst_tb ,we_tb :	std_logic			:= '0';
begin

	data_memory_inst : data_memory port map(clk_tb, rst_tb, we_tb, wd_tb, a_tb, rd_tb);

	clk_tb 	<=	not(clk_tb)	after 10 ns;
	rst_tb	<=	'0',
			'1'		after 10 ns,
			'0'		after 30 ns;
	we_tb	<=	'1',
			'0'		after 90 ns;
	wd_tb	<=	x"00000000",
			x"00000001" 	after 30 ns,
			x"00000011" 	after 50 ns,
			x"10101010"	after 70 ns,
			x"00000001"	after 90 ns,
			x"00000001"	after 110 ns,
			x"00000001"	after 130 ns;
	a_tb	<=	x"00000000",
			x"00000001"	after 50 ns,
			x"0000000a"	after 70 ns,
			x"0000000a" 	after 90 ns,
			x"00000001"	after 110 ns,
			x"00000040"	after 130 ns;
end behavioral;