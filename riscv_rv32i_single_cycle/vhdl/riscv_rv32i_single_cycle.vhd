-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
-- CREATED		"Fri Jan 28 20:58:09 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY riscv_rv32i_single_cycle IS 
	PORT
	(
		clock :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		alu_result :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		instruction :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		pc_out :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		read_data :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		write_data :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END riscv_rv32i_single_cycle;

ARCHITECTURE bdf_type OF riscv_rv32i_single_cycle IS 

COMPONENT instruction_memory
	PORT(pc_instr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 instr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT main_decoder
	PORT(zero : IN STD_LOGIC;
		 instr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 pc_src : OUT STD_LOGIC;
		 mem_write : OUT STD_LOGIC;
		 alu_src : OUT STD_LOGIC;
		 reg_write : OUT STD_LOGIC;
		 alu_op : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 imm_src : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 result_src : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu_decoder
	PORT(alu_op : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 instr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 alu_control : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2to1
	PORT(s : IN STD_LOGIC;
		 a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu
	PORT(alu_control : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 src_a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 src_b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 zero : OUT STD_LOGIC;
		 alu_result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux3to1
	PORT(a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 c : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT data_memory
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 we : IN STD_LOGIC;
		 a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 wd : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rd : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pc
	PORT(rst : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pc_adder1
	PORT(pc_adder1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 pc_plus1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pc_target
	PORT(in_a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 in_b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 out_pc_target : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT register_file
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 we3 : IN STD_LOGIC;
		 a1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 a2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 a3 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 wd3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rd1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rd2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT extend
	PORT(immsrc : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 instr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 immext : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	alu_control :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	alu_result_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	alu_src :  STD_LOGIC;
SIGNAL	imm_ext :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	imm_src :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	instr :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	mem_write :  STD_LOGIC;
SIGNAL	pc_plus1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	pc_src :  STD_LOGIC;
SIGNAL	pc_target_to :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	read_data_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	result :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	result_src :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	src_a :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	src_b :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	we3 :  STD_LOGIC;
SIGNAL	write_data_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	zero :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 
pc_out <= SYNTHESIZED_WIRE_5;



b2v_inst : instruction_memory
PORT MAP(pc_instr => SYNTHESIZED_WIRE_5,
		 instr => instr);


b2v_inst1 : main_decoder
PORT MAP(zero => zero,
		 instr => instr,
		 pc_src => pc_src,
		 mem_write => mem_write,
		 alu_src => alu_src,
		 reg_write => we3,
		 alu_op => SYNTHESIZED_WIRE_1,
		 imm_src => imm_src,
		 result_src => result_src);


b2v_inst10 : alu_decoder
PORT MAP(alu_op => SYNTHESIZED_WIRE_1,
		 instr => instr,
		 alu_control => alu_control);


b2v_inst11 : mux2to1
PORT MAP(s => alu_src,
		 a => write_data_ALTERA_SYNTHESIZED,
		 b => imm_ext,
		 y => src_b);


b2v_inst12 : alu
PORT MAP(alu_control => alu_control,
		 src_a => src_a,
		 src_b => src_b,
		 zero => zero,
		 alu_result => alu_result_ALTERA_SYNTHESIZED);


b2v_inst13 : mux3to1
PORT MAP(a => alu_result_ALTERA_SYNTHESIZED,
		 b => read_data_ALTERA_SYNTHESIZED,
		 c => pc_plus1,
		 s => result_src,
		 y => result);


b2v_inst15 : data_memory
PORT MAP(clk => clock,
		 rst => reset,
		 we => mem_write,
		 a => alu_result_ALTERA_SYNTHESIZED,
		 wd => write_data_ALTERA_SYNTHESIZED,
		 rd => read_data_ALTERA_SYNTHESIZED);


b2v_inst2 : mux2to1
PORT MAP(s => pc_src,
		 a => pc_plus1,
		 b => pc_target_to,
		 y => SYNTHESIZED_WIRE_2);


b2v_inst3 : pc
PORT MAP(rst => reset,
		 clk => clock,
		 d => SYNTHESIZED_WIRE_2,
		 q => SYNTHESIZED_WIRE_5);


b2v_inst6 : pc_adder1
PORT MAP(pc_adder1 => SYNTHESIZED_WIRE_5,
		 pc_plus1 => pc_plus1);


b2v_inst7 : pc_target
PORT MAP(in_a => SYNTHESIZED_WIRE_5,
		 in_b => imm_ext,
		 out_pc_target => pc_target_to);


b2v_inst8 : register_file
PORT MAP(clk => clock,
		 rst => reset,
		 we3 => we3,
		 a1 => instr(19 DOWNTO 15),
		 a2 => instr(24 DOWNTO 20),
		 a3 => instr(11 DOWNTO 7),
		 wd3 => result,
		 rd1 => src_a,
		 rd2 => write_data_ALTERA_SYNTHESIZED);


b2v_inst9 : extend
PORT MAP(immsrc => imm_src,
		 instr => instr,
		 immext => imm_ext);

alu_result <= alu_result_ALTERA_SYNTHESIZED;
instruction <= instr;
read_data <= read_data_ALTERA_SYNTHESIZED;
write_data <= write_data_ALTERA_SYNTHESIZED;

END bdf_type;