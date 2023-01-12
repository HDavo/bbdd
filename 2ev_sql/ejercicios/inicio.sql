-- dadas las siguientes tuplas:
-- empleado(dni, nombre, dir,cp,f_nac,sueldo,codigo)
-- departamento(codigo,nombre,localidad)

CREATE TABLE DEPARTAMENTO (
	codigo varchar(5) primary key,
	nombre varchar(40) not NULL,
	localidad varchar(40) not NULL,
);

CREATE TABLE EMPLEADO (
	dni varchar(9) primary key,
	nombre varchar(50) not null,
	dir varchar(50) not null,
	CP varchar(5) not null,
	f_nac date,
	sueldo number,
	codigo varchar(5) references departamento, 
);




-- ejercicio de la pagina 6 del tema 7
drop table provincias;
drop table personas;
create table provincias(
	cod_prov number(2) constraint pk_provincias primary key check (cod_prov BETWEEN 1 and 50),
	nb_prov varchar(30) not null UNIQUE,
);

CREATE table personas(
	dni varchar(9) constraint pk_personas primary key,
	nombre varchar(40) not null CHECK (nb=upper(nb)),
	direccion varchar(50) not null,
	cod_prov number(2) not null CONSTRAINTS fk_personas references provincias(cod_prov) on DELETE cascade
);



--del tema 8

de una sola tabla

select col1,col2 ... from nbTabla [ where condicion];

subconsulta de una sola tabla

select col1, col2, ... from nbtabla where col in ( select col(s) from nbtabla)

-- en este caso coinciden ambos nombres de las tablas

subconsulta de varias tablas (necesario poner el nexo de unión de las tablas)

select col1, col2,... from nbtabla1, nbtabla2 ... where tabla1.columna = tabla2.columna 
-- en una será la clave primaria y en otra la clave ajena

