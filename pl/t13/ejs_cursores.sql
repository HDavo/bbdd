SET VERIFY OFF;
SET SERVEROUTPUT ON;

/* 1-	Escribir un bloque PL que utilice un cursor explicito para visualizar el nombre y la localidad de todos los departamentos.
*/


DECLARE
	V_NOMBRE VARCHAR(56);
	V_LOCALIDAD VARCHAR(55);
	CURSOR PEPE IS SELECT DNOMBRE, LOC INTO V_NOMBRE, V_LOCALIDAD FROM DEPART;
BEGIN
	OPEN PEPE;
	LOOP
		FETCH PEPE INTO V_NOMBRE, V_LOCALIDAD;
		EXIT WHEN PEPE%NOTFOUND;
		--se pone asi para que no saque la última fila duplicada
		DBMS_OUTPUT.PUT_LINE(V_NOMBRE||'*'||V_LOCALIDAD);
	END LOOP;
	CLOSE PEPE;
END;
/


/* 2-	Visualizar los apellidos de los empleados pertenecientes al departamento 20 numerándolos secuencialmente. Utilizar   %ROWCOUNT los números secuenciales.
1.SANCHEZ
2.JIMENEZ
3.GIL
4.ALONSO
5.FERNANDEZ
*/

DECLARE
	APE EMPLE.APELLIDO%TYPE;
	CURSOR COSA IS SELECT APELLIDO FROM EMPLE WHERE DEPT_NO = 20;
BEGIN
	OPEN COSA;
	LOOP
		FETCH COSA INTO APE;
		EXIT WHEN COSA%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(COSA%ROWCOUNT||'.'||APE);
	END LOOP;
END;
/

/* 3- Visualizar los empleados de un departamento mediante un procedimiento y utilizando variables de acoplamiento. */

DECLARE 
	V_EMP VARCHAR(50);
	CURSOR COSA IS SELECT APELLIDO FROM EMPLE WHERE DEPT_NO = &PEPE;
BEGIN
	OPEN COSA;
	LOOP
		FETCH COSA INTO V_EMP;
		EXIT WHEN COSA%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(V_EMP);
	END LOOP;
END;
/

/* 4-	Escribir un bloque PL que visualice el apellido, el oficio y la comisión de los empleados que supere los 500€. Utilizando CURSOR FOR........LOOP. */

DECLARE
	CURSOR JUAN IS SELECT APELLIDO, OFICIO, COMISION FROM EMPLE WHERE COMISION > 500;
BEGIN
	FOR I IN JUAN LOOP
		DBMS_OUTPUT.PUT_LINE(I.APELLIDO||'  '||I.OFICIO||'  '||I.COMISION);
	END LOOP;
END;
/

/* 5-	 Escribir un bloque PL que visualice el apellido y la fecha de alta de todos los empleados ordenados por fecha de alta. Utilizando CURSOR FOR........LOOP.
*/

--VERSIÓN CON PROCEDIMIENTO

CREATE OR REPLACE PROCEDURE CURSOR_APELLIDO
IS
	CURSOR COSA IS SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY FECHA_ALT;
BEGIN
	FOR I IN COSA LOOP
		DBMS_OUTPUT.PUT_LINE(I.APELLIDO||'*'||I.FECHA_ALT);
	END LOOP;
END;
/

DECLARE 
	CURSOR COSA IS SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY FECHA_ALT;
BEGIN
	FOR I IN COSA LOOP
		DBMS_OUTPUT.PUT_LINE(I.APELLIDO||'  '||I.FECHA_ALT);
	END LOOP;
END;
/

/*
6-	Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.
*/
--con procedimiento Y LOOP

CREATE OR REPLACE PROCEDURE CURSOR_ORDENADO
IS
	CURSOR COSA IS SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY APELLIDO;
	V_APE EMPLE.APELLIDO%TYPE;
	V_FECHA EMPLE.FECHA_ALT%TYPE;
BEGIN
	OPEN COSA;
		LOOP
			FETCH COSA INTO V_APE, V_FECHA;
			EXIT WHEN COSA%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE('APELLIDO '||V_APE||' * '||'FECHA DE ALTA: '||V_FECHA);
		END LOOP;
END;
/

EXECUTE CURSOR_ORDENADO;



--con for LOOP y bloque anonimo

DECLARE
	CURSOR COSA IS SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY APELLIDO;
BEGIN
	FOR I IN COSA LOOP
		DBMS_OUTPUT.PUT_LINE(I.FECHA_ALT||'  '||I.APELLIDO);
		-- DBMS_OUTPUT.PUT_LINE(I.APELLIDO||'  '||I.FECHA_ALT);
	END LOOP;
