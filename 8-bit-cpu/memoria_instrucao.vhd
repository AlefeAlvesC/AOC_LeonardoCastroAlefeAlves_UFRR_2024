--Projeto de uma memoria de instruções
--Área de importe de bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Área da entidade, onde definimos as principais I/O do circuito
ENTITY memoria_instrucao IS
	generic(n	:	integer	:=	8);--Quantidade de bits das entradas e saidas principais
	
	port(
			endereco	:	in	std_logic_vector(n-1 downto 0);
			instrucao	:	out	std_logic_vector(n-1 downto 0)
	);

END ENTITY memoria_instrucao;

--Área da arquitetura, onde implementamos a lógica principal do circuito
ARCHITECTURE behavioral OF memoria_instrucao IS
	type instrucoes is array (0 to 2**n-1) of std_logic_vector(n-1 downto 0);--Criando um novo tipo, para instanciar uma memoria
	
	signal	memoria	: instrucoes := (	
		"01000001",--Instrução 0: 	lw $s0, 1($s0);		<=Carrega o valor da posição 1 da memoria para o reg 0
		"01011011",--Instrução 1:	lw $s3, 3($s3);		<=Carrega o valor da posição 3 da memoria para o reg 3
												
		"00010110",--Instrução 2:	add $s2, $s2, $s3;	<=Soma os conteudos de s2 e s3 e salva em s2 
		"10010011",--Instrução 3:	beq $s2, FIM;		<=Compara o conteudo de s2 com s0(padrão), se for igual pula para o fim
		"00011100",--Instrução 4:	add $s3, $s3, $s2;	<=Soma os conteudos de s3 e s2 e salva em s3
		"10011001",--Instrução 5:	beq $s3, FIM;		<=Compara o conteudo de s3 com s0(padrão), se for igual pula para o fim
											
		"10100010",--Instrução 6: 	jump loop;			<=Loop que sempre vai para a instrução 2
		"01111000",--Instrução 7:	sw $s3, 0($s3);		<=Carrega o valor da posição 3 do banco para a memória na posição 233(valor no reg 3). Instrução para qual o beq redireciona
												
		others => (others => '1')--Instruções Inválidas ou fim do programa.
	);
BEGIN

	busca: process (endereco)
	begin
		instrucao <= memoria(to_integer(unsigned(endereco)));
	end process busca;
	
END ARCHITECTURE behavioral;