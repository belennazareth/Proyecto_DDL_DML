--1

ALTER TABLE VENDEDORES ADD COLUMN TIPO VARCHAR2(30);

--2

ALTER TABLE VENDEDORES ADD CONSTRAINT CH_VENDEDORTIPO CHECK (TIPO IN ('Franquicia','Autonomo', NULL));

--3 

ALTER TABLE VENDEDORES DROP COLUMN PAIS;

--4 

ALTER TABLE ARTICULOS ADD CONSTRAINT CH_ARTICULOCODIGO CHECK (REGEXP_LIKE(CODIGO,'^([0-9])+$'));

--5 

ALTER TABLE VENDEDORES DROP CONSTRAINT CH_VENDEDORPAIS;

--6 

ALTER TABLE TIENDAS DROP CONSTRAINT CH_TIENDANOMBRE;

INSERT INTO TIENDAS VALUES ('Tienda1', 'Madrid', 'Productos variados', 28000);

ALTER TABLE TIENDAS ADD CONSTRAINT CH_TIENDANOMBRE CHECK (REGEXP_LIKE(NOMBRE,'^([[:alpha:]])+$'));

--7 

