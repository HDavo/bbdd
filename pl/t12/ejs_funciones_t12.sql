--15 Crear una función que sume dos números.

CREATE OR REPLACE FUNCTION FUNCION_SUMAR(COSA1 NUMBER, COSA2 NUMBER)
IS
	COSA_RESULTADO NUMBER;
BEGIN
	COSA_RESULTADO := COSA1 + COSA2;
	RETURN(COSA_RESULTADO);
	-- DBMS_OUTPUT.PUT_LINE(COSA_RESULTADO);
END;
/


--16 Crear una función que visualice una cadena al revés.

/* 17 Escribe una función que reciba una fecha y devuelva el año, en número, correspondiente a esa fecha. */


/* 18-Escribir una función que devuelva el valor con IVA de una cantidad que se pasara como primer parámetro. La función podrá recoger un segundo parámetro, que será el tipo de IVA siendo el valor por defecto 16. /*

/* 19- Utilizar la función anterior para obtener el salario de
los empleados con el iva de la función. */
