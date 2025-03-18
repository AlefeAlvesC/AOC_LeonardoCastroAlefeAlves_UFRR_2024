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
		"01000000",--Instrução 1: 	lw $s0, 0($s0);<=Carrega o valor da posição 0 da memoria para o reg 0
		"01001000",--Instrução 2:	lw $s1, 0($s1);<=Carrega o valor da posição 1 da memoria para o reg 1
		"01010000",--Instrução 3:	lw $s2, 0($s2);<=Carrega o valor da posição 3 da memoria para o reg 2
		"10010100",--Instrução 4:	beq $s3, inicio;<=Compara reg3 ao reg0 e pula para o fim do programa 
		"00000010",--Instrução 5:	add $s0, $s0, $s1; 
		"10101000",--Instrução 6:	jump 1000;<= Pula pra 8 instrução;
		"00110010",--Instrução 7:	sub $s2, $s2, $s1;<=Nunca executada.
												
		others => (others => '1' )--Instruções Inválidas
	);
BEGIN

	busca: process (endereco)
	begin
		instrucao <= memoria(to_integer(unsigned(endereco)));
	end process busca;
	
END ARCHITECTURE behavioral;