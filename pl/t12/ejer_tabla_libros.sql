--primero eliminar la tabla

drop table libros12;

--volver a crear la tabla
create table libros12(
    codigo number(3),
    titulo varchar2(50),
    autor varchar2(40),
    precio number(5,2)
);

--inserts

insert into libros values(100,'Uno','Richard Bach',15);
insert into libros values(300,'Aprenda PHP','Mario Molina',55);
insert into libros values(102,'Matematica estas ahi','Paenza',18);
insert into libros values(105,'El aleph','Borges',25);
insert into libros values(109,'El experto en laberintos','Gaskin',20);
insert into libros values(204,'Alicia en el pais de las maravillas','Carroll',31);


/* Creamos una función que reciba 1 parámetro (un valor numérico a incrementar) y retorne el valor ingresado como argumento con el incremento del 10%. */


/* Realizamos un "select" sobre "libros" que muestre el título, precio y llamamos a la función creada anteriormente para que nos devuelva el precio incrementado en un 10%.
 */

/* Creamos otra función que reciba 2 parámetros, un valor a incrementar y el incremento, y que nos retorne el valor ingresado como primer argumento con el incremento especificado por el segundo argumento.
 */

/* Realizamos un "select" sobre "libros" que muestre el título, precio y el precio
incrementado en un 20% (llamando a la función creada anteriormente,
enviando como primer argumento el campo "precio" y como segundo argumento el valor "20"). */


/* Realizamos otro "select" similar al anterior, pero en esta ocasión le enviamos a la función otro valor como segundo argumento. */


/* Creamos o reemplazamos una función que recibe un parámetro de tipo numérico
y retorna una cadena de caracteres.
Se define una variable en la zona de definición de variables denominada "valorretornado" de tipo varchar.
En el cuerpo de la función empleamos una estructura condicional (if) para averiguar
si el valor enviado como argumento es menor o igual a 20,
si lo es, almacenamos en la variable "valorretornado" la cadena "economico",
en caso contrario guardamos en tal variable la cadena "costoso";
al finalizar la estructura condicional retornamos la variable "valorretornado":
 */


/* Realizamos un "select" para mostrar el título, precio y una cadena que indique si el libro es económico o costoso
(llamando a la función creada anteriormente). */