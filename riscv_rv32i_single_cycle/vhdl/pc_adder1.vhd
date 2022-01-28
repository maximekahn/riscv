library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc_adder1 is
	port
	(
		pc_adder1 	: in	std_logic_vector(31 downto 0);
		pc_plus1	: out	std_logic_vector(31 downto 0)
	);
end entity;

architecture pc_adder1_architecture of pc_adder1 is
begin
	pc_plus1 <= pc_adder1 + 1;
end architecture;