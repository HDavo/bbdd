--Ejercicios procedimientos del tema 12 (necesario etiquetar los datos de salida)

/* 10- Escribe un procedimiento que reciba dos números y visualice la suma. */

CREATE OR REPLACE PROCEDURE SUMA_NUM(NUM1 NUMBER, NUM2 NUMBER)
IS
	RESUL NUMBER(5)
BEGIN
	RESUL:=NUM1 + NUM2;
	DBMS_OUTPUT.PUT_LINE('RESULTADO = '||RESUL);
END;
/

EXECUTE SUMA_NUM(21,12);

/* 11- Escribir un procedimiento para consultar los datos de los departamentos mediante el número del departamento (dept_no).
Usar el bloque de EXCEPTION para que el programa funcione si no encuentra el departamento. */

CREATE OR REPLACE PROCEDURE VER_DEP (numdepart number)
IS
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

EXECUTE VER_DEP(7898);


/* 12- Crear un procedimiento que reciba un número de empleado y una cadena correspondiente a su nuevo oficio.
El procedimiento deberá localizar el empleado, modificar el oficio y visualizar los cambios realizados.
*/

CREATE OR REPLACE PROCEDURE VER_OFICIO(TRAB NUMBER, NUEVO_OF VARCHAR2)
IS
	V_ANTIGUO EMPLE.OFICIO%TYPE;
BEGIN
	SELECT OFICIO INTO V_ANTIGUO FROM EMPLE WHERE EMP_NO=TRAB;
	UPDATE EMPLE SET OFICIO = NUEVO_OF WHERE EMP_NO =  TRAB;
	DBMS_OUTPUT.PUT_LINE(TRAB|| ' antes era '||V_ANTIGUO|| TRAB||' ahora es '|| OFICIO);
END;
/

EXECUTE VER_OFICIO(8989, 'Pepe');
/* 13- Escribir un procedimiento que modifique el precio de costo de un artículo pasándole el nb del artículo,
el nuevo precio y la categoría. El procedimiento comprobará que la variación del precio no supere el 2%.
Usar el bloque de EXCEPTION para que el programa funcione si no encuentra el artículo.
EJEMPLO: Mantequilla 2   Segunda
*/

CREATE OR REPLACE PROCEDURE MOD_PRECIO(n_nombre varchar2, n_precio number, n_categoria varchar2)
IS
	V_NOMBRE ARTICULOS.ARTICULO%TYPE;
	V_PRECIO ARTICULOS.PRECIO_COSTO%TYPE;
BEGIN
	-- select ARTICULO INTO V_NOMBRE, CATEGORIA,PRECIO_COSTO FROM ARTICULOS WHERE ARTICULO = N_NOMBRE;
	select ARTICULO, PRECIO_COSTO INTO V_NOMBRE,V_PRECIO FROM ARTICULOS WHERE ARTICULO = N_NOMBRE;
	IF (N_PRECIO <= V_PRECIO*1.02) 
	UPDATE ARTICULO SET PRECIO_COSTO = N_PRECIO, CATEGORIA = N_CATEGORIA WHERE ARTICULO = N_NOMBRE;
	DBM.PUT_LINE('Modificación exitosa');
	ELSE DBMS_OUTPUT.PUT_LINE('Precio demasiado elevado');
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
	DBM.PUT_LINE('Producto no encontrado.');
END;
/

EXECUTE MOD_PRECIO('Macarrones', 466, 'Primera');

-- 14- Codifica un procedimiento que reciba una cadena y la visualice al revés.


CREATE OR REPLACE PROCEDURE PALABRA_AL_REVES(N_PALABRA VARCHAR)
IS
	CADENA VARCHAR2(50);
BEGIN
	FOR i IN REVERSE 1..LENGTH(N_PALABRA) LOOP
	CADENA:=CADENA||SUBSTR(N_PALABRA,I,1);
	END LOOP;
	RETURN CADENA;
END;
/

EXECUTE PALABRA_AL_REVES('ORNITORRINCO');