DROP TABLE DEPARTAMENTO2 CASCADE CONSTRAINTS;

CREATE TABLE DEPARTAMENTO2 (
	COD_DEP VARCHAR(5),
	NOMBRE VARCHAR(50) not NULL,
	LOCALIDAD VARCHAR(30) not NULL,
	constraint pk_departamento PRIMARY KEY (cod_dep),
	constraint u_departamento unique (nombre)
);

drop table proyecto CASCADE CONSTRAINTS;

create  table proyecto(
	cod_proy VARCHAR(5) constraint pk_proyecto primary KEY,
	nombre VARCHAR(25) not NULL,
	CONSTRAINT u_proyecto unique (nombre)
);

drop table empleado cascade CONSTRAINTS;

create table empleado (
	cod_emp varchar(5) constraint pk_empleado PRIMARY KEY,
	dni varchar(9) not null,
	nombre varchar(50) not null,
	dir varchar(35) not null,
	cp varchar(5) not null,
	poblacion VARCHAR(25) not null,
	COD_DEP VARCHAR(5),
	CONSTRAINT fk_empleado FOREIGN KEY (COD_DEP) references departamento2 on delete cascade
); 

drop table hacer_proyecto cascade constraints;

create table hacer_proyecto (
	cod_emp varchar(5),
	cod_proy varchar(5),
	fecha_i DATE,
	fecha_f DATE,
	CONSTRAINT PK_HACER PRIMARY key (cod_emp,cod_proy), --siempre así en caso de clave compuesta.
	CONSTRAINT fk_hacer FOREIGN key (cod_emp) references empleado on delete cascade,
	constraint fk_hacer2 FOREIGN key (cod_proy) references departamento2 on delete cascade
);

--añadir el campo salario a la tabla empleado (siempre con alter table)

alter table empleado add (
	salario number not null
);

--corrección carmen

alter table empleado add (salario number(5));

--modificar las columnas de las tablas departamento  y empleado para que el nombre pueda almacenar más caracteres

alter table departamento2 modify (
	nombre varchar(60)
);


alter TABLE empleado modify (
	nombre varchar(60)
);

-- -	A partir de la tabla DEPARTAMENTO impide que se puedan dar de alta más departamentos en la localidad de GETAFE.

alter table departamento2 modify localidad CHECK ((localidad)!='GETAFE');

alter table departamento2 add constraint dk check (localidad<>getafe); --completar esta correción


-- -	Eliminar la restricción de UNIQUE de la columna NOMBRE de la tabla PROYECTOS.

alter table proyecto modify (
	drop constraint u_proyecto unique (nombre)
);

alter table proyecto modify drop constraint u_proyecto;
--no funciona

-- -	Insertar la siguiente tupla en HACER_PROYECTO (0001-E, 0001-P, 20 DE FEBRERO DE 2009, NULOS)

insert into hacer_proyecto (SELECT 0001-E, 0001-P, TO_CHAR(20/02/2009, DD "DE" MONTH "MONTH" DE YEAR), NULL);

insert into hacer_proyecto (SELECT 0001-E, 0001-P, TO_CHAR(20/02/2009, DD "DE" MONTH "MONTH" DE YEAR), NULL);

INSERT INTO SELECT 0001-E, 0001-P, TO_CHAR(20/02/2009, ‘DD “DE” MONTH “MONTH” DE YEAR ), NULL;

-- -	Crear una vista llamada EMPLE_PROYECTO que contenga el NB_EMPLE,NB_PROY de aquellos proyectos realizados entre el 18/01/2009 y 18/02/2009.