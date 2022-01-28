library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu_tb is
end alu_tb;

architecture behavioral of alu_tb is

component alu
	port(  	src_a,src_b :	in std_logic_vector(31 downto 0); 
		alu_control :	in std_logic_vector(2 downto 0); 
		alu_result :	out std_logic_vector(31 downto 0);
		zero :		out std_logic
	    );
end component;

	signal src_a_tb:		std_logic_vector(31 downto 0) 	:= "00000000000000000000000000010000"; 
	signal src_b_tb :	std_logic_vector(31 downto 0) 	:= "00000000000000000000000000000001"; 
	signal alu_control_tb : 	std_logic_vector(2 downto 0)	:= (others => '0'); 
	signal alu_result_tb : 	std_logic_vector(31 downto 0)	:= (others => '0');
	signal zero_tb :	std_logic := '0';
begin

	alu_inst : alu port map(src_a_tb, src_b_tb, alu_control_tb, alu_result_tb, zero_tb);

	alu_control_tb 	<= 	"000" after 10 ns,
				"001" after 20 ns,
				"010" after 30 ns,
				"011" after 40 ns,
				"100" after 50 ns,
				"101" after 60 ns,
				"110" after 70 ns,
				"111" after 80 ns;
end behavioral;