library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc is
	port
	(
		rst 	: in 	std_logic;
		clk	: in 	std_logic;
		d	: in 	std_logic_vector(31 downto 0);
		q	: out 	std_logic_vector(31 downto 0)
	);
end entity;

architecture pc_architecture of pc is
	signal pc 	: std_logic_vector(31 downto 0);
	signal init_pc	: std_logic;
begin
	process (clk, rst)
	begin
		if (rst = '1') then
			pc <= x"00000000";
			init_pc <= '1';
		elsif ( clk'event and clk='1') then
			if (init_pc = '1') then
				init_pc <= '0';
			elsif (init_pc = '0') then
				pc <= d;
			else
				pc <= (others => '0');
			end if;
		end if;
	end process;
	q <= pc;
end architecture;