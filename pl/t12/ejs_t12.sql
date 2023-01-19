--Ejercicios del tema 12

--1

set serveroutput on;
--necesario para que se muestre por pantalla

BEGIN
	dbms_output.put_line('Hola');
end;
/

--2
DECLARE
v_num number;
BEGIN
	select count(*) into v_num from emple;
	dbms_output.put_line('num_filas = '||v_num);
	end;
/

--3

DECLARE
	ape varchar(30);
	ofi varchar(30);
begin 
	select apellido, oficio into
	ape, ofi from emple where emp_no = 7900;
	dbms_output.put_line('Apellido ' || ape || ' es ' ||ofi);
end;
/

--4 Construye un bloque PL/SQL que muestre el precio de costo del articulo Canutillos de categoría Primera.

declare 
	v_costo number;
begin
	SELECT precio_costo into v_costo from articulos where articulo='Canutillos' and categoria='Primera';
	dbms_output.put_line('Precio de costo = ' || v_costo);
END;
/


--5 Realizar un programa que solicite la introducción de un número de empleado y visualizara el nombre correspondiente al número introducido. Para declarar el nombre del empleado utilizaremos la variable %TYPE.



--6 Escribir un bloque PL/SQL que muestre la fecha actual y la hora con minutos y segundos.



--9 Escribir un bloque PL/SQL que introduzca dos números y los sume.
-- Introduzca un valor para v_num1: 20
-- Introduzca un valor para v_num2: 20
-- SUMA=40

--hecho con procedimientos



