--DROP TABLE pais;
CREATE TABLE pais
(
idPais INT NOT NULL PRIMARY KEY,
nombrePais VARCHAR2 (50) NOT NULL UNIQUE
);
--DROP SEQUENCE idPais;
CREATE SEQUENCE idPais MINVALUE 1 START WITH 1 CACHE 20;
--INSERT INTO pais VALUES(idPais.nextval,'nombrePais');
CREATE TABLE ciudad
(
    idCiudad INT NOT NULL PRIMARY KEY,
    nombreCiudad VARCHAR2 (50) NOT NULL UNIQUE
);
CREATE SEQUENCE idCiudad MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE estado
(
idEstado INT NOT NULL PRIMARY KEY,
estado VARCHAR2 (50)
);
CREATE SEQUENCE idEstado MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE direccion
(
    idDireccion INT NOT NULL PRIMARY KEY,
    DireccionEspecifica VARCHAR2 (50) NOT NULL
);
CREATE SEQUENCE idDireccion MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE participante
(
 idParticipante INT NOT NULL PRIMARY KEY,
 idPais INT,
 idCiudad INT,
 idEstado INT,
 idDireccion INT,
 nombreParticipante VARCHAR2 (100) NOT NULL,
 telefonoParticipante INT NOT NULL,
 contrasena VARCHAR2 (20) NOT NULL,
 emailParticipante VARCHAR2(50),
 CONSTRAINT fkPais FOREIGN key (idPais) REFERENCES pais(idPais),
 CONSTRAINT fkCiudad FOREIGN key (idCiudad) REFERENCES ciudad(idCiudad),
 CONSTRAINT fkEstado FOREIGN key (idEstado) REFERENCES estado(idEstado),
 CONSTRAINT fkDireccion FOREIGN key (idDireccion) REFERENCES direccion(idDireccion)
);
CREATE SEQUENCE idParticipante MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE empresa
(
idEmpresa INT NOT NULL PRIMARY KEY,
nombreEmpresa VARCHAR2 (100)
);
CREATE SEQUENCE idEmpresa MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE sedeEmpresa
(
idSedeEmpresa INT NOT NULL PRIMARY KEY,
idEmpresa INT,
idPais INT,
idCiudad INT,
idEstado INT,
idDireccion INT,
CONSTRAINT fkEmpresaSedeEmpresa FOREIGN KEY (idEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT fkPaisSedeEmpresa FOREIGN key (idPais) REFERENCES pais(idPais),
CONSTRAINT fkCiudadSedeEmpresa FOREIGN key (idCiudad) REFERENCES ciudad(idCiudad),
CONSTRAINT fkEstadoSedeEmpresa FOREIGN key (idEstado) REFERENCES estado(idEstado),
CONSTRAINT fkDireccionSedeEmpresa FOREIGN key (idDireccion) REFERENCES direccion(idDireccion)
);
CREATE SEQUENCE idSedeEmpresa MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE concurso
(
idConcurso INT NOT NULL PRIMARY KEY,
nombreConcurso VARCHAR2 (50) NOT NULL
);
CREATE SEQUENCE idConcurso MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE patrocinador
(
idPatrocinador INT NOT NULL PRIMARY KEY,
idSedeEmpresa INT,
idConcurso INT,
CONSTRAINT fkSedeEmpresaPatrocinador FOREIGN KEY (idSedeEmpresa) REFERENCES sedeEmpresa(idSedeEmpresa),
CONSTRAINT fkConcursoPatrocinador FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);
CREATE SEQUENCE idPatrocinador MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE premio
(
idPremio INT NOT NULL PRIMARY KEY,
premio VARCHAR2 (100) NOT NULL,
puesto INT NOT NULL,
idConcurso INT,
CONSTRAINT fkConcurso FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);
CREATE SEQUENCE idPremio MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE acertijo
(
idAcertijo INT NOT NULL PRIMARY KEY,
fechaInicio DATE NOT NULL,
nombreAcertijo VARCHAR2 (100) NOT NULL,
xPosicion INT NOT NULL,
yPosicion INT NOT NULL,
idCiudad INT NOT NULL,
idPais INT ,
idEstado INT,
idConcurso INT,
CONSTRAINT fkPaisAcertijo FOREIGN KEY (idPais) REFERENCES pais(idPais),
CONSTRAINT fkCiudadAcertijo FOREIGN KEY (idCiudad) REFERENCES ciudad(idCiudad),
CONSTRAINT fkEstadoAcertijo FOREIGN KEY (idEstado) REFERENCES estado(idEstado),
CONSTRAINT fkConcursoAcertijo FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);
CREATE SEQUENCE idAcertijo MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE pista
(
idPista INT NOT NULL PRIMARY KEY,
pista VARCHAR2(200) NOT NULL,
idAcertijo INT,
CONSTRAINT fkAcertijoPista FOREIGN KEY (idAcertijo) REFERENCES acertijo(idAcertijo)
);
CREATE SEQUENCE idPista MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE pistaPorParticipante
(
idPistaPorParticipante INT NOT NULL PRIMARY KEY,
idParticipante INT,
idPista INT,
fechaEnvioPista DATE,
CONSTRAINT fkParticipantePista FOREIGN KEY (idParticipante) REFERENCES participante(idParticipante),
CONSTRAINT fkPistaPistaPorParticipante FOREIGN KEY (idPista) REFERENCES pista(idPista)
);
CREATE SEQUENCE idPistaPorParticipante MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE acertijoPorConcurso
(
idAcertijoPorConcurso INT NOT NULL PRIMARY KEY,
idAcertijo INT,
idConcurso INT,
CONSTRAINT fkAcertijoPorConcurso FOREIGN KEY (idAcertijo) REFERENCES acertijo(idAcertijo),
CONSTRAINT fkConcursoPorAcertijo FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);
CREATE SEQUENCE idAcertijoPorConcurso MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE estadoParticipanteAcertijo
(
idEstadoParticipanteAcertijo INT NOT NULL PRIMARY KEY,
nombreEstadoParticipanteAcertijo VARCHAR2 (50) NOT NULL UNIQUE
);
CREATE SEQUENCE idEstadoParticipanteAcertijo MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE participantePorConcurso
(
idParticipantePorConcurso INT NOT NULL PRIMARY KEY,
idParticipante INT,
idConcurso INT,
fechaInscripcion DATE,
CONSTRAINT fkConcursoPorParticipante FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso),
CONSTRAINT fkParticipantePorConcurso FOREIGN KEY (idParticipante) REFERENCES participante(idParticipante)
);
CREATE SEQUENCE idParticipantePorConcurso MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE participantePorAcertijo
(
idParticipantePorAcertijo INT NOT NULL PRIMARY KEY,
fechaUltimoIntento DATE NOT NULL,
numeroIntento INT NOT NULL,
idAcertijo INT,
idEstadoParticipanteAcertijo INT,
idParticipante INT,
CONSTRAINT fkParticipantePorAcertijo FOREIGN KEY (idParticipante) REFERENCES participante(idParticipante),
CONSTRAINT fkAcertijoPorParticipante FOREIGN KEY (idAcertijo) REFERENCES acertijo(idAcertijo),
CONSTRAINT fkEstadoPorParticipante FOREIGN key (idEstadoParticipanteAcertijo) REFERENCES estadoParticipanteAcertijo(idEstadoParticipanteAcertijo)
);
CREATE SEQUENCE idParticipantePorAcertijo MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE ganador
(
idGanador INT NOT NULL PRIMARY KEY,
fechaVictoria DATE NOT NULL,
idConcurso INT,
idParticipante INT,
CONSTRAINT fkParticipanteGanador FOREIGN KEY (idParticipante) REFERENCES participante(idParticipante),
CONSTRAINT fkConcursoGanador FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);
CREATE SEQUENCE idGanador MINVALUE 1 START WITH 1 CACHE 20;