END;
/

--con LOOP

DECLARE 
	V_APE EMPLE.APELLIDO%TYPE;
	V_FECHA EMPLE.FECHA_ALT%TYPE;
	CURSOR COSA IS SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY APELLIDO;
BEGIN
	OPEN COSA;
		LOOP
			FETCH COSA INTO V_APE, V_FECHA;
			EXIT WHEN COSA%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE('APELLIDO: '||V_APE||' FECHA DE ALTA: '|| V_FECHA);
		END LOOP;
END;
/

/*
7-	Codificar un procedimiento que muestre el nombre de cada departamento y el número de empleados que tiene.
*/


--rellenar con lo de la foto

DECLARE
	N_DEP DEPART.DNOMBRE%TYPE;
	CONTADOR NUMBER;
	CURSOR COSA IS SELECT COUNT(*), DNOMBRE FROM EMPLE E, DEPART D WHERE D.DEPT_NO = E.DEPT_NO GROUP BY DNOMBRE;
BEGIN
END:
/


/*
8-	Escribir un procedimiento que visualice el apellido y el salario de los cinco empleados que tienen el salario más alto.
REY	4100
NEGRO	3005
FERNANDEZ3000
GIL	3000
JIMENEZ	2900
CEREZO	2885
MUÑOZ	1690
SALA	1625
MARTIN	1600
ARROYO	1500
ALONSO	1430
TOVAR	1350
JIMENO	1335
SANCHEZ 1040
*/
CREATE OR REPLACE PROCEDURE IMPRESION_DOS
IS
	CURSOR COSA IS SELECT APELLIDO, SALARIO FROM EMPLE ORDER BY SALARIO DESC;
	V_EMP COSA%ROWTYPE; --ESTO NOS AHORRA TENER QUE DECLARAR OTRAS VARIABLES
	I NUMBER;
BEGIN
	I:=1;
	OPEN COSA;
		FETCH COSA INTO V_EMP;
		WHILE COSA%FOUND AND I<= 5 LOOP
			DBMS_OUTPUT.PUT_LINE('NOMBRE: '||V_EMP.APELLIDO||' SALARIO: '||EMP.SALARIO);
			FETCH COSA INTO V_EMP;
			I:= I+1;
		END LOOP;
	CLOSE COSA;
END;
/

EXECUTE IMPRESION_DOS;


/* 9-	Codificar un procedimiento que visualice los dos empleados que ganan menos de cada oficio.
FERNANDEZANALISTA	3000
GIL	ANALISTA	3000
CEREZO	DIRECTOR	2885
JIMENEZ	DIRECTOR	2900
NEGRO	DIRECTOR	3005
SANCHEZ EMPLEADO	1040
JIMENO	EMPLEADO	1335
ALONSO	EMPLEADO	1430
MUÑOZ	EMPLEADO	1690
REY	PRESIDENTE	4100
TOVAR	VENDEDOR	1350
ARROYO	VENDEDOR	1500
MARTIN	VENDEDOR	1600
SALA	VENDEDOR	1625
*/
CREATE OR REPLACE PROCEDURE IMPRESION_TRES
IS
	CURSOR COSA IS SELECT APELLIDO, OFICIO, SALARIO FROM EMPLE ORDER BY OFICIO, SALARIO;
	V_OFICIO EMPLE.OFICIO%TYPE;
	V_EMP COSA.%ROWTYPE;
	I NUMBER;
BEGIN
	V_OFICIO = ' '; --SIN ESTA VARIABLE EN CADA CAMBIO DE OFICIO SE DEBERÍA PONER EL CONTADOR A CERO
	I:=1;
	OPEN COSA;
	FETCH COSA INTO V_EMP;
	WHILE COSA%FOUND LOOP --MIRAR QUE HACE %FOUND A LA HORA DE USARLO COMO CONDICIÓN DE UN BUCLE
		IF V_EMP.OFICIO <> V_OFICIO THEN
			V_OFICIO := V_EMP.OFICIO;
			I:=1;
		END IF;
		IF I<=2 THEN 
			DBMS_OUTPUT.PUT_LINE('OFICIO'||V_EMP.OFICIO||' ,APELLIDO '||V_EMP.APELLIDO||', SALARIO '||V_EMP.SALARIO);
		END IF;
		FETCH COSA INTO V_EMP;
		I:= I +1;
	END LOOP;
	CLOSE COSA;
END;
/

EXECUTE IMPRESION_TRES;