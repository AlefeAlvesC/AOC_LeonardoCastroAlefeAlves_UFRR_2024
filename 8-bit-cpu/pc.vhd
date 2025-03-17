--Sintese do registrador paralelo program-counter
--Área de importe das bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

--Área da entidade, onde definimos as principais portas de entrada e saída do circuito
ENTITY pc IS
	
	generic(n	:	integer	:=	8);--Quantidade de bits do registrador
	
	port(
		data		:	in		std_logic_vector(n-1 downto 0);
		clk, rst	:	in		std_logic;
		q			:	out	    std_logic_vector(n-1 downto 0)
	);

END ENTITY pc;

--Área da arquitetura, onde definimos a lógica do circuito
ARCHITECTURE behavioral OF pc IS
BEGIN
	
	process(clk, rst, data)
	begin
		if rst = '0' then
			q <= (others => '0');
		elsif rising_edge(clk) then
			q <= data;
		end if;
	end process;
	
END ARCHITECTURE behavioral;
