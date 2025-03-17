-- Extensor de bits de 3 para 8 bits

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY extensor_3x8 IS
	PORT(
		A : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END extensor_3x8;

ARCHITECTURE BEHAVIOR OF extensor_3x8 IS
BEGIN
	S(7) <= '0';
	S(6) <= '0';
	S(5) <= '0';
	S(4) <= '0';
	S(3) <= '0';
	S(2) <= A(2);
	S(1) <= A(1);
	S(0) <= A(0);
END BEHAVIOR;