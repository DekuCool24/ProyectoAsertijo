-----------------------------------------------------------------------------------------------
--Creacion de las tablas
-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------
--Tabla Pais
--  Contiene todos los paices que estan participando en los concursos, ademas de los paices de 
--donde viene cada participante
-----------------------------------------------------------------------------------------------

CREATE TABLE pais

(
    idPais INT NOT NULL PRIMARY KEY,
    nombrePais VARCHAR2 (50) NOT NULL UNIQUE
);

CREATE SEQUENCE idPais MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE pais;
--DROP SEQUENCE idPais;

-----------------------------------------------------------------------------------------------
--Tabla Ciudad
--  Contiene todos los nombres de las ciudades donde se esta llevando a cabo un concurso, 
--ademas de las ciudades de donde provienen los participantes.
-----------------------------------------------------------------------------------------------

CREATE TABLE ciudad 

(
    idCiudad INT NOT NULL PRIMARY KEY,
    nombreCiudad VARCHAR2 (50) NOT NULL UNIQUE
);

CREATE SEQUENCE idCiudad MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE ciudad;
--DROP SEQUENCE idCiudad;

-----------------------------------------------------------------------------------------------
--Tabla Estado
--  Contiene los nombres de los estados de las cuidades, los lugares, donde se esta efectuando 
--un concurso. Contiene tambien los nombres de los estados de donde proviene los participantes.
-----------------------------------------------------------------------------------------------

CREATE TABLE estado

(
    idEstado INT NOT NULL PRIMARY KEY,
    estado VARCHAR2 (50)
);

CREATE SEQUENCE idEstado MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE estado;
--DROP SEQUENCE idEstado;

-----------------------------------------------------------------------------------------------
--Tabla Direccion
--  Contiene las direcciones detalladas de donde se estan realizando los concursos. Contiene 
--ademas las direcciones detallas de donde provienen los participantes.
-----------------------------------------------------------------------------------------------

CREATE TABLE direccion

(
    idDireccion INT NOT NULL PRIMARY KEY,
    DireccionEspecifica VARCHAR2 (50) NOT NULL
);

CREATE SEQUENCE idDireccion MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE direccion;
--DROP SEQUENCE idDireccion;

-----------------------------------------------------------------------------------------------
--Tabla Participante
--  Contiene la informacion ( (Pais, Ciudad, Estado), Direccion, Nombre, Telefono, Contrasena, 
--Email) de todos los participantes que iniciaron sesicion en la aplicacion.
-----------------------------------------------------------------------------------------------

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

--DROP TABLE participante;
--DROP SEQUENCE idParticipante;

-----------------------------------------------------------------------------------------------
--Tabla Empresa
--  Contiene los nombres de las empresas que estan patrocinando a los concursos.
-----------------------------------------------------------------------------------------------

CREATE TABLE empresa

(
    idEmpresa INT NOT NULL PRIMARY KEY,
    nombreEmpresa VARCHAR2 (100)
);

CREATE SEQUENCE idEmpresa MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE empresa;
--DROP SEQUENCE idEmpresa;

-----------------------------------------------------------------------------------------------
--Tabla SedeEmpresa
-- Contiene informacion (Pais, Ciudad, Estado y Direccion, asi como el id de la empresa) de la 
--sede de donde proviene las empresas (dichas empresas estan en la tabla empresa).
-----------------------------------------------------------------------------------------------

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

--DROP TABLE sedeEmpresa;
--DROP SEQUENCE idSedeEmpresa;

-----------------------------------------------------------------------------------------------
--Tabla Concurso
--  Contiene los nombres de los concursos de la aplicacion.
-----------------------------------------------------------------------------------------------

CREATE TABLE concurso

(
    idConcurso INT NOT NULL PRIMARY KEY,
    nombreConcurso VARCHAR2 (50) NOT NULL
);

CREATE SEQUENCE idConcurso MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE concurso;
--DROP SEQUENCE idConcurso;

-----------------------------------------------------------------------------------------------
--Tabla Patrocinador
-- Contiene la relacion entre las empresas (por medio de su sede) y los concursos que estan 
--patrocinando.
-----------------------------------------------------------------------------------------------

CREATE TABLE patrocinador

(
    idPatrocinador INT NOT NULL PRIMARY KEY,
    idSedeEmpresa INT,
    idConcurso INT,
    CONSTRAINT fkSedeEmpresaPatrocinador FOREIGN KEY (idSedeEmpresa) REFERENCES sedeEmpresa(idSedeEmpresa),
    CONSTRAINT fkConcursoPatrocinador FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);

CREATE SEQUENCE idPatrocinador MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE patrocinador;
--DROP SEQUENCE idPatrocinador;


-----------------------------------------------------------------------------------------------
--Tabla Premio
--  Esta Tabla contiene la descripcion de los premio que se van a otorgar al primer, segundo,
--tercer lugares. Ademas de algunos premios extra a los participantes.
-----------------------------------------------------------------------------------------------

CREATE TABLE premio

(
    idPremio INT NOT NULL PRIMARY KEY,
    premio VARCHAR2 (100) NOT NULL,
    puesto INT NOT NULL,
    idConcurso INT,
    CONSTRAINT fkConcurso FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);

