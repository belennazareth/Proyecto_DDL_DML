SET SERVEROUTPUT ON 

DROP TABLE TIENDAS;
CREATE TABLE TIENDAS 
(
    NOMBRE VARCHAR2 (20),
    POBLACION VARCHAR2 (20),
    CATEGORIAS VARCHAR2 (20) DEFAULT 'Productos variados',
    CODPOSTAL NUMBER (5),
    CONSTRAINT PK_TIENDAS PRIMARY KEY (NOMBRE),
    CONSTRAINT CH_TIENDANOMBRE CHECK (REGEXP_LIKE(NOMBRE,'^([[:alpha:]])+$'))
);

DROP TABLE VENDEDORES;
CREATE TABLE VENDEDORES
(
    CODIGO VARCHAR2 (3),
    NOMBRE VARCHAR2 (15) NOT NULL,
    PAIS VARCHAR2 (20),
    CONSTRAINT PK_VENDEDORES PRIMARY KEY (CODIGO),
    CONSTRAINT CH_VENDEDORPAIS CHECK (PAIS LIKE UPPER(PAIS))
);

DROP TABLE ARTICULOS;
CREATE TABLE ARTICULOS
(
    CODIGO VARCHAR2 (10),
    NOMBRE VARCHAR2 (15),
    COD_VENDEDOR VARCHAR2 (3),
    PESO NUMBER (3,2),
    ESTADO VARCHAR2 (10),
    PRECIO_VENTA NUMBER (6,2),
    CONSTRAINT PK_ARTICULOS PRIMARY KEY (CODIGO),
    CONSTRAINT FK_CODV_ARTICULOS FOREIGN KEY (COD_VENDEDOR) REFERENCES VENDEDORES (CODIGO),
    CONSTRAINT CH_ARTICULOSESTADO CHECK (ESTADO IN ('Nuevo', 'Reacondicionado', 'Usado')),
    CONSTRAINT CH_ARTICULOSPRECIOV CHECK (PRECIO_VENTA>0)
);

DROP TABLE PEDIDOS;
CREATE TABLE PEDIDOS
(
    CODIGO VARCHAR2 (10),
    NOM_TIENDA VARCHAR2 (10),
    COD_ARTICULO VARCHAR2 (3),
    FECHA_PEDIDO DATE,
    CANTIDAD NUMBER (3),
    CONSTRAINT PK_PEDIDOS PRIMARY KEY (CODIGO),
    CONSTRAINT FK_NOMT_PEDIDOS FOREIGN KEY (NOM_TIENDA) REFERENCES TIENDAS (NOMBRE),
    CONSTRAINT FK_CODART_PEDIDOS FOREIGN KEY (COD_ARTICULO) REFERENCES ARTICULOS (CODIGO),
    CONSTRAINT CH_DATE CHECK (FECHA_PEDIDO>to_date('2018-01-01','YYYY-MM-DD')),
    CONSTRAINT CH_CANTIDAD CHECK (CANTIDAD>0)
);

DROP TABLE CLIENTES;
CREATE TABLE CLIENTES
(
    CODIGO VARCHAR2 (10),
    NOM_TIENDA VARCHAR2 (10),
    COD_ARTICULO VARCHAR2 (10),
    FECHA_COMPRA DATE,
    CONSTRAINT PK_CLIENTES PRIMARY KEY (CODIGO),
    CONSTRAINT FK_NOMT_CLIENTES FOREIGN KEY (NOM_TIENDA) REFERENCES TIENDAS (NOMBRE),
    CONSTRAINT FK_CODART_CLIENTES FOREIGN KEY (COD_ARTICULO) REFERENCES ARTICULOS (CODIGO),
    CONSTRAINT CH_FECHACOMP CHECK (FECHA_COMPRA>to_date('2018-03-17','YYYY-MM-DD'))
);

INSERT INTO TIENDAS (NOMBRE,POBLACION,CODPOSTAL) VALUES ('DeSegunda','Sevilla',41700);
INSERT INTO TIENDAS VALUES ('VendeloYa','Zaragoza','Videojuegos',50001);
INSERT INTO TIENDAS VALUES ('Babobibo','Madrid','Hogar',28002);
INSERT INTO TIENDAS VALUES ('Sanchez&Co','Malaga','Antiguedades',29001);
INSERT INTO TIENDAS VALUES ('cats&dogs','California','Mascotas',08811);
INSERT INTO TIENDAS VALUES ('Sanchez&Co','Malaga','Antiguedades',29001);


INSERT INTO VENDEDORES VALUES ('175','Alejandro','TURQUIA');
INSERT INTO VENDEDORES VALUES ('246','Ivan','ESPAÑA');
INSERT INTO VENDEDORES VALUES ('790','Evelyn','CANADA');
INSERT INTO VENDEDORES VALUES ('359','Larry','JAPON');

INSERT INTO ARTICULOS VALUES ('1780','Guitarra','175',6,'Reacondicionado',15.99);
INSERT INTO ARTICULOS VALUES ('1099','PS5','246',5,'Usado',750);
INSERT INTO ARTICULOS VALUES ('5846','Lanyard','790',0.27,'Nuevo',2.50);
INSERT INTO ARTICULOS VALUES ('7564','Fósil','359',30,'Usado',1500);

INSERT INTO PEDIDOS VALUES ('4652','Babobibo','5846','2019-05-18',3);
INSERT INTO PEDIDOS VALUES ('1827','VendeloYa','1780','2021-12-03',1);
INSERT INTO PEDIDOS VALUES ('2801','DeSegunda','1099','2022-01-06',1);
INSERT INTO PEDIDOS VALUES ('5764','Sanchez&Co','7564','2020-09-30',1);

INSERT INTO CLIENTES VALUES ('147','Babobibo','5846','2020-01-01');
INSERT INTO CLIENTES VALUES ('258','Sanchez&Co','7564','2022-03-27');
INSERT INTO CLIENTES VALUES ('369','VendeloYa','1780','2021-12-23');
INSERT INTO CLIENTES VALUES ('471','DeSegunda','1099','2022-02-28');