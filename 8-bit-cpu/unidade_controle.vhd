--Projeto de uma unidade de controle
--Área de importe de bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

--Área da entidade, onde definimos as principais entradas e saidas do circuito
ENTITY unidade_controle IS
	
	port(
		opCode	:	in	std_logic_vector(2 downto 0);
		Jump	:	out	std_logic;
		Branch	:	out	std_logic;
		MemRead	:	out	std_logic;
		MemtoReg:	out	std_logic;
		ALUOp	:	out	std_logic;
		MemWrite:	out	std_logic;
		ALUSrc	:	out	std_logic;
		RegWrite:	out	std_logic
	);
	
END ENTITY unidade_controle;

--Área da arquitetura, onde definimos a lógica do circuito
ARCHITECTURE behavioral OF unidade_controle IS
BEGIN
	
	enviar_sinais: process(opCode)
	begin
	
		case opCode is
			--ADD
			when "000" => 
				Jump 		<= '0';
				Branch	    <=	'0';
				MemRead	    <=	'0';
				MemtoReg	<=	'0';
				ALUOp		<=	'0';
				MemWrite	<=	'0';
				ALUSrc	    <=	'0';
				RegWrite	<=	'1';
			--SUB
			when "001" => 
				Jump 		<= '0';
				Branch	    <=	'0';
				MemRead	    <=	'0';
				MemtoReg	<=	'0';
				ALUOp		<=	'1';
				MemWrite	<=	'0';
				ALUSrc	    <=	'0';
				RegWrite	<=	'1';
			--LW
			when "010" => 
				Jump 		<= '0';
				Branch	    <=	'0';
				MemRead 	<=	'1';
				MemtoReg	<=	'1';
				ALUOp		<=	'0';
				MemWrite	<=	'0';
				ALUSrc	    <=	'1';
				RegWrite	<=	'1';
			--SW
			when "011" => 
				Jump 		<= '0';
				Branch	    <=	'0';
				MemRead	    <=	'0';
				MemtoReg	<=	'0';
				ALUOp		<=	'0';
				MemWrite	<=	'1';
				ALUSrc	    <=	'1';
				RegWrite	<=	'0';
			--BEQ
			when "100" => 
				Jump 		<= '0';
				Branch	    <=	'1';
				MemRead	    <=	'0';
				MemtoReg	<=	'0';
				ALUOp		<=	'1';
				MemWrite	<=	'0';
				ALUSrc	    <=	'0';
				RegWrite	<=	'0';
			--JUMP
			when "101" => 
				Jump 		<= '1';
				Branch	    <=	'0';
				MemRead	    <=	'0';
				MemtoReg	<=	'0';
				ALUOp		<=	'0';
				MemWrite	<=	'0';
				ALUSrc	    <=	'0';
				RegWrite	<=	'0';
			--outros
			when others => 
				Jump 		<= '0';
				Branch	    <=	'0';
				MemRead	    <=	'0';
				MemtoReg	<=	'0';
				ALUOp		<=	'0';
				MemWrite	<=	'0';
				ALUSrc	    <=	'0';
				RegWrite	<=	'0';	
		
		end case;
	
	end process enviar_sinais;
	
	
END ARCHITECTURE behavioral;