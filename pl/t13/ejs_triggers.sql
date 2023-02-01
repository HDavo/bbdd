SET VERIFY OFF;
SET SERVEROUTPUT ON;

/* 1-	Crear el trigger auditar_subida_salario, que se disparará después de cada modificación de la columna salario de la tabla EMPLE.
Se creará primero la tabla auditar_emple con col1 varchar2(200). Donde se insertará el literal “subida salario empleado” y el número del empleado.
*/

DROP TABLE AUDITAR_EMPLE;

CREATE TABLE AUDITAR_EMPLE(
	COL1 VARCHAR2(200)
);

CREATE OR REPLACE TRIGGER AUDITAR_SUBIDA_SALARIO
	AFTER UPDATE OF SALARIO ON EMPLE FOR EACH ROW
BEGIN
	INSERT INTO AUDITAR_EMPLE VALUES('SUBIDA SALARIO EMPLEADO: '||:NEW.EMP_NO);
END;
/

UPDATE EMPLE SET SALARIO = SALARIO +300 WHERE EMP_NO = 7839;

UPDATE EMPLE SET SALARIO = SALARIO + 200;

--el cuerpo del trigger siempre va a ser un insert a la tabla creada.

/*
2-	Crear un trigger que se disparará cada vez que se borre un empleado, guardando el literal “borrado empleado”,  su número de empleado, apellido y el departamento en una fila de la tabla AUDITAR_EMPLE.
*/

CREATE OR REPLACE TRIGGER BORRADO_EMPLEADO
	-- AFTER DELETE ON EMPLE FOR EACH ROW
	BEFORE DELETE on emple for EACH ROW
BEGIN
	INSERT INTO AUDITAR_EMPLE VALUES('Borrado empleado: '||:OLD.EMP_NO||' '||:OLD.APELLIDO||' '||:OLD.DEPT_NO);
END;
/

DELETE FROM EMPLE WHERE APELLIDO='VACIO';
SELECT * FROM AUDITAR_EMPLE;

/*
3-	Incluir una restricción en el ejercicio anterior para que se ejecute el disparador cuando el empleado borrado sea PRESIDENTE.
*/

INSERT INTO EMPLE VALUES (8888,'VACIO','PRESIDENTE',NULL,'12/06/12',NULL,NULL,40);

CREATE OR REPLACE TRIGGER BORRADO_EMPLEADO_PRE
	-- AFTER DELETE ON EMPLE FOR EACH ROW WHEN(OLD.OFICIO='PRESIDENTE')
	BEFORE DELETE
	ON EMPLE
	FOR EACH ROW WHEN (OLD.OFICIO='PRESIDENTE')
BEGIN
	INSERT INTO AUDITAR_EMPLE VALUES('Borrado empleado: '||:OLD.EMP_NO||' '||:OLD.APELLIDO||' '||:OLD.DEPT_NO);
END;
/

DELETE FROM EMPLE WHERE OFICIO = 'PRESIDENTE' AND APELLIDO ='VACIO';

/*
4-	Escribe un disparador que permite auditar las operaciones de inserción o borrado de datos que se realicen en la tabla EMPLE según las siguientes especificaciones:
-	Se creará la tabla auditar_emple con col1 varchar2(200).
-	Cuando se produzca cualquier manipulación, se insertara un fila en la tabla creada que contendrá: fecha y hora, nºempleado, apellido y la palabra INSERCIÓN O BORRADO según la actualización.
Utilizar el formato múltiples eventos.
*/

CREATE OR REPLACE TRIGGER MODIFICAR_EMPLE
	BEFORE INSERT OR DELETE ON EMPLE FOR EACH ROW 
BEGIN
	IF INSERTING THEN
		INSERT INTO AUDITAR_EMPLE VALUES(TO_CHAR(SYSDATE,'DD/MM/YY HH24:MI')|| 'NUMERO EMPLEADO: '|| :NEW.EMP_NO||' APELLIDO: ' || :NEW.APELLIDO|| 'NUMERO DEPARTAMENTO: '|| :NEW.DEPT_NO||'INSERTADO');
	ELSIF DELETING THEN
		INSERT INTO AUDITAR_EMPLE VALUES(TO_CHAR(SYSDATE,'DD/MM/YY HH24:MI')|| 'NUMERO EMPLEADO: '|| :OLD.EMP_NO||' APELLIDO: ' || :OLD.APELLIDO|| 'NUMERO DEPARTAMENTO: '|| :OLD.DEPT_NO||'BORRADO');
	END IF;
END;
/


--NO ENTRA ESTE TIPO DE EJERCICIO
/*
5-	Escribir un disparador que controle las conexiones de los usuarios en la base de datos. Par ello crearemos la siguiente tabla:
*/

CREATE TABLE CONTROL_CONEXIONES (
USUARIO VARCHAR2(20),
MOMENTO TIMESTAMP,
EVENTO VARCHAR2(20));

CREATE OR REPLACE TRIGGER CTL_CONX
AFTER LOGON 
ON DATABASE
BEGIN
INSERT INTO CONTROL_CONEXIONES (USUARIO, MOMENTO, EVENTO)
VALUES (ORA_LOGIN_USER, SYSTIMESTAMP, ORA_SYSEVENT);
END;
/
CONNECT SYSTEM // CONNECT SCOTT // CERRAR SQL

SELECT * FROM CONTROL_CONEXIONES;
USUARIO      MOMENTO                             EVENTO
SYSMAN      24/02/07 23:25:07,682000         LOGON