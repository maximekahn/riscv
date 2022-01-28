library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity register_file is
	port(
		clk, we3	: in std_logic;
		instr, wd3	: in std_logic_vector(31 downto 0);
		rd1, rd2 	: out std_logic_vector(31 downto 0)
	);
end entity;

architecture regiter_file_architecture of register_file is

	type mem is array(0 to 31) of std_logic_vector(31 downto 0);
	signal ram_block : mem := (others => x"00000000"); --adress 0 of register file always assigned to 0
	
	signal a1		: std_logic_vector(4 downto 0) := b"00000"; --dispatcher 19:15 of a
	signal a2 		: std_logic_vector(4 downto 0) := b"00000"; --dispatcher 24:20 of a
	signal a3 		: std_logic_vector(4 downto 0) := b"00000"; --dispatcher 11:7 of a
	signal rd1out, rd2out	: std_logic_vector(31 downto 0) := x"00000000";

begin
	a1 <= instr(19 downto 15); -- instruction dispatcher in a
	a2 <= instr(24 downto 20);
	a3 <= instr(11 downto 7);
	
	process(clk)
	begin
		if(clk'event and clk='1')
		then
			if(we3='1' and to_integer(unsigned(a3))/=0) --adress 0 of register file always assigned to 0
			then
				ram_block(to_integer(unsigned(a3))) <= wd3;
			end if;
		end if;
	end process;
	
	
	rd1out <= ram_block(to_integer(unsigned(a1)));
	rd2out <= ram_block(to_integer(unsigned(a2)));
	rd1 <= rd1out;
	rd2 <= rd2out;
	
end architecture;