CREATE SEQUENCE idPremio MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE premio;
--DROP SEQUENCE idPremio;


-----------------------------------------------------------------------------------------------
--Tabla Acertijo
-- Esta tabla contiene la informacion (fecha en que se inicio el acertijo, las posiciones X y Y 
--de donde se ubica la solucion al acertijo, (el pais, ciudad y estado del concurso del que 
--pertenece el acertijo), la refencia del concurso al que pertenece dicho acertijo) de los 
--acertijos que tiene cada concurso.
-----------------------------------------------------------------------------------------------

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

--DROP TABLE acertijo;
--DROP SEQUENCE idAcertijo;


-----------------------------------------------------------------------------------------------
--Tabla Pista
-- Contiene las pistas que tiene los acertijos. Tiene la descripcion de la pista y la referencia
--al acertijo que pertenece dicha pista.
-----------------------------------------------------------------------------------------------

CREATE TABLE pista

(
    idPista INT NOT NULL PRIMARY KEY,
    pista VARCHAR2(200) NOT NULL,
    idAcertijo INT,
    CONSTRAINT fkAcertijoPista FOREIGN KEY (idAcertijo) REFERENCES acertijo(idAcertijo)
);

CREATE SEQUENCE idPista MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE pista;
--DROP SEQUENCE idPista;

-----------------------------------------------------------------------------------------------
--Tabla PistaPorParticipante
-- Contiene la relacion entre los participantes y cuales pistas tiene cada uno. Ademas contiene
--la fecha en que cada pista fue enviada.
-----------------------------------------------------------------------------------------------

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

--DROP TABLE pistaPorParticipante;
--DROP SEQUENCE idPistaPorParticipante;

-----------------------------------------------------------------------------------------------
--Tabla AcertijoPorConcurso
-- Contiene informacion sobre cuales acertijos les pertenecen a cada uno de los concursos.
-----------------------------------------------------------------------------------------------

CREATE TABLE acertijoPorConcurso

(
    idAcertijoPorConcurso INT NOT NULL PRIMARY KEY,
    idAcertijo INT,
    idConcurso INT,
    CONSTRAINT fkAcertijoPorConcurso FOREIGN KEY (idAcertijo) REFERENCES acertijo(idAcertijo),
    CONSTRAINT fkConcursoPorAcertijo FOREIGN KEY (idConcurso) REFERENCES concurso(idConcurso)
);

CREATE SEQUENCE idAcertijoPorConcurso MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE acertijoPorConcurso;
--DROP SEQUENCE idAcertijoPorConcurso;

-----------------------------------------------------------------------------------------------
--Tabla EstadoAcertijo
-- Contiene informacion sobre el estado del Acertijo (si este esta iniciado o terminado).
-----------------------------------------------------------------------------------------------

CREATE TABLE estadoAcertijo

(
    idEstadoAcertijo INT NOT NULL PRIMARY KEY,
    nombreEstadoAcertijo VARCHAR2 (50) NOT NULL UNIQUE
);

CREATE SEQUENCE idEstadoAcertijo MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE estadoAcertijo;
--DROP SEQUENCE idEstadoAcertijo;

-----------------------------------------------------------------------------------------------
--Tabla ParticipantePorConcurso
-- Contiene informacion sobre en cuantos concursos estan inscritos los participantes. Contiene
--ademas la fecha en la que los participantes se escribieron en dichos concursos.
-----------------------------------------------------------------------------------------------

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

--DROP TABLE participantePorConcurso;
--DROP SEQUENCE idParticipantePorConcurso;


-----------------------------------------------------------------------------------------------
--Tabla ParticipantePorAcertijo
-- Contiene informacion sobre cuantos acertijos tiene cada participante. Tiene ademas la fecha
--en que hizo el ultimo intento y el numero de intentos ha tenido por acertijo.
-----------------------------------------------------------------------------------------------

CREATE TABLE participantePorAcertijo

(
    idParticipantePorAcertijo INT NOT NULL PRIMARY KEY,
    fechaUltimoIntento DATE NOT NULL,
    numeroIntento INT NOT NULL,
    idAcertijo INT,
    idEstadoAcertijo INT,
    idParticipante INT,
    CONSTRAINT fkParticipantePorAcertijo FOREIGN KEY (idParticipante) REFERENCES participante(idParticipante),
    CONSTRAINT fkAcertijoPorParticipante FOREIGN KEY (idAcertijo) REFERENCES acertijo(idAcertijo),
    CONSTRAINT fkEstadoPorParticipante FOREIGN key (idEstadoAcertijo) 
    REFERENCES estadoAcertijo(idEstadoAcertijo)
);

CREATE SEQUENCE idParticipantePorAcertijo MINVALUE 1 START WITH 1 CACHE 20;

--DROP TABLE participantePorAcertijo;
--DROP SEQUENCE idParticipantePorAcertijo;


-----------------------------------------------------------------------------------------------
--Tabla Ganador
-- Contiene informacion sobre cuales participantes han ganado los concursos. Tiene ademas la 
--fecha en que gano el concurso
-----------------------------------------------------------------------------------------------

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

--DROP TABLE ganador;
--DROP SEQUENCE idGanador;

-----------------------------------------------------------------------------------------------

