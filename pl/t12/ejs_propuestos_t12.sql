--Ejercicios propuestos del tema 12

--poner siempre antes de todos los ejercicios
SET SERVEROUTPUT ON;
SET VERIFY OFF;

/*1-Construye un bloque PL/SQL que escriba el texto HOLA.*/

set serveroutput on; --necesario para que se muestre por pantalla

BEGIN
	dbms_output.put_line('Hola');
end;
/

/*2 Construye un bloque PL/SQL para contar el numero de filas que hay en la tabla EMPLE depositar el resultado en la
variable v_num y visualizar el resultado.*/

DECLARE
v_num number;
BEGIN
	select count(*) into v_num from emple;
	dbms_output.put_line('num_filas = '||v_num);
	end;
/

/*3 Construye un bloque PL/SQL para visualizar el apellido y el oficio del empleado 7900.*/

DECLARE
	ape varchar(30);
	ofi varchar(30);
begin 
	select apellido, oficio into
	ape, ofi from emple where emp_no = 7900;
	dbms_output.put_line('Apellido ' || ape || ' es ' ||ofi);
end;
/

/*4 Construye un bloque PL/SQL que muestre el precio de costo del articulo Canutillos de categoría Primera. */

declare 
	v_costo number;
begin
	SELECT precio_costo into v_costo from articulos
	where articulo='Canutillos' and categoria='Primera';
	dbms_output.put_line('Precio de costo = ' || v_costo);
END;
/


/*5 Realizar un programa que solicite la introducción de un número de empleado y visualizara el nombre correspondiente al número introducido.
Para declarar el nombre del empleado utilizaremos la variable %TYPE. */

DECLARE 
	v_apellido emple.apellido%type;
	--ejemplo de usar el tipo de una variable ya definido en la tabla.
BEGIN
	SELECT apellido into v_apellido FROM emple
	WHERE emp_no = &vn_cli;
	DBMS_OUTPUT.PUT_LINE('NOMBRE = ' || v_apellido);
END;
/

/*6 Escribir un bloque PL/SQL que muestre la fecha actual y la hora con minutos y segundos. */

DECLARE
	v_fecha varchar(60);
BEGIN
	SELECT TO_CHAR(sysdate, 'day dd month yyyy hh24:mi:ss') INTO v_fecha FROM DUAL;
	dbms_output.put_line(v_fecha);
END;
/

/*7- Modificar el salario de un empleado especificado en función del número de empleados que tiene a su cargo:
	- Si no tiene ningún empleado a su cargo la subida será de 50€.
	- Si tiene un empleado la subida será de 80€.
	- Si tiene dos la subida será de 100€.
	- Si tiene mas de tres la subida será de 110€.
Además si el empleado es PRESIDENTE se incrementara en 30€.
Resolverlo con IF….ELSE y con CASE.	
Introduzca un valor para vt_empno: 7839
*/

DECLARE
	x_emple number;
	vc_emple number;
	v_aumento number DEFAULT 0;
	v_oficio emple.oficio%type;
BEGIN
	x_emple:=&e_empno;
	select oficio into v_oficio from emple where emp_no=vc_emple;
	SELECT COUNT(*) INTO VC_EMPLE FROM EMPLE WHERE DIR = x_emple;
	IF VC_EMPLE = 0 THEN
		V_AUMENTO:=V_AUMENTO+50;
	ELSIF VC_EMPLE=1 THEN
		V_AUMENTO:=V_AUMENTO+80;
	ELSIF VC_EMPLE>2 THEN
		V_AUMENTO:=V_AUMENTO+100;
	ELSIF VC_EMPLE>3 THEN
		V_AUMENTO:=V_AUMENTO+110;
	END IF;
	IF V_OFICIO = 'PRESIDENTE' THEN
		V_AUMENTO:=AUMENTO+30;
	END IF;
	UPDATE EMPLE SET SALARIO = SALARIO + V_AUMENTO WHERE EMP_NO = x_EMPLE;
	DBMS_OUTPUT.PUT_LINE(V_AUMENTO);
END;
/


--EJEMPLO CON CASE
DECLARE
	x_emple number;
	vc_emple number;
	v_aumento number DEFAULT 0;
	v_oficio emple.oficio%type;
BEGIN 
	
END;
/


/*8- Construir un bloque PL/SQL para que escriba la cadena HOLA al revés.
Utilizando FOR, WHILE y LOOP.*/

--Solución con FOR
DECLARE
	r_cadena varchar2(10);
BEGIN
	for i in reverse 1..length('HOLA') LOOP
		r_cadena:= r_cadena|| SUBSTR('HOLA',i,1);
	end loop;
	dbms_output.put_line(r_cadena);
END;
/


--Solución con WHILE

DECLARE
	r_cadena varchar(10); 
BEGIN
	i:= 0;
	WHILE (i< LENGTH('HOLA')) LOOP
	r_cadena:= r_cadena||SUBSTR('HOLA',i);
	end loop;
	dbms_output.put_line(r_cadena);
END;
/



/*9 Escribir un bloque PL/SQL que introduzca dos números y los sume.
Introduzca un valor para v_num1: 20
Introduzca un valor para v_num2: 20
SUMA=40 */

--versión con bloques anónimos

DECLARE
	num1 number;
	num2 number;
	resul number;
BEGIN
	num1:=&v_num1;
	num2:=&v_num2;
	resultado:= num1 + num2;
	DBMS_OUTPUT.PUT_LINE("Resultado de la suma: "|| resultado);
END;
/

--hecho con procedimientos

CREATE OR REPLACE PROCEDURE SUMANDO(NUM1 NUMBER, NUM2 NUMBER)
IS
	RESUL NUMBER(5)
BEGIN
	RESUL:=NUM1 + NUM2;
	DBMS_OUTPUT.PUT_LINE('RESULTADO = '||RESUL);
END;
/

EXECUTE SUMANDO(24,42);