--Llenado de bases de datos 
--Insert de tabla pais
INSERT INTO pais VALUES (idPais.nextval,'Costa Rica');
INSERT INTO pais VALUES (idPais.nextval,'Puerto Rico');
INSERT INTO pais VALUES (idPais.nextval,'Guatemala');
INSERT INTO pais VALUES (idPais.nextval,'Argentina');
INSERT INTO pais VALUES (idPais.nextval,'Panama');
SELECT * FROM pais;
--Insert de tabla ciudad
INSERT INTO ciudad VALUES (idCiudad.nextval,'Cartago');
INSERT INTO ciudad VALUES (idCiudad.nextval,'San Jose');
INSERT INTO ciudad VALUES (idCiudad.nextval,'Victoria');
INSERT INTO ciudad VALUES (idCiudad.nextval,'San Ramon');
INSERT INTO ciudad VALUES (idCiudad.nextval,'AguaCaliente');
INSERT INTO ciudad VALUES (idCiudad.nextval,'Cartajena');
INSERT INTO ciudad VALUES (idCiudad.nextval,'Prosperos');
INSERT INTO ciudad VALUES (idCiudad.nextval,'Menrique');
SELECT * FROM ciudad;
--Insert de tabla direccion
INSERT INTO direccion VALUES (idDireccion.nextval,'50 al oeste de la piedra amarilla');
INSERT INTO direccion VALUES (idDireccion.nextval,'Al frente del pali');
INSERT INTO direccion VALUES (idDireccion.nextval,'A la par de la iglesia');
INSERT INTO direccion VALUES (idDireccion.nextval,'Diagonal a la estacion del tren');
INSERT INTO direccion VALUES (idDireccion.nextval,'Arriba de PapusBar');
INSERT INTO direccion VALUES (idDireccion.nextval,'50 al este de la piedra verde');
INSERT INTO direccion VALUES (idDireccion.nextval,'150 al oeste de la piedra amarilla');
INSERT INTO direccion VALUES (idDireccion.nextval,'50 al sur de la piedra de la iglesia');
INSERT INTO direccion VALUES (idDireccion.nextval,'25 norte de la iglesia');
SELECT * FROM direccion;
--Insert de tabla estado
INSERT INTO estado VALUES (idEstado.nextval,'Carmen');
INSERT INTO estado VALUES (idEstado.nextval,'San Rafael');
INSERT INTO estado VALUES (idEstado.nextval,'Bruos');
INSERT INTO estado VALUES (idEstado.nextval,'Mangare');
INSERT INTO estado VALUES (idEstado.nextval,'Aza');
SELECT * FROM estado;
--Insert de tabla participante

INSERT INTO participante VALUES (idParticipante.nextval,1,1,1,1,'Geralt de Rivia',11111,'Triss','g@TW3.com');
INSERT INTO participante VALUES (idParticipante.nextval,2,2,2,2,'Cirilla de Cintra',11311,'WhereIam','Ciri@TW3.com');
INSERT INTO participante VALUES (idParticipante.nextval,3,3,3,3,'Yennefer de Vengerberg',21111,'Geralt','Yen@TW3.com');
INSERT INTO participante VALUES (idParticipante.nextval,4,4,4,4,'Triss Merigold',11431,'Geralt','Fire@TW3.com');
INSERT INTO participante VALUES (idParticipante.nextval,5,5,5,5,'Emiel Regis',65411,'bloodandVine','Dblood@TW3.com');
SELECT * FROM participante;