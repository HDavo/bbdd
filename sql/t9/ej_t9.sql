--ejercicios de redondeo

--ejercicio 8
select round (1.5634) from dual;
--sin decimales

select round (1.5634,1) from dual; 
--con un solo decimal

--ejercicio 9

select round (1.2324)  from dual;
--sin decimales

select round (1.2324,2) from dual; 
--con dos decimales


--ejercicio 10. Redondear 145.5 un lugar a la izq. de la coma, dos y tres.

select round(145.5,-1) from dual;

select round(145.5,-2) from dual;

select round(145.5,-3) from dual;

--ejercicios de truncar

--ejercicio 13. Truncar  el número 1.5634 a un decimal, 2 y cero.

select TRUNC(1.5634,1) from dual;
select trunc(1.5634,2) from dual;
select trunc(1.5634,0) from dual;

--ejercicio 14. Truncar el número 187.98 a la izquierda de la coma a 1 posición, 2 y 3.

select trunc(187.98,-1) from dual;
select trunc(187.98,-2) from dual;
select trunc(187.98,-3) from dual;

--ejercicios de fechas

--1 Obtener la fecha del sistema

select sysdate from dual;

--2 Dada la tabla EMPLE, sumar y restar dos meses a la fecha de alta. Mostrar las tres fecha cada una con una cabecera especificada por tí.

select fecha_alt, ADD_MONTHS(fecha_alt, 2) from emple; 

select fecha_alt, ADD_MONTHS(fecha_alt,-2) from emple;

--con cabecera
select fecha_alt "alta original", ADD_MONTHS(fecha_alt,2) "Suma 2", ADD_MONTHS(fecha_alt,2) "resta 2" from emple;

-- 3 Obtener en la tabla EMPLE el último día del mes para cada mes de las fechas de alta.

select fecha_alt,LAST_DAY(fecha_alt) from emple;

-- 4 Obtener nuestra edad utilizando las diferentes funciones de fecha.

select trunc(MONTHS_BETWEEN(sysdate, '12/03/2011')/12) "Edad de Tito" from dual;
--se pone el /12 para obtener los años como número entero

-- 5 Si hoy es jueves 22 de Enero de 2020(fecha del sistema) ¿qué fecha será el próximo jueves?
select NEXT_DAY(sysdate, 'lunes') "Dentro de 7 días" from dual;


--Funciones de conversión

--1	Mostrar a partir de la tabla emple la fecha de alta con el siguiente formato: Nombre del mes con todas sus letras, el número del día del mes con dos caracteres y el año con cuatro dígitos.
--Antes de darle formato: 

select fecha_alt, to_char(fecha_alt,'MONTH dd yyyy') from emple;

--2 Mostrar la fecha de alta con la abreviatura del mes, número del día del año, último dígito del año y los tres últimos dígitos del año.

select fecha_alt, TO_CHAR(fecha_alt,'MON Ddd y yyy') from emple;

-- 3 Mostrar la fecha de hoy con el siguiente formato: hoy es , miércoles 10 de febrero de 2021.

select to_char(sysdate, '"Hoy es " day "," dd "de" month "de" yyyy') "Fecha" from dual;

