--Projeto de um extensor de 5 para 8 bits
--Área de importe das bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

--Área da entidade, onde definimos as principais entradas e saidas do circuito
ENTITY extensor_5x8 IS
	
	port(
		entrada	:	in	std_logic_vector(4 downto 0);
		saida	:	out	std_logic_vector(7 downto 0)
	);
	
END ENTITY extensor_5x8;

--Área da arquitetura, onde definimos a lógica do circuito
ARCHITECTURE behavioral OF extensor_5x8 IS
BEGIN

	saida <= "000" & entrada;

END ARCHITECTURE behavioral;