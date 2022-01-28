library ieee;
use ieee.std_logic_1164.all;

entity main_decoder is
	port(
		instr 			: in std_logic_vector(31 downto 0);
		zero			: in std_logic;
		pc_src, mem_write		: out std_logic;
		alu_src, reg_write 	: out std_logic;
		result_src		: out std_logic_vector(1 downto 0);
		imm_src, alu_op		: out std_logic_vector(1 downto 0)
	);
end;

architecture with_process of main_decoder is
	signal op 	: std_logic_vector(6 downto 0);
	signal branch 	: std_logic;
	signal jump 	: std_logic;
begin
	op <= instr(6 downto 0); --dispatcher
	process(op)
	begin
		case op is
			when "0000011" => 	-- lw instruction
				reg_write <= '1';	
				imm_src <= "00";		
				alu_src <= '1';
				mem_write <= '0';	
				result_src <= "01";	
				branch <= '0';
				alu_op <= "00";		
				jump <= '0';	
			when "0100011" =>	-- sw instruction
				reg_write <= '0';	
				imm_src <= "01";		
				alu_src <= '1';
				mem_write <= '1';	
				result_src <= "00";	
				branch <= '0';
				alu_op <= "00";		
				jump <= '0';
			when "0110011" =>	-- r type instructions
				reg_write <= '1';	
				imm_src <= "00";		
				alu_src <= '0';
				mem_write <= '0';	
				result_src <= "00";	
				branch <= '0';
				alu_op <= "10";		
				jump <= '0';
			when "1100011" =>	-- beq instruction
				reg_write <= '0';	
				imm_src <= "10";		
				alu_src <= '0';
				mem_write <= '0';	
				result_src <= "00";	
				branch <= '1';
				alu_op <= "01";		
				jump <= '0';
			when "0010011" =>	-- addi instruction
				reg_write <= '1';	
				imm_src <= "00";		
				alu_src <= '1';
				mem_write <= '0';	
				result_src <= "00";	
				branch <= '0';
				alu_op <= "10";		
				jump <= '0';
			when "1101111" =>	-- j type instruction
				reg_write <= '1';	
				imm_src <= "00";		
				alu_src <= '1';
				mem_write <= '1';	
				result_src <= "10";	
				branch <= '0';
				alu_op <= "00";		
				jump <= '1';
			when others =>
				reg_write <= '0';	
				imm_src <= "00";		
				alu_src <= '0';
				mem_write <= '0';	
				result_src <= "00";	
				branch <= '0';
				alu_op <= "00";		
				jump <= '0';
		end case;
	end process;
	pc_src <= ((zero and branch) or jump);

end architecture;
