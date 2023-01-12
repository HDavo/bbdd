--ejercicios tema 10

-- TABLA LIBRERÍA
-- 1)	Visualizar los diferentes estantes de la tabla LIBRERÍA  ordenados descendentemente por estante.

select estante from libreria  ORDER by estante DESC;

select estante from libreria GROUP by estante order by estante desc;

-- 2)	Averiguar cuantos temas tiene cada estante.
select estante, count(tema) "Temas por estante" from libreria group by estante;
 

-- 3)	Visualizar los estantes que tengan más de tres temas.

select estante, count(tema) "Más de 3 temas" from libreria group by estante HAVING count(tema)>=3;

-- 4)	Visualizar por cada estante la suma de los ejemplares.

SELECT estante, sum(ejemplares) "Total" from libreria group by estante;

-- TABLAS EMPLE Y DEPART
-- 5)	Visualizar los departamentos en los que el salario medio es mayor o igual que la media de todos los salarios.
select dept_no, avg(salario) from emple 
group by dept_no HAVING avg(salario) >= (select avg(salario) from emple);

select dept_no,avg(salario) from emple group by dept_no;

select avg(salario) from emple;

-- 6)	A partir de la tabla EMPLE, visualizar el número de vendedores del departamento VENTAS.

select count(apellido) "Vendedores" from emple, depart where (emple.dept_no = depart.dept_no and depart.dnombre = 'VENTAS') and emple.oficio = 'VENDEDOR';

select d.dept_no, count(e.*) from emple e, depart d where d.dept_no = e.dept_no and d.nombre = 'VENTAS' and e.oficio = 'VENDEDOR';

-- 7)	Partiendo de la tabla EMPLE, visualizar por cada oficio de los empleados del departamento VENTAS la suma de los salarios.

--versión subconsulta
select oficio, sum(salario) from emple where dept_no in (select dept_no from depart WHERE dnombre = 'VENTAS') group by oficio;

--versión combinación de tablas
select oficio, sum(salario) from emple, depart where (emple.dept_no = depart.dept_no and depart.dnombre = 'VENTAS') group by oficio;

-- 8)	A partir de la tabla EMPLE, visualizar el número de empleados de cada departamento cuyo oficio sea EMPLEADO.

select dept_no, count(apellido) "Empleados" from emple where (oficio = 'EMPLEADO') group by dept_no;

-- TABLA ALUM, ANTIGUOS Y NUEVOS (dentro de TABLASUNI5)

-- 9)	Visualizar los nombres de los alumnos de la tabla ALUM que aparezcan en alguna de estas tablas: NUEVOS o ANTIGUOS. Utilizando operadores de conjunto.

select nombre from alum INTERSECT (select nombre  from antiguos UNION select nombre from nuevos);


-- 10)	Escribir las distintas formas en que se puede poner la consulta anterior llegando al mismo resultado.

select nombre from alum where nombre in (select nombre from nuevos union select nombre from antiguos);

select nombre from alum where nombre in (select nombre from nuevos) or nombre in (select nombre from antiguos);

-- 11)	Visualizar los nombres de los alumnos de la tabla ALUM que aparezcan en estas dos tablas: ANTIGUOS y NUEVOS. Utilizando operadores de conjunto.

select nombre from alum intersect (select nombre from nuevos INTERSECT SELECT nombre from antiguos);

-- 12)	Escribir las distintas formas en que se puede poner la consulta anterior llegando al mismo resultado.

select nombre from alum where nombre in (select nombre from nuevos intersect select nombre from antiguos);

SELECT nombre from alum INTERSECT (select nombre from nuevos where nombre in (select nombre from antiguos));


-- 13)	Visualizar aquellos nombres de la tabla ALUM que no estén en la tabla ANTIGUOS ni en la tabla NUEVOS. Utilizando operadores de conjunto.


--revisar soluciones porque no concuerda con los resultados de las tablas.

select nombre from alum minus (select nombre from nuevos INTERSECT select nombre from antiguos);


select nombre from alum minus (select nombre from nuevos where nombre in (select nombre from antiguos));

select nombre from alum minus (select nombre from nuevos minus select nombre from antiguos);



-- TABLAS PERSONAL, PROFESORES Y CENTROS
-- 14) Realizar una consulta en la que aparezca por cada centro y en cada especialidad el número de profesores. Si el centro no tiene profesores, debe aparecer un 0 en la columna de número de profesores. 
-- NOMBRE                         ESPECIALIDAD     Núm.Profes
---------------------------- ---------------- ----------
-- CP Los Danzantes               DIBUJO                    1
-- CP Los Danzantes               LENGUA                    2
-- CP Manuel Hidalgo              INFORMÁTICA               1
-- IES Antoñete                                             0
-- IES El Quijote                 INFORMÁTICA               1
-- IES El Quijote                 MATEMÁTICAS               2
-- IES Planeta Tierra             MATEMÁTICAS               1


select nombre, especialidad, count(dni) "Num. profesores" from centros, profesores where centros.cod_centro = profesores.cod_centro(+) group by nombre, especialidad;

-- 15)Obtener por cada centro el número de empleados. Si el centro carece de empleados, ha de aparecer un 0 como número de empleados. 
-- COD_CENTRO NOMBRE                         Empleados
-------- ------------------------------ ---------
        -- 10 IES El Quijote                         4
        -- 15 CP Los Danzantes                       5
        -- 22 IES Planeta Tierra                     3
        -- 45 CP Manuel Hidalgo                      2
		-- 50	ES Antoñete                            0

select c.cod_centro, c.nombre, count(dni) "Empleados" from profesores p, centros c where c.cod_centro = p.cod_centro(+) group by c.cod_centro, nombre order by c.cod_centro;

-- 16)Obtener la especialidad con menos profesores.

select especialidad from profesores group by especialidad having count (especialidad) = (select min(count(especialidad)) from profesores group by especialidad);


-- 17)Obtener por cada función el número de trabajadores.

select funcion, count(dni) "Nº trabajadores" from personal group by funcion;

-- TABLAS BANCOS, SUCURSALES, CUENTAS y MOVIMIENTOS

-- 20) Obtén el banco con más sucursales:

	-- NOMBRE BANCO			Nº SUCURSALES
                -- XXXXXXX                                            XX

select b.cod_banco, nombre_banc, count(s.cod_sucur) from bancos b, sucursales s where b.cod_banco = s.cod_banco group by s.cod_banco;

select nombre_banc, cod_banco from bancos where cod_banco in (select cod_banco,max(count(cod_sucur)) from sucursales group by cod_banco);

-- 21)	El saldo actual de los bancos de GUADALAJARA :

-- NOMBRE BANCO      SALDO DEBE    SALDO HABER
     -- XXXXXX                     XXX                      XXXX


-- 22) Datos de las cuentas con más movimientos:

	-- NOMBRE CUENTA			Nº MOVIMIENTOS
		-- XXXXX                                            XXXXX



-- 23)El nombre de la sucursal que haya tenido mas suma de reintegros:

-- NOMBRE SUCURSAL		SUMA REINTEGROS
      -- XXXXXX                                             XXXXX


select nombre_suc, s.cod_sucur from sucursales s,  movimientos m where s.cod_sucur = m.cod_sucur group by nombre_suc;

