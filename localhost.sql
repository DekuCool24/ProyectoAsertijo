--DROP TABLE pais;
CREATE TABLE pais
(
idPais INT NOT NULL PRIMARY KEY,
nombrePais VARCHAR2 (50) NOT NULL UNIQUE
);
--DROP SEQUENCE idPais;
CREATE SEQUENCE idPais MINVALUE 1 START WITH 1 CACHE 20;
SELECT * FROM pais;
--INSERT INTO pais VALUES(idPais.nextval,'nombrePais');
CREATE TABLE estado
(
    idEstado INT NOT NULL PRIMARY KEY,
    nombreEstado VARCHAR2 (50) NOT NULL UNIQUE
);
CREATE SEQUENCE idEstado MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE ciudad
(
    idCiudad INT NOT NULL PRIMARY KEY,
    nombreCiudad VARCHAR2 (50) NOT NULL UNIQUE
);
CREATE SEQUENCE idCiudad MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE direccion
(
    idDireccion INT NOT NULL PRIMARY KEY,
    DireccionEspecifica VARCHAR2 (50) NOT NULL
);
CREATE SEQUENCE idDireccion MINVALUE 1 START WITH 1 CACHE 20;






CREATE TABLE participante

 idParticipante INT NOT NULL,
 nombreParticipante VARCHAR2 (100) NOT NULL,
 telefonoParticipante INT NOT NULL,
 contrasena VARCHAR2 (20) NOT NULL,
 emailParticipante VARCHAR2(50)
);