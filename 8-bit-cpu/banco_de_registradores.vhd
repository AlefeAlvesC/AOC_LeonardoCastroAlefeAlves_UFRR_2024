-- Banco de registradores
--Área de importe de bibliotecas
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--Área da entidade, onde definimos as principais entradas e saidas do circuito
ENTITY banco_de_registradores IS
    
    generic( 
        N	:	integer	:= 8;--Tamanho dos dados no banco de registradores
        E	:	integer	:= 2 --Qtde de palavra no banco de registradores
    );

    PORT(
        CLOCK,REG_WRITE   : IN STD_LOGIC;
        REG1_IN,REG2_IN   : IN STD_LOGIC_VECTOR(E-1 DOWNTO 0);
        WRITE_DATA        : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        REG1_OUT,REG2_OUT : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END banco_de_registradores;

--Área da arquitetura, onde definimos a lógica do circuito
ARCHITECTURE BEHAVIOR OF banco_de_registradores IS
TYPE banco_de_registradores IS ARRAY(0 TO 2**E-1) OF STD_LOGIC_VECTOR(N-1 DOWNTO 0);
SIGNAL MEM_BANCO_REG : banco_de_registradores;
BEGIN
    PROCESS(CLOCK,REG1_IN,REG2_IN,MEM_BANCO_REG)
    BEGIN
        IF RISING_EDGE(CLOCK) THEN
            IF (REG_WRITE = '1') THEN
                MEM_BANCO_REG(TO_INTEGER(UNSIGNED(REG1_IN))) <= WRITE_DATA;
            END IF;
        END IF;
        REG1_OUT <= MEM_BANCO_REG(TO_INTEGER(UNSIGNED(REG1_IN)));
        REG2_OUT <= MEM_BANCO_REG(TO_INTEGER(UNSIGNED(REG2_IN)));
    END PROCESS;
END;