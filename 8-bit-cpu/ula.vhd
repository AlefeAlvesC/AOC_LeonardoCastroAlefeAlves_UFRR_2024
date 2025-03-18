--Projeto de uma ula com operação de soma e sub
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY ula IS
	generic(n	:	integer	:= 8);
	
	port(
		a, b	:	in		std_logic_vector(n-1 downto 0);
		op		:	in 	std_logic;
		result:	out	std_logic_vector(n-1 downto 0);
		zero	:	out	std_logic
	);
	
END ENTITY ula;

ARCHITECTURE behavioral OF ula IS
	signal a_temp, b_temp:	std_logic_vector(n-1 downto 0);
	signal result_temp	:	unsigned(n-1 downto 0);
BEGIN
	
	a_temp <= a;
	b_temp <= b;
	result <= std_logic_vector(result_temp);
	
	calcula: process(a_temp, b_temp, op)
	begin
	
		if op = '0' then
			result_temp <= unsigned(a_temp) + unsigned(b_temp);
		elsif op = '1' then 
			result_temp <= unsigned(a_temp) - unsigned(b_temp);
		end if;
		
	end process calcula;
	
	process(result_temp)
	begin
	
		if result_temp = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;
		
	end process;
	
END ARCHITECTURE behavioral;