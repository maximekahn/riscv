library ieee;
use ieee.std_logic_1164.all;

entity extend is
	port(
		instr: in std_logic_vector(31 downto 0);
		immsrc: in std_logic_vector(1 downto 0);
		immext: out std_logic_vector(31 downto 0)
	);
end entity;

architecture extend_architecture of extend is
begin
	process(instr, immsrc)
	begin
		case immsrc is
		
			-- i (immediat) type instruction
			when "00" => immext <= (31 downto 12 =>	instr(31)) & 
								instr(31 downto 20);
			
			-- s (store) type instruction
			when "01" => immext <= (31 downto 12 => instr(31)) & 
								instr(31 downto 25) & 
								instr(11 downto 7);
			
			-- b (branche) type instruction
			when "10" => immext <= (31 downto 12 => instr(31)) & 
								instr(7) & 
								instr(30 downto 25) & 
								instr(11 downto 8) & '0';
			
			-- j (jump) type instruction
			when "11" => immext <= (31 downto 20 => instr(31)) & 
								instr(19 downto 12) & 
								instr(20) & 
								instr(30 downto 21) & '0';
			
			when others => immext <= (31 downto 0 => '-');
		end case;
	end process;
 end architecture;