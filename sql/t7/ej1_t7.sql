drop table fabricantes;

create table fabricantes (
    cod_fabricante number(3),
    nombre varchar(15) constraint nombre CHECK(nombre=UPPER(nombre)),
    pais varchar(15) constraint pais check(pais=upper(pais)),
    constraint pk_fabricantes primary key (cod_fabricante)
);


drop table tiendas;

create table tiendas (
    nif varchar(10),
    nombre varchar(20),
    direccion varchar(20),
    poblacion varchar(20),
    provincia varchar(20) constraint may_prov CHECK(provincia=upper(provincia)),
    cod_postal number(5),
    constraint pk_tiendas primary key (nif)
);

drop table articulos;

create table articulos (
    articulo varchar(20),
    cod_fabricante number(3),
    peso number(3),
    categoria varchar(10),
    precio_venta number(4),
    precio_costo number(4),
    existencias number(5),
    constraint pk_articulo primary key (articulo,cod_fabricante,peso,categoria),
    constraint fk_articulo FOREIGN key (cod_fabricante) references fabricantes on delete cascade,
	constraint ct_categoria check (categoria in('Primera','Segunda','Tercera')),
	constraint art_peso check (peso>0),
	constraint art_venta check (precio_venta>0),
	constraint art_costo check (precio_costo>0)
);

--no funciona la clave ajena multiple
drop table pedidos;

create table pedidos (
    nif varchar(10),
    articulo varchar(20),
    cod_fabricante number(3),
    peso number(3),
    categoria varchar(10),
    fecha_pedido date,
    unidades_pedidas number(4) constraint un_ped check( unidades_pedidas>0),
    constraint pk_pedidos primary key (nif,articulo, cod_fabricante,peso,categoria, fecha_pedido),
    constraint fk_pedidos1 FOREIGN key (nif) references tiendas on delete cascade,
	constraint fk_pedidos3 FOREIGN key (articulo,cod_fabricante, peso, categoria) REFERENCES articulos on DELETE CASCADE,
	constraint ct_pedidos check (categoria in('Primera', 'Segunda','Tercera'))
);
-- constraint fk_pedidos3 FOREIGN key (articulo,cod_fabricante, peso, categoria) REFERENCES articulos on DELETE CASCADE,

drop table ventas;

create table ventas (
    nif varchar(10),
    articulo varchar(20),
    cod_fabricante number(3),
    peso number(3),
    categoria varchar(10),	
    fecha_venta date,
    unidades_vendidas number(4),
    constraint pk_ventas primary key (nif,articulo,cod_fabricante,peso, categoria, fecha_venta),
    constraint fk_ventas1 FOREIGN key (nif) references tiendas on delete cascade,
    constraint fk_ventas2 FOREIGN key (cod_fabricante) references fabricantes on delete cascade,
    constraint fk_ventas3 FOREIGN key (articulo,cod_fabricante, peso, categoria) references articulos
);