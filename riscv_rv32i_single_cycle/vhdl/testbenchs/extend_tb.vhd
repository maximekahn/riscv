library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity extend_tb is
end extend_tb;

architecture behavioral of extend_tb is

component extend
	port(
		instr :		in  std_logic_vector(31 downto 0);
		immsrc :	in  std_logic_vector(1  downto 0);
		immext :	out std_logic_vector(31 downto 0)
	);
end component;

	signal instr_tb, imnext_tb : 	std_logic_vector(31 downto 0)	:= (others => '0');
	signal immsrc_tb :		std_logic_vector(1  downto 0)	:= (others => '0');
begin

	extend_inst : extend port map(instr_tb, immsrc_tb, imnext_tb);

	instr_tb 	<=	x"0abcdef0";
	immsrc_tb	<=	"00",
				"01"	after 10 ns,
				"10"	after 20 ns,
				"11"	after 30 ns;
end behavioral;