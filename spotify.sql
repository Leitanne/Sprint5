CREATE DATABASE IF NOT EXISTS Spotify;

USE Spotify;

CREATE TABLE Usuaris (
	id INT NOT NULL AUTO_INCREMENT,
    tipus VARCHAR(7),
    email VARCHAR(20),
    password VARCHAR(30),
    usuari VARCHAR(30),
    dataNeixament DATE,
    sexe VARCHAR(10),
    pais VARCHAR(20),
    codi_postal VARCHAR(6),
    CONSTRAINT CHECK (tipus IN ('free', 'premium')),
    CONSTRAINT CHECK (sexe IN ('Hombre', 'Mujer', 'No Binario')),
    PRIMARY KEY (id)
);