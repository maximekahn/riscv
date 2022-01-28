library ieee;
use ieee.std_logic_1164.all;

entity riscv_rv32i_single_cycle_tb is

end entity;

architecture test_bench_architecture of riscv_rv32i_single_cycle_tb is

component riscv_rv32i_single_cycle
	port
	(
		clock_in :  in  std_logic;
		reset_in :  in  std_logic
	);
end component;

	signal clock_t	: std_logic := '0';
	signal reset_t	: std_logic := '0';
begin
	riscv_rv32i_single_cycle_component : entity work.riscv_rv32i_single_cycle(bdf_type) port map(clock_t, reset_t);

	clock_t	<=	not(clock_t)	after 10 ns;
	reset_t	<=	'1' 		after 0 ns, 
			'0'		after 18 ns; 
end architecture;