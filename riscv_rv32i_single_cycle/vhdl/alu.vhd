library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
port(  	src_a,src_b	: in	std_logic_vector(31 downto 0);
			alu_control	: in	std_logic_vector(2 downto 0);
			alu_result	: out	std_logic_vector(31 downto 0);
	zero		: out	std_logic
    );
end alu;

  
architecture behavioral of alu is
 	signal reg1,reg2,reg3	: std_logic_vector(31 downto 0);
	signal ctl		: std_logic_vector(2 downto 0);
	signal z 		: std_logic;
begin

	reg1 <= src_a;
	reg2 <= src_b;
	ctl <= alu_control;
	alu_result <= reg3;
	zero <= '1' when (reg3 = 0) else '0';
	
	process (reg1, reg2, ctl)
	begin
		
		if 	ctl = "000" then	-- addition
			reg3 <= reg1 + reg2;
				
		elsif 	ctl = "001" then	-- soustraction
			reg3 <= reg1 - reg2; 
						
		elsif 	ctl = "010" then	-- porte et
			reg3 <= reg1 and reg2; 

		elsif 	ctl = "011" then	-- porte ou 
			reg3 <= reg1 or reg2; 

		elsif 	ctl = "101" then	-- set less than
			if (reg1 < reg2) then
				reg3 <= "00000000000000000000000000000001";
			else
				reg3 <= (others => '0');
			end if;		
		end if;
	end process;   
end behavioral;