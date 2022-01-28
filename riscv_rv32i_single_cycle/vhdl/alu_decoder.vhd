library ieee;
use ieee.std_logic_1164.all;

entity alu_decoder is
	port(
		instr		: in	std_logic_vector(31 downto 0);
		alu_op		: in	std_logic_vector(1 downto 0);
		alu_control	: out	std_logic_vector(2 downto 0)
	);
end;

architecture alu_decoder_architecture of alu_decoder is
	signal op 		: std_logic_vector(6 downto 0);
	signal funct3		: std_logic_vector(2 downto 0);
	signal funct7op5 	: std_logic_vector(1 downto 0);
begin
	op 		<= instr(6 downto 0); --dispatcher
	funct3 		<= instr(14 downto 12);
	funct7op5(0) 	<= instr(30);
	funct7op5(1) 	<= instr(5);
	
	alu_control <=	"000" when alu_op = "00" 					  else
			"001" when alu_op = "01" 					  else
			"000" when alu_op = "10" and funct3 = "000" and (funct7op5 = "00" or funct7op5 = "01" or funct7op5 = "10") else
			"001" when alu_op = "10" and funct3 = "000" and funct7op5  = "11"  else
			"101" when alu_op = "10" and funct3 = "010" 			  else
			"011" when alu_op = "10" and funct3 = "110" 			  else
			"010" when alu_op = "10" and funct3 = "111" 			  else
			"111";
end architecture;