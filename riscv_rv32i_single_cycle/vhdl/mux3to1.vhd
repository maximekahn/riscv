library ieee;
use ieee.std_logic_1164.all;

entity mux3to1 is
	port
	(
		a, b, c	: in	std_logic_vector(31 downto 0);
		s	: in	std_logic_vector(1 downto 0);
		y	: out	std_logic_vector(31 downto 0)
	);
end entity;

architecture mux3to1architecture of mux3to1 is
begin
	y <= 	c when s = "10" else 
		b when s = "01" else 
		a;
end architecture;
