--Projeto de um somador, que será o somador para acesso da proxima instrução, soma instrução + 1
--Área de importe de bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Área da entidade, onde definimos as principais entradas e saidas do circuito
ENTITY somador IS
	
	generic(n	:	integer	:= 8);--Quantidade de bits das entradas e saidas do somador
	
	port(
		a, b	:	in  std_logic_vector(n-1 downto 0);
		soma	:	out std_logic_vector(n-1 downto 0)
	);
	
END ENTITY somador;

--Área da arquitetura, onde definimos a lógica do circuito
ARCHITECTURE behavioral OF somador IS
BEGIN
	soma <= std_logic_vector(unsigned(a) + unsigned(b));
END ARCHITECTURE behavioral;

