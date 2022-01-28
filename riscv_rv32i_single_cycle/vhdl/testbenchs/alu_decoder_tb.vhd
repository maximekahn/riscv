library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu_decoder_tb is
end alu_decoder_tb;

architecture behavioral of alu_decoder_tb is

component alu_decoder is
	port(
		instr : in std_logic_vector(31 downto 0);
		alu_op : in std_logic_vector(1 downto 0);
		alu_control : out std_logic_vector(2 downto 0)
	);
end component;

	signal instr_tb : 	std_logic_vector(31 downto 0)	:= (others => '0');
	signal alu_op_tb :	std_logic_vector(1 downto 0)	:= (others => '0');
	signal alu_control_tb : 	std_logic_vector(2 downto 0)	:= (others => '0'); 
begin

	alu_decoder_inst : alu_decoder port map(instr_tb, alu_op_tb, alu_control_tb);

	alu_op_tb 		<= 	"00",
					"01"	after 10 ns,
					"10"	after 20 ns;
	instr_tb(14 downto 12)	<=	"000",
					"001"	after 60 ns,
					"010"	after 70 ns,
					"011"	after 80 ns,
					"100"	after 90 ns,
					"101"	after 100 ns,
					"110"	after 110 ns,
					"111"	after 120 ns;
	instr_tb(30)		<=	'0',
					'1'	after 30 ns,
					'0'	after 40 ns,
					'1'	after 50 ns;
	instr_tb(5)		<=	'0',
					'1'	after 40 ns;

end behavioral;