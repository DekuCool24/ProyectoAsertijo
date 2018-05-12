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
idEstado INT,
idParticipante INT,
CONSTRAINT fkParticipantePorAcertijo FOREIGN KEY (idParticipante) REFERENCES participante(idParticipante),
CONSTRAINT fkAcertijoPorParticipante FOREIGN KEY (idAcertijo) REFERENCES acertijo(idAcertijo),
CONSTRAINT fkEstadoPorParticipante FOREIGN key (idEstado) REFERENCES estado(idEstado)
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
