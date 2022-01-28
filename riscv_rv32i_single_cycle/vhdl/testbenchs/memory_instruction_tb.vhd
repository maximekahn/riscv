library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity memory_instruction_tb is
end memory_instruction_tb;

architecture behavioral of memory_instruction_tb is

component memory_instruction is
port (
 	pc : 		in std_logic_vector(31 downto 0);
 	instruction :	out  std_logic_vector(31 downto 0)
      );
end component;
	signal pc_tb, instruction_tb : std_logic_vector(31 downto 0) := (others => '0');

begin 
	memory_intruction_inst : memory_instruction port map(pc_tb, instruction_tb);
	
	pc_tb <= pc_tb+1 after 10 ns;
end behavioral;
