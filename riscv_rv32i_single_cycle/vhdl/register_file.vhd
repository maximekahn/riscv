library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity register_file is
	port(
		clk, rst, we3	: in	std_logic;
		a1, a2, a3 	: in	std_logic_vector(4 downto 0);
		wd3		: in	std_logic_vector(31 downto 0);
		rd1, rd2 	: out	std_logic_vector(31 downto 0)
	);
end entity;

architecture regiter_file_architecture of register_file is

	type rf_mem is array(0 to 31) of std_logic_vector(31 downto 0);

	signal rf_ram : rf_mem;
begin
	process(clk, rst)
	begin
		if (rst = '1') then
			rf_ram <= (others => (others => '0'));
		elsif(clk'event and clk='1') then
			if(we3='1' and (a3 /= "00000")) --adress 0 of register file always assigned to 0
			then
				rf_ram(to_integer(unsigned(a3))) <= wd3;
			end if;
		end if;
	end process;
	
	rd1 <= rf_ram(to_integer(unsigned(a1)));
	rd2 <= rf_ram(to_integer(unsigned(a2)));
	
end architecture;