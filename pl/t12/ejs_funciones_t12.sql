--15 Crear una función que sume dos números.

CREATE OR REPLACE FUNCTION FUNCION_SUMAR(COSA1 NUMBER, COSA2 NUMBER)
RETURN 
	NUMBER
IS
	COSA_RESULTADO NUMBER;
BEGIN
	COSA_RESULTADO := COSA1 + COSA2;
	RETURN(COSA_RESULTADO);
	-- DBMS_OUTPUT.PUT_LINE(COSA_RESULTADO);
END;
/

SELECT FUNCION_SUMAR() FROM DUAL;

--16 Crear una función que visualice una cadena al revés.

CREATE OR REPLACE FUNCTION AL_REVES(COSA VARCHAR)
RETURN 
	VARCHAR
IS
	ROBLE VARCHAR2(65);
BEGIN
	for i in reverse 1..length(COSA) LOOP
		ROBLE:= ROBLE|| SUBSTR(COSA,i,1);
	end loop;
	dbms_output.put_line(ROBLE);
	RETURN(ROBLE);
END;
/

SELECT AL_REVES('MANOLO') FROM DUAL;

/* 17 Escribe una función que reciba una fecha y devuelva el año, en número, correspondiente a esa fecha. */

CREATE OR REPLACE FUNCTION DAR_FECHA(FECHA DATE)
RETURN
	NUMBER
IS
	aanyo number;
BEGIN
	aanyo:=TO_NUMBER(TO_CHAR(FECHA, 'YYYY'));
	RETURN(aanyo);
END;
/

select DAR_FECHA('24-06-2016') FROM DUAL;

/* 18-Escribir una función que devuelva el valor con IVA de una cantidad que se pasara como primer parámetro. La función podrá recoger un segundo parámetro, que será el tipo de IVA siendo el valor por defecto 16. */

CREATE OR REPLACE FUNCTION DAME_IVA(PRECIO NUMBER, tipo number default 16)
RETURN
	NUMBER;
IS
	FINAL NUMBER;
BEGIN
	FINAL:= PRECIO*TIPO;
	-- RETURN(FINAL);
	
END;
/

SELECT DAME_IVA(500,20) FROM DUAL;

/* 19- Utilizar la función anterior para obtener el salario de
los empleados con el iva de la función. */

SELECT EMP_NO, SALARIO, DAME_IVA(SALARIO) FROM EMPLE;