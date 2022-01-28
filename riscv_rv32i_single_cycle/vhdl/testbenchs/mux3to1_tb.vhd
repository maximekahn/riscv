library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux3to1_tb is
end mux3to1_tb;

architecture behavioral of mux3to1_tb is

component mux3to1 is
	port(
		e0, e1, e2 : in std_logic_vector(31 downto 0);
		s : in std_logic_vector(1 downto 0);
		o : out std_logic_vector(31 downto 0)
	);
end component;
	signal e0_tb, e1_tb, e2_tb, o_tb : std_logic_vector(31 downto 0) := (others => '0');
	signal s_tb : std_logic_vector(1 downto 0) := (others => '0');

begin 
	mux3to1_inst : mux3to1 port map(e0_tb, e1_tb, e2_tb, s_tb, o_tb);
	
	s_tb	<= 	"00",
			"01" after 10 ns,
			"10" after 20 ns,
			"11" after 30 ns;
	e0_tb 	<= 	x"0f0f0f0f";
	e1_tb	<=	x"f0f0f0f0";
	e2_tb	<=	x"00ff00ff";
end behavioral;