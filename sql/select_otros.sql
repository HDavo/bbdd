--SELECTS DE UNA SOLA TABLA

-- A partir de la tabla EMPLE. Obtener aquellos apellidos que empiecen por una ‘J’

select * from emple where apellido like 'J%';

-- Obtener aquellos apellidos que tengan una R en la segunda posición

select * from emple where apellido like '_R%';

-- Obtener aquellos apellidos que empiecen por A y tengan una O en su interior.

select * from emple where apellido like 'A%O%';

-- Consultar en la tabla EMPLE los apellidos de los empleados cuya comisión es NULL

select * from emple where comision is null;

-- Consultar los apellidos de la tabla EMPLE cuyo número de departamento sea 10 ó 30:

select * from emple where dept_no in (10,30);


-- Consultar los apellidos de la tabla EMPLE cuyo número de departamento no sea ni 10 ni 30:

select * from emple where dept_no not in (10, 30);


-- Consultar los apellidos de la tabla EMPLE cuyo oficio sea ‘VENDEDOR’, ‘ANALISTA’ O ‘EMPLEADO’:

select * from emple where oficio in ('VENDEDOR','ANALISTA','EMPLEADO');

--SUBCONSULTAS

-- Presentar los nombres y oficios de los empleados que tienen el mismo oficio que “JIMENEZ”.

select * from emple where oficio in ( select oficio from emple where apellido = 'JIMENEZ');


--COMBINACIÓN DE TABLAS


-- Con las tablas ALUMNOS, ASIGNATURAS,NOTAS realizar una consulta para obtener el nombre de alumno, su asignatura y su nota.

select apenom al, nombre ag, nota nt from alumnos al, asignaturas ag, nota nt where al.dni = nt.dni and nt.cod = ag.cod;


-- Seleccionar el apellido, el oficio y la localidad de los departamentos donde trabajan los ANALISTAS.

select apellido, oficio, loc from emple e, depart d where e.dept_no = d.dept_no and e.oficio = 'ANALISTA';


--FUNCIONES

-- 1. Calculo del SALARIO medio de los empleados del departamento 10 en la tabla EMPLE.

select AVG(salario) "Media de salario" from emple where dept_no = 10;

-- 2.	Calcula el número de filas de la tabla EMPLE

select count(*) from emple;
select oficio, count(*) from emple GROUP by oficio;

-- 3.	Cuenta las tuplas de la tabla EMPLE en los que COMISIÓN no es nula.


--count no cuenta nulos por defecto, ambas soluciones dan el mismo resultado.
select count(comision) from emple;

select count(*) from emple where comision is null;

-- 4.	Obtén el máximo salario de la tabla EMPLE

select max(salario) "Salario más alto" from emple;

-- 5.	Obtener la suma de todos los salarios de la tabla EMPLE

select sum(salario) "Salarios totales" from emple;

-- 6.	Obtener el salario y el apellido del empleado con el mayor salario de la tabla EMPLE.

select 	apellido, salario from emple where salario = (select max(salario) from emple);	



-- TO_CHAR

select to_char(sysdate,'"Hoy es " day "," dd "," "de" month "del año" yyyy ') "Fecha" from dual;

--	A partir de la tabla EMPLE visualizar el número de empleados que hay en cada departamento.

select dept_no, count(*) "Nº trabajadores" from emple GROUP by dept_no;

-- Visualizar los departamentos con más de 4 empleados

select dept_no, count(*) "Más de 4 trabajadores" from emple GROUP by dept_no having count(*)>4;

-- Obtener los nombres de los departamentos que tengan más de tres personas trabajando

select e.dept_no, d.dnombre from depart d, emple e where d.dept_no = e.dept_no group by e.dept_no, d.dnombre having count(*)>3;

select dept_no, dnombre from depart where dept_no in (select dept_no from emple group by dept_no having count(*)>3);

-- Visualizar los departamentos en los que el salario medio es mayor o igual que la media de todos los salarios.

select dept_no, dnombre from depart where dept_no in (select dept_no from emple group by dept_no having avg(salario)>= avg(salario));