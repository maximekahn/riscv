
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity MainDecoder_TB is
END MainDecoder_TB;

ARCHITECTURE Behavioral OF MainDecoder_TB is

COMPONENT MainDecoder IS
	port(	Instr : in std_logic_vector(31 downto 0);
		zero : in std_logic;
		PCSrc, MemWrite, ALUSrc, RegWrite: out std_logic;
		ResultSrc : out std_logic_vector(1 downto 0);
		ImmSrc, ALUOp : out std_logic_vector(1 downto 0)
	);
END COMPONENT;

	SIGNAL 	Instr_TB 	: 	std_logic_vector(31 downto 0)	:= (OTHERS => '0');
	SIGNAL 	ResultSrc_TB, 
		ImmSrc_TB, 
		ALUOp_TB	:	std_logic_vector(1  downto 0)	:= (OTHERS => '0');
	SIGNAL	Zero_TB, 
		PCSrc_TB, 
		MemWrite_TB, 
		ALUSrc_TB, 
		RegWrite_TB	:	std_logic := '0';
BEGIN

	MainDecoder_Inst : entity work.MainDecoder(WithProcess) port map(Instr_TB,
			 						 Zero_TB, 
									 PCSrc_TB, MemWrite_TB, ALUSrc_TB, RegWrite_TB,
									 ResultSrc_TB,
									 ImmSrc_TB, ALUOp_TB);

	Instr_TB 	<=	x"00000003",
				x"00000023" after 10 ns,
				x"00000033" after 20 ns,
				x"00000063" after 30 ns,
				x"0000006F" after 40 ns;	
END Behavioral;