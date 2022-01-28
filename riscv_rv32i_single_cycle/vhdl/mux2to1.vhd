library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
	port
	(
		a, b	: in	std_logic_vector(31 downto 0);
		s	: in	std_logic;
		y	: out	std_logic_vector(31 downto 0)
	);
end entity;

architecture mux2to1architecture of mux2to1 is
begin
	y <=	b when s = '1' else 
		a;
end architecture;