--antes de la zona debe haber una zona de declaración de variables, que son las que se van a usar luego en la select.

select
	tablas
	columnas
into (variables declaradas en la zona de declaración)
 from tabla
where condicion; --esta select no devuelve ningún resultado visual.

--el resultado no se visualiza de forma directa debe usarse el siguiente formato: permite el etiquetado de datos y la concatenación.

 
 
--for solo con valor inicial y final.

--loop vs while (uno pregunta la condición en la entrada y otro en la salida).



--importante ejercicio 9 t12 para ver como se resuelve lo mismo con las diferentes posibilidades


-- en procedimientos siempre:
-- create or replace

-- en la parte de create or replace el tipo de variable no lleva longitud.


-- las funciones no visualizan nada, nunca deben tener un dbms ni un execute.
-- para visualizarlas deben ponerse dentro de un bloque anónimo o bien con un select from dual, llamando a la función y pasandole el valor dentro de ella.

-- select sumar_fun(3,3) from dual;