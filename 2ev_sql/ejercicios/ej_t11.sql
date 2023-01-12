--crear la tabla emple30 con la misma estructura que emple
drop table emple30 cascade CONSTRAINTS;

create table emple30 (
	emp_no number(4),
	apellido VARCHAR2(10),
	oficio VARCHAR2(10),
	dir number(4),
	fecha_alt date,
	salario number(7),
	comision number(7),
	dept_no number(2),
	constraint pk_emp30 PRIMARY key (emp_no)
	-- constraint fk_emp30 FOREIGN key (dept_no) references depart on delete cascade
);



--ejemplo 1
insert into emple30 select * from emple where dept_no = 30;

select * from emple30; 

--ejemplo 2

insert into emple select 1112, 'QUIROGA', oficio, dir, sysdate, salario, comision, dept_no from emple where apellido = 'GIL';

--ejemplo modificación con SELECT

-- EJEMPLO: Sea la tabla CENTROS, cuyo COD_CENTRO es 22 cambiar la direccion a ‘C/PILON 13’ y el numero de plazas a 295

update centros set direccion = 'C/PILON 13', num_plazas = 295 where cod_centro = 22;

-- EJEMPLO: Para todos los empleados de la tabla EMPLE que sean del departamento de CONTABILIDAD, cambiamos su salario al doble del salario de SANCHEZ y el apellido a minúscula.

update emple set salario = (select salario*2 from emple where apellido='SANCHEZ'), apellido=lower(apellido) where dept_no = (select dept_no from depart where dnombre = 'CONTABILIDAD');

--creación con SELECT

-- Crear una tabla llamada EMPLE1 con los empleados del departamento 30.

drop table emple1 cascade constraints;

create table emple1 as select * from emple where dept_no = 30;

--las dos soluciones dan lo mismo, al haber creado emple30 con el filtro del número del departamento
drop table emple1 cascade constraints;

create table emple1 as select * from emple30;

 -- Crear una tabla EMPLE_DEPART a partir de las tablas EMPLE y DEPART. Esta tabla contendrá el apellido y el nombre del departamento de cada empleado.

drop table emple_depart cascade constraints;

create table emple_depart as select apellido e, dnombre d from emple e, depart d where e.dept_no = d.dept_no;
--dept_no se usa para poder usar el dnombre y ponerlo dentro de la nueva tabla


--borrado de filas

 -- Borrar el COD_CENTRO 50 de la tabla CENTROS
 
 delete from centros where cod_centro = 50;

--cambios de nombre

rename emple_depart to Empleados;

-- TABLAS EMPLE Y DEPART
-- 1.	Insertar a un empleado de apellido ‘SAAVEDRA’ con número 2000. La fecha de alta será la actual, el SALARIO será el mismo salario de ‘SALA’ más el 20 % y el resto de datos serán los mismos que los datos de ‘SALA’.

insert into emple (SELECT 2000, 'SAAVEDRA', OFICIO, DIR, SYSDATE, SALARIO + SALARIO * 0.2, COMISION, DEPT_NO FROM EMPLE WHERE APELLIDO = 'SALA');

-- 2.	Modificar el número de departamento de ‘SAAVEDRA’. El nuevo departamento será el departamento donde hay más empleados cuyo oficio sea ‘EMPLEADO’.

update emple set dept_no = (select dept_no from emple where oficio like 'EMPLEADO' group by dept_no having count (*) = (select max(count(*)) from emple where oficio like 'EMPLEADO' group by dept_no)) where apellido like 'SAAVEDRA';

-- 3.	Borrar todos los departamentos de la tabla DEPART para los cuales no existan empleados en EMPLE.

delete * from depart where dept_no in (select dept_no from depart minus select dept_no from emple);

--¿minus actúa como un eliminador de la intersección? 

-- 4. Modificar el número de plazas con un valor igual a la mitad en aquellos centros con menos de dos profesores. (group by + having count)

update centros set num_plazas = num_plazas/2 where cod_centro in (select cod_centro from profesores group by cod_centro having count(*)<2);