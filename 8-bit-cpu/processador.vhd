--Área de importe
library IEEE;
use IEEE.std_logic_1164.all;

ENTITY processador IS
	generic(
		e	:	integer	:= 2;
		n	:	integer	:= 8
	);
	
	port(
		clk_v, rst_v	:	in 	std_logic;
		pc_saida_v		:	out	std_logic_vector(n-1 downto 0);
		instrucao_v		:	out	std_logic_vector(n-1 downto 0);
		reg1_v, reg2_v	:	out	std_logic_vector(n-1 downto 0);
		imed_3x8			:	out	std_logic_vector(n-1 downto 0);
		result_ula		:	out	std_logic_vector(n-1 downto 0);
		leitura_mem		:	out	std_logic_vector(n-1 downto 0);
		zero_v			:	out	std_logic;
		jump_v			:	out	std_logic;
		branch_v			:	out	std_logic;
		memWrite_v		:	out	std_logic;
		memRead_v		:	out	std_logic;
		ulaop_v			:	out	std_logic;
		imed_5x8			:	out	std_logic_vector(n-1 downto 0)
		
	);

END ENTITY processador;

ARCHITECTURE behavioral OF processador IS
	signal clk, rst	:	std_logic;
	
	--Sinais do pc
	signal pc_entrada	:	std_logic_vector(n-1 downto 0);
	signal pc_saida	:	std_logic_vector(n-1 downto 0);
	
	--Sinal de saida do somador PC+1
	signal instruc_pc1:	std_logic_vector(n-1 downto 0);	
	
	--Sinais para a memoria de instrução
	signal instrucao	:	std_logic_vector(n-1 downto 0);
	
	--Divisor de bits
	signal opcode 		:	std_logic_vector(2 downto 0);
	signal reg1			:	std_logic_vector(1 downto 0);
	signal reg2			:	std_logic_vector(1 downto 0);
	signal immed		:	std_logic_vector(2 downto 0);
	signal immedJ		:	std_logic_vector(4 downto 0);
	
	--Sinais da unidade de controle
	signal Jump			:	std_logic;
	signal Branch		:	std_logic;
	signal Memread		:	std_logic;
	signal Memtoreg	:	std_logic;
	signal ulaOp		:	std_logic;
	signal MemWrite	:	std_logic;
	signal ulaSrc		:	std_logic;
	signal RegWrite	:	std_logic;
	
	--Sinais do banco de registrador
	signal escr_dado	:	std_logic_vector(n-1 downto 0);
	signal reg1_saida	:	std_logic_vector(n-1 downto 0);
	signal reg2_saida	:	std_logic_vector(n-1 downto 0);
	
	--Sinais da ula
	signal result		:	std_logic_vector(n-1 downto 0);
	signal zero			:	std_logic;
	
	--Sinal para o extensor 3x8
	signal immed_extd:	std_logic_vector(n-1 downto 0);
	
	--Sinal do mux da ula
	signal mux_ulaout	:	std_logic_vector(n-1 downto 0);
	
	--Sinal da memoria de dados
	signal dado_out	:	std_logic_vector(n-1 downto 0);
	
	--Sinal do mux atras do banco
	signal mux_reg		:	std_logic_vector(n-1 downto 0);
	
	--Sinal do endereco de instrução apos beq: PC+1 + OFFSET
	signal ender_beq	:	std_logic_vector(n-1 downto 0);
	
	--Sinal para vericar se o desvio condicional esta ativado
	signal dvc			:	std_logic;
	
	--Sinal após o primeiro mux
	signal instruc_1	:	std_logic_vector(n-1 downto 0);
	
	--Sinal para a saida do extensor 5x8
	signal immedJ_extd:	std_logic_vector(n-1 downto 0);
	
BEGIN
		
	clk 			<= clk_v;
	rst 			<= rst_v;
	pc_saida_v 	<= pc_saida;
	instrucao_v <= instrucao;
	reg1_v		<= reg1_saida;
	reg2_v		<= reg2_saida;
	imed_3x8 	<= immed_extd;
	result_ula	<= result;
	leitura_mem	<= dado_out;
	zero_v		<=	zero;
	jump_v		<=	Jump;
	branch_v		<=	Branch;
	memWrite_v	<=	MemWrite;
	memRead_v	<= Memread;
	ulaop_v		<=	ulaOp;
	imed_5x8		<=	immedJ_extd;
	
	--Instaciando o registrador pc
	pc			: entity work.pc generic map(n) port map(pc_entrada, clk, rst, pc_saida);
	--Instanciando um somador com 1 constante
	sum_com1	: entity work.somador generic map(n) port map(pc_saida, "00000001", instruc_pc1);
	--Instanciando a memoria de instruções
	mem_inst	: entity work.memoria_instrucao generic map(n) port map(pc_saida, instrucao);
	
	--Decodificando as intruções
	opcode	<= instrucao(7 downto 5);
	reg1		<= instrucao(4 downto 3);
	reg2		<= "00" when opcode = "100" else instrucao(2 downto 1);
	
	immed		<= instrucao(2 downto 0);
	immedJ	<=	instrucao(4 downto 0);
	
	--Instanciando a unidade de controle
	uc			: entity work.unidade_controle port map(opcode, Jump, Branch, Memread, Memtoreg, ulaOp, MemWrite, ulaSrc, RegWrite);	
	--Instanciando o banco de registradores
	banco_reg: entity work.banco_registradores generic map(n, e) port map(clk, RegWrite, reg1, reg2, escr_dado, reg1_saida, reg2_saida);
	--Instanciando a ula
	ula		: entity work.ula generic map(n) port map(reg1_saida, mux_ulaout, ulaOp, result, zero);	
	--Instanciando o extensor de 3x8
	extd1		: entity work.extensor_3x8 port map(immed, immed_extd);
	--Instanciando o multiplexador na frente da ula;
	mux_ula	: entity work.mux_2x1 generic map(n) port map(reg2_saida, immed_extd, ulaSrc, mux_ulaout);
	--Instanciando a memoria de dados
	mem_dado	: entity work.memoria_dados generic map(n) port map(result, reg1_saida, dado_out, MemWrite, Memread, clk);
	
	--Ligando a saida do mux atras da ula com o banco de registradores
	escr_dado <= mux_reg;
	
	--Instanciando o multiplexador atrás do memoria dados
	mux_reslt: entity work.mux_2x1 generic map(n) port map(result, dado_out, Memtoreg, mux_reg);
	--Instanciando um somador de para o soma de instrução mais desvio
	sum_inst	: entity work.somador generic map(n) port map(instruc_pc1, immed_extd, ender_beq);
	
	--Verifica se a flag da ula está ativada e se o resultado do beq deu zero
	dvc <= Branch and zero;
	
	--Instanciando o multiplexador para escolha entre o endereco pc+1 ou beq
	mux_dvc	: entity work.mux_2x1 generic map(n) port map(instruc_pc1, ender_beq, dvc, instruc_1);
	
	--Instanciando o extensor 5x8
	extd2		: entity work.extensor_5x8 port map(immedJ, immedJ_extd);
	--Instanciando o multiplexador para escolha entre o endereço do jump e do resltado do mux_dvc
	mux_jump	: entity work.mux_2x1 generic map(n) port map(instruc_1, immedJ_extd, Jump, pc_entrada);
	
	
END ARCHITECTURE behavioral;