-- creates correctos
drop table departamento3 cascade CONSTRAINTS;
drop table asignatura2 cascade CONSTRAINTS;
drop table alumno2 cascade CONSTRAINTS;
drop table profesor3 CASCADE CONSTRAINTS;
drop table imparte2 cascade CONSTRAINTS;


create table departamento3 (
	cod_dep varchar(5),
	nb_dep varchar(40) not NULL,
	CONSTRAINT pk_departamento3 primary key (cod_dep)
);
--inserts departamento3

insert into departamento3 values ('28019', 'PROGRAMACION');
insert into departamento3 values ('28025', 'EMPRESA');
insert into departamento3 values ('28013', 'HISTORIA');
insert into departamento3 values ('28005', 'REDES');
insert into departamento3 values ('28900', 'ANDROID');
insert into departamento3 values ('28790', 'BASES DE DATOS');


create table asignatura2 (
	cod_asig VARCHAR(5),
	nb_asig VARCHAR(40) not null,
	CONSTRAINT pk_asignatura2 PRIMARY key (cod_asig)
);

--inserts asignatura2

insert into asignatura2 values (10001,'FOL');
insert into asignatura2 values (10002, 'JAVA');
insert into asignatura2 values (10003, 'INTERFACES');
insert into asignatura2 values (10004, 'SISTEMAS');
insert into asignatura2 values (10005, 'ENTORNOS DE DESARROLLO');
insert into asignatura2 values (10006, 'EMPRESA');

create table alumno2 (
	dni_alum VARCHAR(9),
	nb VARCHAR(50) not null,
	dir varchar(35) not null,
	tf varchar(9) not null,
	fecha_nac date not NULL,
	constraint pk_alumno2 PRIMARY key (dni_alum)
);

--INSERTS ALUMNO2

insert into alumno2 values ('90034589H','PEPE PEREZ MARTINEZ','SOL', '688912334', TO_DATE('20/05/1999'));
insert into alumno2 values ('34578923J','JUAN PEREZ GONZALEZ','LUNA','689234678',TO_DATE('24/05/1998'));
insert into alumno2 values ('50356423H','PACO GONZALEZ PEREZ','MARTE','692345469',TO_DATE('12/06/2001'));
insert into alumno2 values ('45678912Q','DAVID MARTINEZ PEREZ','MERCURIO','654123456',TO_DATE('24/07/2000'));
insert into alumno2 values ('78909823X','SARA PEREZ GONZALEZ','VIA LACTEA','678324765',TO_DATE('23/02/2002'));
insert into alumno2 values ('89569023T','ALEJANDRA MARTINEZ SIERRA','MEDUSA','789435124',TO_DATE('15/09/2003'));

--repetir los alumnos en las distintas asignaturas para que salgan varios en las diferentes consultas

create table profesor3 (
	dni_prof varchar(9),
	nb VARCHAR(50) not null,
	dir varchar(35) not null,
	tf varchar(9) not null,
	sueldo number not null,
	cod_dep varchar(5) not null,
	CONSTRAINT pk_profesor3 PRIMARY KEY (dni_prof),
	CONSTRAINT fk_profesor3 FOREIGN key (cod_dep) references departamento3 on DELETE cascade
);

--inserts profesor3

insert into profesor3 values ('45901290P','MARIA PEREZ SANTIAGO','LUNA','689346751',2000,'28019');
insert into profesor3 values ('54124345T','ASUNCION MARTINEZ LUGO','MARTE','670063412',2300,'28025');
insert into profesor3 values ('23435465Y','SEGISMUNDO PEREZ MARTINEZ','SOL','678234145',1900,'28013');
insert into profesor3 values ('34567890H','ENRIQUE PEREZ PEREZ','SATURNO','612345678',2500,'28005');
insert into profesor3 values ('87976845R','LUCIA GARCIA PEREZ','MEXICO','623546142',1800,'28900');
insert into profesor3 values ('90060012V','SAUL MARTINEZ PONTEVEDRA','NEPTUNO','672111221',2450,'28790');

--hacer inserts con los departamentos repetidos
create table imparte2 (
	cod_asig varchar(5),
	dni_prof varchar(9),
	dni_alum varchar(9),
	constraint pk_imparte1 primary key (cod_asig,dni_prof,dni_alum),
	constraint fk_imparte1 FOREIGN key (cod_asig) references asignatura2 on delete cascade,
	constraint fk_imparte2 FOREIGN key (dni_prof) references profesor3 on delete cascade,
	constraint fk_imparte3 FOREIGN key (dni_alum) references alumno2 on delete cascade
); 

--inserts imparte2

insert into imparte2 values ('10001','45901290P','90034589H');
insert into imparte2 values ('10002','54124345T','34578923J');
insert into imparte2 values ('10003','23435465Y','50356423H');
insert into imparte2 values ('10004','34567890H','45678912Q');
insert into imparte2 values ('10005','87976845R','78909823X');
insert into imparte2 values ('10006','90060012V','89569023T');


--hacer inserts con repitiendo las claves (profesor y asignatura)