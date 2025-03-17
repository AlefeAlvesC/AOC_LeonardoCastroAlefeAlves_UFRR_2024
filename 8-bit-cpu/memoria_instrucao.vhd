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
	
	signal	memoria	: instrucoes := (	"10000000",--Instrução 1
										"00000001",--Instrução 2
										"00000010",--Instrução 3
										"00000011",--Instrução 4
										"00000100",--Instrução 5
										"00000101",--Instrução 6
										"00000110",--Instrução 7
										"00000111",--Instrução 8
										"00001000",--Instrução 9
										"00001001",--Instrução 10
										"00001010",--Instrução 11
										"00001011",--Instrução 12
										others => (others => '0' )--Instruções Inválidas
	
	);
BEGIN

	busca: process (endereco)
	begin
		instrucao <= memoria(to_integer(unsigned(endereco)));
	end process busca;
	
END ARCHITECTURE behavioral;