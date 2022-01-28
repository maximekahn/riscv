library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc_target is
port(	in_a, in_b 	: in	std_logic_vector(31 downto 0);
     	out_pc_target 	: out	std_logic_vector(31 downto 0)
    );
end pc_target;

architecture behavioral of pc_target is
begin
	out_pc_target <= in_a + in_b;
end behavioral;