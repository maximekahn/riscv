
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc_target_tb is
end pc_target_tb;

architecture behavioral of pc_target_tb is

component pc_target is
port(	in_a, in_b : in std_logic_vector(31 downto 0);
     	out_pc_target : out std_logic_vector(31 downto 0)
    );
end component;

	signal in_a_tb, in_b_tb, out_pc_target_tb : std_logic_vector(31 downto 0) := (others => '0');

begin 
	pc_target_inst : pc_target port map(in_a_tb, in_b_tb, out_pc_target_tb);
	
	in_a_tb	<=	x"00000001" after 10 ns,
			x"00000101" after 20 ns;
	in_b_tb <= 	x"00000011" after 30 ns,
			x"00001111" after 40 ns;
end behavioral;