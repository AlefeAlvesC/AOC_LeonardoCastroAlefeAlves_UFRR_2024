--Projeto de uma memoria de dados
--Área de importe de bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Área da entidade, onde definimos as principais entradas do circuito.
ENTITY memoria_dados IS

	generic(	n	:	integer	:= 8);--Qtde de bits de uma palavra na memoria
	
	port(
		endereco:	in		std_logic_vector(n-1 downto 0);
		escDado	:	in		std_logic_vector(n-1 downto 0);
		lerDado	:	out	    std_logic_vector(n-1 downto 0);
		memWrite:	in		std_logic;
		memRead	:	in		std_logic;
		clk		:	in		std_logic
	);
	
END ENTITY memoria_dados;

--Área da arquitetura, onde definimos a lógica do circuito
ARCHITECTURE behavioral OF memoria_dados IS
	
	signal lerDado_temp	:	std_logic_vector(n-1 downto 0);
	
	type ram is array(0 to 2**n-1) of std_logic_vector(n-1 downto 0);--Definindo um novo tipo de dado do tipo memoria
	signal mem_dados: ram	:=	(	others => (others => '0'));
	
BEGIN
	
	lerDado <= lerDado_temp;
	
	lerDado_temp <= mem_dados(to_integer(unsigned(endereco))) when memRead = '1';--Realiza a leitura
	
	escrita:	process(memWrite, clk)--Realiza a escrita
	begin
		if	memWrite	= '1' and rising_edge(clk) then
			mem_dados(to_integer(unsigned(endereco))) <= escDado;
		end if;
	end process escrita;
	
END ARCHITECTURE behavioral;
