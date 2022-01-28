library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc_tb is
end pc_tb;

architecture behavioral of pc_tb is

component pc is
	port(
		rst : in std_logic;
		clk : in std_logic;
		pc_next: in std_logic_vector(31 downto 0);
		pc_out: out std_logic_vector(31 downto 0)
	);
end component;

	signal pc_next_tb, pc_out_tb : std_logic_vector(31 downto 0) := (others => '0');
	signal rst_tb, clk_tb : std_logic := '0';

begin 
	pc_inst : pc port map(rst_tb, clk_tb, pc_next_tb, pc_out_tb);
	
	rst_tb		<= 	'0',
				'1' after 10 ns,
				'0' after 30 ns;
	clk_tb		<=	not(clk_tb) after 10 ns;

	pc_next_tb	<=	pc_next_tb+1 after 20 ns;
end behavioral;