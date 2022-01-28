library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux2to1_tb is
end mux2to1_tb;

architecture behavioral of mux2to1_tb is

component mux2to1 is
	port(
		e0, e1: in std_logic_vector(31 downto 0);
		s : in std_logic;
		o : out std_logic_vector(31 downto 0)
	);
end component;
	signal e0_tb, e1_tb, o_tb : std_logic_vector(31 downto 0) := (others => '0');
	signal s_tb : std_logic := '0';

begin 
	mux2to1_inst : mux2to1 port map(e0_tb, e1_tb, s_tb, o_tb);
	
	s_tb	<= 	'0',
			'1' after 10 ns;
	e0_tb 	<= 	x"0f0f0f0f";
	e1_tb	<=	x"f0f0f0f0";
end behavioral;