SET VERIFY OFF;
SET SERVEROUTPUT ON;
/*1-	Introducir un valor por teclado, crear una excepción si el valor es negativo. Visualizar tanto si el valor es positivo como el de la excepción.
*/

DECLARE
	VALOR_NEGATIVO EXCEPTION; --creación de la excepción
	VALOR NUMBER;
BEGIN
	VALOR:=&ERT;
	IF VALOR < 0 THEN
		RAISE VALOR_NEGATIVO; --levantamiento de la excepción
	ELSE
		DBMS_OUTPUT.PUT_LINE('El valor es positivo');
	END IF;
	EXCEPTION
		WHEN VALOR_NEGATIVO THEN
		DBMS_OUTPUT.PUT_LINE('Valor no válido, no puede ser negativo');
END;
/

/*
2-	Escribir un procedimiento que reciba un número de empleado y una cantidad que incrementara el salario del empleado correspondiente. Utilizar dos excepciones, una definida por el usuario salario_nulo y la otra predefinida NO_DATA_FOUND si no encuentra el nº de empleado.  Mirar en las tablas si hay salarios nulos, si no hay insertar un nuevo empleado con salario nulo.
*/
--NECESARIO HACER UN INSERT PREVIO CON SALARIO NULO
INSERT INTO EMPLE VALUES (8888,'VACIO','VIGILANTE',NULL,'12/06/12',NULL,NULL,20);


CREATE OR REPLACE PROCEDURE DAR_AUMENTO(pepe number, dinero NUMBER)
IS
	NO_VALIDO EXCEPTION;
	X_SALARIO EMPLE.SALARIO%TYPE;
BEGIN
	SELECT SALARIO INTO X_SALARIO FROM EMPLE WHERE EMP_NO= PEPE;
	IF X_SALARIO IS NULL THEN
		RAISE NO_VALIDO;
	ELSE
		X_SALARIO:=X_SALARIO + DINERO;
		UPDATE EMPLE SET SALARIO=X_SALARIO WHERE EMP_NO = PEPE;
		DBMS_OUTPUT.PUT_LINE('Empleado: '|| pepe||' Salario: '|| x_salario);
	END IF;
	EXCEPTION --el orden de las excepciones da igual
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('No existe el empleado: '||pepe);
		WHEN NO_VALIDO THEN
			DBMS_OUTPUT.PUT_LINE(pepe||' no tiene un salario válido');
END;
/

EXECUTE DAR_AUMENTO(7839,500); --prueba sin nulos, con empleado ya existente

EXECUTE DAR_AUMENTO(8888,4000);

/*
3-	 Escribir un procedimiento que reciba los datos de un nuevo empleado. El procedimiento deberá controlar los siguientes errores:
- No existe departamento.  NO DATA FOUND
- No existe director. Crear la excepción. --NECESITA UNA EXCEPCIÓN PROPIA
- Numero de empleado duplicado. Crear una clave primaria para EMP_NO ALTERANDO LA TABLA.
*/

--NECESARIO HACER UN ALTER TABLE PREVIO

ALTER TABLE EMPLE ADD CONSTRAINT NPK_EMPLE PRIMARY KEY(EMP_NO);

CREATE OR REPLACE PROCEDURE EXCEPCIONES_NUEVO(V_EMP_NO NUMBER, V_APELLIDO VARCHAR2,V_OFICIO VARCHAR2,V_DIR NUMBER, V_FECHA DATE,V_SALARIO NUMBER, V_COMISION NUMBER, V_DEPT_NO NUMBER)
IS
	NO_DIRECTOR EXCEPTION;
	V_DEP DEPART.DEPT_NO%TYPE;
BEGIN
	SELECT DEPT_NO INTO V_DEP FROM DEPART WHERE DEPT_NO = V_DEPT_NO;
	INSERT INTO EMPLE VALUES (V_EMP_NO,V_APELLIDO,V_OFICIO,V_DIR,V_FECHA,V_SALARIO,V_COMISION,V_DEPT_NO);
	IF V_DIR IS NULL THEN 
		RAISE NO_DIRECTOR;
	END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN 
			DBMS_OUTPUT.PUT_LINE('Error, no existe el departamento');
		WHEN NO_DIRECTOR THEN 
			DBMS_OUTPUT.PUT_LINE('No tiene director');
		WHEN DUP_VAL_ON_INDEX THEN
			DBMS_OUTPUT.PUT_LINE('EMPLEADO DUPLICADO');
END;
/


EXECUTE EXCEPCIONES_NUEVO(003,'LOPEZ','ANALISTA',NULL,SYSDATE,1800,NULL,25);

EXECUTE EXCEPCIONES_NUEVO(009,'PEREZ','ANALISTA',7556,SYSDATE,1500,NULL,10);

EXECUTE EXCEPCIONES_NUEVO(005,'LOPEZ','ANALISTA',7556,SYSDATE,2800,NULL,10);
/*
4-	 Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
Se pasará al procedimiento el nº del departamento, nombre del departamento y la localidad.
El procedimiento insertará la fila nueva. 
Se incluirá la gestión del error que no se duplique el nº del dep. y el nombre del departamento.
*/




/*
5-	Crear una excepción mediante RAISE_APPLICATION_ERROR que no se puede dividir por 0. 
*/

--VERSION CON EXCEPCIÓN NORMAL
DECLARE
	NO_DIVISIBLE EXCEPTION;
	ARRIBA NUMBER;
	DEBAJO NUMBER;
	RESULTADO NUMBER;
BEGIN
	ARRIBA:=&COSA1;
	DEBAJO:=&COSA2;
	IF DEBAJO = 0 THEN
		RAISE NO_DIVISIBLE;
	ELSE 
		RESULTADO:=ARRIBA/DEBAJO;
		DBMS_OUTPUT.PUT_LINE('El resultado de la división es: '||resultado);
	END IF;
	EXCEPTION
		WHEN NO_DIVISIBLE THEN
			DBMS_OUTPUT.PUT_LINE('No se puede dividir entre 0');
END;
/

--VERSIÓN CON RAISE_APPLICATION_ERROR

DECLARE 
	ARRIBA NUMBER;
	DEBAJO NUMBER;
	RESULTADO NUMBER;
BEGIN
	ARRIBA:='&COSA1';
	DEBAJO:='&COSA2';
	IF DEBAJO = 0 THEN 
		RAISE_APPLICATION_ERROR(-20001, 'No se puede dividir entre 0, introduce otro número.');
	ELSE 
		RESULTADO:=ARRIBA/DEBAJO;
		DBMS_OUTPUT.PUT_LINE('El resultado es: '||RESULTADO);
	END IF;
END;
/