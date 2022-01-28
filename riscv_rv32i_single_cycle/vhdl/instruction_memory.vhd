library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity instruction_memory is
	port 
	(
 		pc_instr 	: in	std_logic_vector(31 downto 0);
		instr	: out	std_logic_vector(31 downto 0)
	);
end entity;

architecture instruction_memory_architecture of instruction_memory is

	 type rom_type is array (0 to 20) of std_logic_vector(31 downto 0);
	 signal rom_data : rom_type :=(
		x"00500113", -- 00
		x"00c00193", -- 01
		x"ff718393", -- 02
		x"0023e233", -- 03
		x"0041f2b3", -- 04
		x"004282b3", -- 05
		x"02728863", -- 06
		x"0041a233", -- 07
		x"00400163", -- 08
		x"00000293", -- 09
		x"0023a233", -- 10
		x"005203b3", -- 11
		x"402383b3", -- 12
		x"0471aa23", -- 13
		x"06002103", -- 14
		x"005104b3", -- 15
		x"002001ef", -- 16
		x"00100113", -- 17
		x"00910133", -- 18
		x"0221a023", -- 19
		x"00210063"  -- 20
	  	);
begin
	process(pc_instr)
	begin
 		instr <= rom_data(to_integer(unsigned(pc_instr))); 
	end process;
end architecture;