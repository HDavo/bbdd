-- 1.	A partir de la tabla EMPLE, visualizar cuantos apellidos de los empleados empiezan por la letra A’.

select count(apellido) from emple where apellido like 'A%';

--2.	Dada la tabla EMPLE, obtener el sueldo medio, el número de comisiones no nulas, el máximo sueldo y el mínimo sueldo de los empleados del departamento 30. Emplear el formato adecuado para la salida para las cantidades numéricas.

select avg(salario) "sueldo medio", count(comision) "Comisiones", max(salario) "Salario alto", min(salario) "salario bajo" from emple where dept_no=30;

select to_char(avg(salario),'999G999D99') "Salario Medio", COUNT(Comision) "Com no nulas", to_char(max(salario),'999G999D99') "Salario máximo", TO_CHAR(min(salario),'999G999D99') "Salario mínimo" from emple where dept_no=30;

--3.	Contar las filas de LIBRERIA cuyo tema tenga, por lo menos, una ‘a’.

select count(tema), tema from libreria where tema like '%A%';

select tema from libreria where ejemplares = (select max(ejemplares) from libreria where tema like '%A%');

--4.	Visualizar el tema con mayor número de ejemplares de la tabla LIBRERIA y que tengan, al menos, una ‘e’ (pueden ser un tema o varios).

SELECT tema from libreria where ejemplares in (select max(ejemplares) from libreria) and tema like '%E%';
--tanto = como in dan el mismo resultado en este caso.
SELECT tema from libreria where ejemplares = (select max(ejemplares) from libreria) and tema like '%E%';

--5.	Visualizar el número de estantes diferentes que hay en la tabla LIBRERIA.

select count(DISTINCT estante) "Estantes diferentes" from libreria;

--6.	Visualizar el número de estantes distintos que hay en la tabla LIBRERIA de aquellos temas que contienen, al menos, una ‘e’.
select count(DISTINCT estante) "estantes diferentes" from libreria where  tema in (select tema from libreria where tema like '%E%');

--7.	A partir de la tabla LIBROS, realizar una sentencia SELECT para que aparezcan los títulos ordenados por su número de caracteres.

select titulo from libros order by LENGTH(titulo);

select titulo, LENGTH(titulo) "Nº caracteres" from libros order by LENGTH(titulo) DESC;

--8.	Dada la tabla NACIMIENTOS, realizar  una sentencia SELECT que obtenga la siguiente salida:
-- NOMBRE		FECHANAC
-- Pedro			12/05/82  Nació el    12   de mayo  de 1982

select nombre, fechanac, TO_CHAR(fechanac,'"Nació el" dd "de" MONTH "de" yyyy') "Nacimientos" from nacimientos;

--9.	Convertir la cadena ‘01051998’ a fecha y visualizar su nombre de mes en mayúsculas.

--select TO_CHAR(TO_DATE('01051998','DDMMYY')), TO_CHAR(TO_DATE('05','MONTH')) from dual;

SELECT TO_CHAR(TO_DATE('01051998','DDMMYY'),'MONTH') from dual;

-- 10.	A partir de la tabla EMPLE, obtener el apellido de los empleados que lleven más de 24 años trabajando revisar fechas.

select apellido from emple where MONTHS_BETWEEN(SYSDATE, fecha_alt)/12>25;

-- 11.	Seleccionar el apellido de los empleados de la tabla EMPLE que lleven más de 24 años trabajando en el departamento ‘VENTAS’ revisar fechas

select apellido from emple, depart where MONTHS_BETWEEN(SYSDATE, fecha_alt)/12 > 25 and (emple.dept_no = depart.dept_no) and depart.dnombre = 'VENTAS';