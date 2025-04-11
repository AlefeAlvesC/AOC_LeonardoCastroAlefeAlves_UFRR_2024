--Testbench para o processador MIPS 8 bits
--Área de importe de bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

--Área da entidade
ENTITY processador_tb IS
	constant e : integer	:= 2;
	constant n : integer := 8;
END ENTITY processador_tb;

--Área da arquitetura
ARCHITECTURE simula OF processador_tb IS
	signal clk_v			:	std_logic;
	signal rst_v			:	std_logic := '0';
	signal pc_saida_v		:	std_logic_vector(n-1 downto 0);
	signal instrucao_v	:	std_logic_vector(n-1 downto 0);
	signal reg1_v, reg2_v:	std_logic_vector(n-1 downto 0);
	signal imed_3x8		:	std_logic_vector(n-1 downto 0);
	signal result_ula		:	std_logic_vector(n-1 downto 0);
	signal leitura_mem	:	std_logic_vector(n-1 downto 0);
	signal zero_v			:	std_logic;
	signal jump_v			:	std_logic;
	signal branch_v		:	std_logic;
	signal memWrite_v		:	std_logic;
	signal memRead_v		:	std_logic;
	signal ulaop_v			:	std_logic;
	signal imed_5x8		:	std_logic_vector(n-1 downto 0);
	
	constant clk_period 	:	time	:=	50 ns;

BEGIN
	
	dut: entity work.processador generic map (e, n) port map(clk_v, rst_v, pc_saida_v, instrucao_v, reg1_v, reg2_v, imed_3x8, result_ula, leitura_mem, zero_v, jump_v, branch_v, memWrite_v, memRead_v, ulaop_v, imed_5x8);
		
	
	gerar_clk: process
	begin
	
		clk_v <= '0';
		wait for clk_period / 2;
		clk_v <= '1';
		wait for clk_period / 2;
	
	end process gerar_clk;
	
	rst_v <= '1';
	
END ARCHITECTURE simula;