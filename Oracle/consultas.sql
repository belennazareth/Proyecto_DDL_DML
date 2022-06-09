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



