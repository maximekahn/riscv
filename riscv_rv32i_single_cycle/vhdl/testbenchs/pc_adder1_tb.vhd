library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc_adder1_tb is
end pc_adder1_tb;

architecture behavioral of pc_adder1_tb is

component pc_adder1 is
	port(
		pc : in std_logic_vector(31 downto 0);
		pc_plus1 : out std_logic_vector(31 downto 0)
	);
end component;

	signal pc_tb, pc_plus1_tb : std_logic_vector(31 downto 0) := (others => '0');

begin 
	pc_adder1_inst : pc_adder1 port map(pc_tb, pc_plus1_tb);
	
	pc_tb	<=	x"0abcdef0" after 10 ns,
			x"0abcdef5" after 20 ns,
			x"0fedcba9" after 30 ns,
			x"ffffffff" after 40 ns;
end behavioral;