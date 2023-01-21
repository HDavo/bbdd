--Ejercicios procedimientos del tema 12 (necesario etiquetar los datos de salida)

/* 10- Escribe un procedimiento que reciba dos números y visualice la suma. */

/* 11- Escribir un procedimiento para consultar los datos de los departamentos mediante el número del departamento (dept_no). Usar el bloque de EXCEPTION para que el programa funcione si no encuentra el departamento. */

CREATE OR REPLACE 
PROCEDURE VER_DEPART (numdepart number)
AS
	v_dnombre varchar(14);
	v_localidad varchar(14);
BEGIN 
	SELECT dnombre, loc into v_dnombre, v_localidad
	from depart where dept_no = numdepart;
	dbms_output.put_line("NUMDEPART: "||numdepart||" NOMBRE DEP: "||v_dnombre||" LOCALIDAD: "||v_localidad);
EXCEPTION
	when no_data_found then
	dbms_output.put_line("No se ha encontrado el departamento");
END;
/


/* 12- Crear un procedimiento que reciba un número de empleado y una cadena correspondiente a su nuevo oficio. El procedimiento deberá localizar el empleado, modificar el oficio y visualizar los cambios realizados.   */

/* 13- Escribir un procedimiento que modifique el precio de costo de un artículo pasándole el nb del artículo,
el nuevo precio y la categoría. El procedimiento comprobará que la variación del precio no supere el 2%.
Usar el bloque de EXCEPTION para que el programa funcione si no encuentra el artículo.
EJEMPLO: Mantequilla 2   Segunda
*/


-- 14- Codifica un procedimiento que reciba una cadena y la visualice al revés.