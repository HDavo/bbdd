drop table fabricantes2 cascade constraints;

create table fabricantes2 (
	cod_fab varchar(5),
	nombre varchar(35) not null,
	constraint pk_fab primary key (cod_fab),
	constraint u_fab unique (nombre)
);


insert into fabricantes2 values ('11111', 'CORSAIR');
insert into fabricantes2 values ('22222','PEPE');
insert into fabricantes2 values ('33333','MANOLO');
insert into fabricantes2 values ('44444','PACO');
insert into fabricantes2 values ('55555','IBM');
insert into fabricantes2 values ('66666','COMPAQ');



drop table articulos2 cascade constraints;

create table articulos2 (
	cod_art varchar(5),
	nombre varchar(35) not null,
	precio number(7) not null ,
	cod_fab varchar(5) not null,
	constraint pk_articulos PRIMARY key (cod_art),
	constraint fk_articulos foreign key (cod_fab) REFERENCES fabricantes2 on delete cascade,
	constraint lim_pre CHECK(precio>0),
	constraint may_nb check (nombre = (upper(nombre)))
);

insert into articulos2 values ('12345','TECLADO',34.5,'11111');
insert into articulos2 values ('12132','RATON INALAMBRICO',45,'11111');
insert into articulos2 values ('23431','ALFOMBRILLA RGB',34, '11111');
insert into articulos2 values ('12121','IMPRESORA',90,'22222');
insert into articulos2 values ('23231','ESCANER',200,'22222');
insert into articulos2 values ('21211','TABLETA GRAFICA',450,'33333');
insert into articulos2 values ('90000','AURICULARES GAMING', 500, '44444');
insert into articulos2 values ('80808','WALKMAN', 89, '33333');
insert into articulos2 values ('10010','VENTILADOR',45,'44444');
insert into articulos2 values ('12214','CALEFACTOR',78,'55555');


--al poner la clave ajena, antes de la constraint poner not null.



-- 2.1- Añadir los campos DIRECCION y LOCALIDAD a la tabla fabricantes.

alter table fabricantes2 add (
	direccion varchar(50),
	localidad varchar(35)
);

--no se pueden poner columnas not null una vez se ha realizado la inserción de datos

-- 2.2- Eliminar la restricción de nombre en mayúsculas.

alter table articulos2 drop constraint may_nb;


-- 2.3- Insertar la siguiente fila: altavoces de 70€ del fabricante 2.

insert into articulos2 values ('66634', 'altavoces', 70, '44444');

-- 2.4- Cambiar el nombre del artículo 8 a 'impresora láser'.


update articulos2 set nombre='Impresora Laser' where cod_art = '8';

-- 2.5- Aplicar un descuento de 10€ a todos los artículos cuyo precio sea mayor igual a 120€.

update articulos2 set precio=precio-10 where precio >= 120;


--APARTADO DE SELECTS

-- 3.1

select nombre from articulos2;

-- 3.2
select nombre,precio from articulos2 where precio<200;


-- 3.3

select * from articulos2 where precio between 60 and 120;

-- 3.4

select nombre, (precio*166.66) "Precio en pesetas" from articulos2;

-- 3.5

select avg(precio) "precio medio" from articulos2;

-- 3.6

select avg(precio) from articulos2 where cod_fab = '11111';

-- 3.7

select count(*) from articulos2 where precio >=180;

-- 3.8

select nombre, precio from articulos2 where precio>=180 order by precio desc, nombre;
--ejemplo de poner dos criterios de ordenación

-- 3.9

select articulos2.nombre, precio, fabricantes2.nombre from articulos2, fabricantes2 where articulos2.cod_fab = fabricantes2.cod_fab;

-- 3.10

select cod_fab,AVG(precio) from articulos2 group by cod_fab;

--3.11
--correccion

select avg(precio) "Promedio", f.nombre from articulos2 a, fabricantes2 f where a.cod_fab = f.cod_fab group by f.nombre;

-- 3.12
--correccion

select avg(precio) "Promedio", f.nombre from articulos2 a, fabricantes2 f where a.cod_fab = f.cod_fab group by f.nombre having avg(precio) >= 150;

-- 3.13 
--no se puede hacer el min o max de forma directa, se debe hacer como en la corrección.

select nombre, precio from articulos2 where precio in (select min(precio) from articulos2);

-- 3.14 Obtener una lista con el nombre y el precio de los artículos más caros de cada proveedor incluyendo el nombre del proveedor.

select a.nombre, precio, f.nombre "Fabricante" from articulos2 a, fabricantes2 f where (f.cod_fab = a.cod_fab) and precio in (select MAX(precio) from articulos2 a where a.cod_fab = f.cod_fab);

