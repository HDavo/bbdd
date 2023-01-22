--Poner siempre antes de iniciar la carga de scripts
set serveroutput on;
set verify off;


/* 1.	Obtener la longitud de la circunferencia introduciendo el radio por teclado cuyo valor es en cm y el resultado lo queremos en metros. */

CREATE OR REPLACE PROCEDURE LONGITUD(RADIO NUMBER)
IS
	RESULTADO NUMBER(9.2);
	OTRO NUMBER DEFAULT 2;
	COSA NUMBER DEFAULT 3.14;
BEGIN
	RESULTADO:= (OTRO * COSA * RADIO)/100;
	DBMS_OUTPUT.PUT_LINE('La longitud en metros es: '|| RESULTADO);
END;
/

EXECUTE(45);

--BLOQUES


/* 2.	Obtener el salario del empleado 7839 de la tabla EMPLE. */

CREATE OR REPLACE PROCEDURE OBTENER_SALARIO(X_EMPLE NUMBER)
IS
	V_SALARIO EMPLE.SALARIO%TYPE;
BEGIN
	SELECT SALARIO INTO V_SALARIO FROM EMPLE WHERE EMP_NO = X_EMPLE;
	DBMS_OUTPUT.PUT_LINE('El salario correspondiente al número de empleado introducido es '||V_SALARIO);
END;
/
EXECUTE OBTENER_SALARIO(7839);

--BLOQUES

/* 3.	Mostrar el nombre de la asignatura con código 7 de la tabla ASIGNATURAS. */

CREATE OR REPLACE PROCEDURE SACAR_ASIGNATURA(NUM NUMBER)
IS
	V_ASIGNATURA ASIGNATURAS.NOMBRE%TYPE;
BEGIN
	SELECT NOMBRE INTO V_ASIGNATURA FROM ASIGNATURAS WHERE COD = NUM;
	DBMS_OUTPUT.PUT_LINE('La asignatura correspondiente al código introducido es: '||V_ASIGNATURA);
END;
/
EXECUTE(7);

--BLOQUES


/* 4.	Visualizar el nombre de la tabla PROFESORES, introduciendo el DNI por teclado a través de una variable de sustitución. */

CREATE OR REPLACE PROCEDURE SACAR_PROFESORES(X_DNI NUMBER)
IS
	V_NOMBRE PROFESORES.APELLIDOS%TYPE;
BEGIN
	SELECT APELLIDOS INTO V_NOMBRE FROM PROFESORES WHERE DNI = X_DNI;
	DBMS_OUTPUT.PUT_LINE('El DNI'||X_DNI||' corresponde a '||V_NOMBRE);
END;
/

--BLOQUES


/* 5.	A través de variables visualice el departamento VENTAS de la tabla DEPART con el siguiente mensaje ‘El departamento nº X esta en XXX’. */


/* 6.	Insertar en la tabla EMPLE un empleado con código 9999 asignado directamente en la variable,
apellido ‘PEREZ’, oficio ‘ANALISTA’ y código del departamento al que pertenece 10.*/

/* 7.	Incrementar el salario en la tabla EMPLE en 200€ a todos los trabajadores que sean ‘ANALISTAS’, mediante un bloque anónimo PL, asignando dicho valor a una variable declarada%TYPE.
 */

/* 8.	Borrar un registro de la tabla EMPLE, existiendo en el bloque una variable PL y otra de sustitución.
 */

/* 9.	Suprimir de la tabla ASIGNATURAS aquellos que tengan un código mayor a cinco utilizando los atributos del cursor SQL%ROWCOUNT. Que muestre cuantas filas ha borrado. 
 */
/* 10.	Obtener un bloque PL que introduciendo el código de un trabajador de la tabla EMPLE, visualizar el código y su salario para posteriormente actualizarlo en función de su sueldo. Si su sueldo es mayor de 1200 € su incremento será del 20% y su es menor del 25%. Visualizar su sueldo actualizado.
 */
/* 11.	Introduciendo un número por teclado, correspondiente al dorsal de un futbolista, dar como salida el puesto en el que juega dicho jugador. Utilizar la estructura de control más adecuada.
 */
/* 12.	Dados dos números introducidos por teclado, obtener cuál de los dos es mayor.
 */
 
CREATE OR REPLACE COMPARADOR(COSA1 NUMBER, COSA2 NUMBER)
IS
BEGIN
	
END;
/
/* 13.	Realizar un programa que devuelva el número de cifras de un número entero, introducido por teclado, mediante una variable de sustitución.
 */
 
 CREATE OR REPLACE PROCEDURE CONTADOR(COSA VARCHAR)
 IS
	V_CONTADOR NUMBER;
 BEGIN
	V_CONTADOR:=1..LENGTH(COSA);
	DBMS_OUTPUT.PUT_LINE('El número de cifras del número introducido es de: '||V_CONTADOR);
 END;
 /
 
 
DECLARE
	
 
 
/* 14.	Dado un número introducido por teclado, visualizar por pantalla todos los números iguales o inferiores a él. Este programa se efectuará por todos los tipos de estructuras repetitivas.
 */
 
CREATE OR REPLACE PROCEDURE NUMEROS(COSA NUMBER)
IS
	V_CADENA 
BEGIN
END;
/
/* 15.	Introduciendo un año por teclado, decir si este es bisiesto o no.
 */
 
 CREATE OR REPLACE PROCEDURE ES_BISIESTO(X NUMBER)
 IS
 BEGIN
	IF((X MOD 4=0 AND X MOD 100!=0) OR (X MOD 400 = 0))
	THEN DBMS_OUTPUT.PUT_LINE('ES BISIESTO');
	ELSE DBMS_OUTPUT.PUT_LINE('NO ES BISIESTO');
	END IF;
 END;
 /
 
 EXECUTE ES_BISIESTO(2204);
 EXECUTE ES_BISIESTO(100);