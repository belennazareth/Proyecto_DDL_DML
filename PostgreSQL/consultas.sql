-- ALTERACIÓN DE TABLAS
--1

ALTER TABLE VENDEDORES ADD TIPO VARCHAR(30);

--2

ALTER TABLE VENDEDORES ADD CONSTRAINT CH_VENDEDORTIPO CHECK (TIPO IN ('Franquicia','Autonomo'));

INSERT INTO VENDEDORES VALUES ('1','Juan','ESPAÑA','Franquicia');
INSERT INTO VENDEDORES VALUES ('2','Pedro','ESPAÑA','Autonomo');
INSERT INTO VENDEDORES VALUES ('3','Maria','ESPAÑA','Ninguno');
--3 

ALTER TABLE VENDEDORES DROP COLUMN PAIS;

--4 

ALTER TABLE ARTICULOS ADD CONSTRAINT CH_ARTICULOCODIGO CHECK (CODIGO ~ '^([0-9])+$');

INSERT INTO ARTICULOS VALUES ('1','Pantalones','1',1.5,'Nuevo',10.0);
INSERT INTO ARTICULOS VALUES ('ABC','Pantalones','1',1.5,'Nuevo',10.0);

--5 

ALTER TABLE VENDEDORES DROP CONSTRAINT CH_VENDEDORPAIS;

INSERT INTO VENDEDORES VALUES ('3','Pepe','Franquicia','españa');

--6 

ALTER TABLE TIENDAS DROP CONSTRAINT CH_TIENDANOMBRE;

INSERT INTO TIENDAS VALUES ('Tienda1', 'Madrid', 'Productos variados', 28000);

-- CONSULTAS
--1

SELECT NOMBRE,ESTADO FROM ARTICULOS;

--2

CREATE OR REPLACE VIEW VISTAPEDIDOS AS SELECT CODIGO,FECHA_PEDIDO FROM PEDIDOS;

--3 

SELECT V.NOMBRE, A.NOMBRE FROM VENDEDORES V, ARTICULOS A WHERE V.CODIGO=A.COD_VENDEDOR;  

--4 

SELECT T.*, P.CANTIDAD FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA; 

--5 

UPDATE ARTICULOS SET PRECIO_VENTA=(PRECIO_VENTA*0.9);

--6 

SELECT CODIGO FROM CLIENTES WHERE FECHA_COMPRA=(SELECT MAX(FECHA_PEDIDO) FROM PEDIDOS);

--7 

DELETE FROM ARTICULOS WHERE COD_VENDEDOR=(SELECT CODIGO FROM VENDEDORES WHERE NOMBRE='Larry');

--8 

SELECT V.NOMBRE,V.PAIS FROM VENDEDORES V, ARTICULOS A ORDER BY A.PRECIO_VENTA ASC;

--9 

SELECT avg(P.CANTIDAD) as 'Media de pedidos' FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA;

--10 

SELECT A.NOMBRE, V.NOMBRE FROM VENDEDORES V right join ARTICULOS A on V.CODIGO=A.COD_VENDEDOR ORDER BY V.NOMBRE;

--11 

SELECT T.NOMBRE, P.CODIGO, P.FECHA_PEDIDO FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA AND P.CANTIDAD=(SELECT MAX(P.CANTIDAD) FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA);

--12 

SELECT V.NOMBRE, V.PAIS, A.NOMBRE FROM VENDEDORES V, ARTICULOS A WHERE V.CODIGO=A.COD_VENDEDOR AND A.PRECIO_VENTA=(SELECT MAX(A.PRECIO_VENTA) FROM VENDEDORES V, ARTICULOS A WHERE V.CODIGO=A.COD_VENDEDOR);

--13

SELECT T.NOMBRE, NVL(AVG(P.CANTIDAD),0) AS "Media de pedidos" FROM TIENDAS T LEFT JOIN PEDIDOS P ON T.NOMBRE=P.NOM_TIENDA GROUP BY T.NOMBRE;
