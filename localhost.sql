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

CREATE TABLE empresa
(
idEmpresa INT NOT NULL PRIMARY KEY,
nombreEmpresa VARCHAR2 (100)
);
CREATE TABLE sedeEmpresa
(
idSedeEmpresa INT NOT NULL PRIMARY KEY,
idEmpresa INT,
idPais INT,
idCiudad INT,
idEstado INT,
idDireccion INT,
CONSTRAINT fkEmpresa FOREIGN KEY (idEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT fkPais FOREIGN key (idPais) REFERENCES pais(idPais),
CONSTRAINT fkCiudad FOREIGN key (idCiudad) REFERENCES ciudad(idCiudad),
CONSTRAINT fkEstado FOREIGN key (idEstado) REFERENCES estado(idEstado),
CONSTRAINT fkDireccion FOREIGN key (idDireccion) REFERENCES direccion(idDireccion)
);
CREATE TABLE concurso
(
idConcurso INT NOT NULL PRIMARY KEY,
nombreConcurso VARCHAR2 (50) NOT NULL,
);
CREATE TABLE patrocinador
(
idPatrocinador INT NOT NULL PRIMARY KEY,
idSedeEmpresa INT,
idConcurso INT,
CONSTRAINT fkSedeEmpresa FOREIGN KEY (idSedeEmpresa) REFERENCES sedeEmpresa(idSedeEmpresa),
CONSTRAINT fkConcurso FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);
CREATE TABLE premio
(
idPremio INT NOT NULL PRIMARY KEY,
premio VARCHAR2 (100) NOT NULL,
puesto INT NOT NULL,
idConcurso INT,
CONSTRAINT fkConcurso FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);
CREATE TABLE acertijo
(
idAcertijo INT NOT NULL PRIMARY KEY,
fechaInicio DATETIME NOT NULL,
nombreAcertijo VARCHAR2 (100) NOT NULL,
xPosicion INT NOT NULL,
yPosicion INT NOT NULL,
idCiudad INT NOT NULL,
idPais INT ,
idEstado INT,
idConcurso INT,
CONSTRAINT fkPais FOREIGN KEY (idPais) REFERENCES pais(idPais),
CONSTRAINT fkCiudad FOREIGN KEY (idCiudad) REFERENCES ciudad(idCiudad),
CONSTRAINT fkEstado FOREIGN KEY (idEstado) REFERENCES estado(idEstado),
CONSTRAINT fkConcurso FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);
CREATE TABLE pista
(
idPista INT NOT NULL PRIMARY KEY,
pista VARCHAR2(200) NOT NULL,
idAcertijo INT,
CONSTRAINT fkAcertijo FOREIGN KEY (idAcertijo) REFERENCES acertijo(idAcertijo)
);
CREATE TABLE acertijoPorConcurso
(
idAcertijoPorConcurso INT NOT NULL PRIMARY KEY,
idAcertijo INT,
idConcurso INT,
CONSTRAINT fkAcertijo FOREIGN KEY (idAcertijo) REFERENCES acertijo(idAcertijo),
CONSTRAINT fkConcurso FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);
CREATE TABLE estado
(
    idEstado INT NOT NULL PRIMARY KEY,
    nombreEstado VARCHAR2 (50) NOT NULL UNIQUE
);
CREATE SEQUENCE idEstado MINVALUE 1 START WITH 1 CACHE 20;
CREATE TABLE participantePorConcurso
(
idParticipantePorConcurso INT NOT NULL PRIMARY KEY,
idParticipante INT,
idConcurso INT,
fechaInscripcion DATETIME,
CONSTRAINT fkConcurso FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso),
CONSTRAINT fkParticipante FOREIGN KEY (idParticipante) REFERENCES participante(idParticipante)
);