library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity data_memory is
	port(	
		clk, rst, we	: in	std_logic; 
		wd, a 		: in	std_logic_vector(31 downto 0);
		rd 		: out 	std_logic_vector(31 downto 0)
	);
end entity;

architecture data_memory_architecture of data_memory is

	signal data_in, data_out, addr : std_logic_vector(31 downto 0);

	type ram_array is array (0 to 100) of std_logic_vector(31 downto 0);

	signal ram : ram_array	:=	( others => ( others => '0'));
begin

	data_in	<= wd;
	addr	<= a;
	rd	<= data_out;
	
	process(clk,rst)
	begin
		if rst = '1' then		
			ram <= (others => (others => '0'));
			
		elsif (clk'event and clk = '0') then 
			if we='1' then	-- mode lecture
				ram(to_integer(unsigned(addr))) <= data_in;

			else 		-- mode ecriture
				data_out <= ram(to_integer(unsigned(addr)));
			end if;
		end if;
	end process;
end;
