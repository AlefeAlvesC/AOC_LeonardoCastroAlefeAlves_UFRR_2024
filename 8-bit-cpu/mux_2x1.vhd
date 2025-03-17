--Projeto de um multiplexador 2x1 de 8bits 
--Área de importe de bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

--Área da entidade, onde definimos as principais entradas e saidas do circuito
ENTITY mux_2x1 IS
	
	generic(	n	:	integer	:= 8);
	
	port(
		a, b	:	in		std_logic_vector(n-1 downto 0);
		sel	:	in		std_logic;
		f		:	out	std_logic_vector(n-1 downto 0)	
	);

END ENTITY mux_2x1;

--Área da arquitetura, onde implementamos a lógica do circuito
ARCHITECTURE behavioral OF mux_2x1 IS
BEGIN

	process(sel, a, b)
	begin
		if sel = '0' then
			f <= a;
		elsif sel = '1' then
			f <= b;
		end if;
	end process;

END ARCHITECTURE behavioral;