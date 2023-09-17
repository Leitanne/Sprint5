CREATE DATABASE IF NOT EXISTS Spotify;

USE Spotify;

CREATE TABLE Targetes (
	id INT NOT NULL AUTO_INCREMENT,
    numero VARCHAR(16),
	caducitat VARCHAR(5),
    CVV VARCHAR(3),
    PRIMARY KEY(id)
);

CREATE TABLE Paypal (
	id INT NOT NULL AUTO_INCREMENT,
    usuari VARCHAR(255),
    PRIMARY KEY(id)
);

CREATE TABLE Subscripcions (
	id INT NOT NULL AUTO_INCREMENT,
    dataInici DATE,
    dataRenovacio DATE,
    formaPagament VARCHAR(17),
    idTargeta INT,
    idPaypal INT,
    CONSTRAINT CHECK (formaPagament IN('Paypal', 'Targeta de credit')),
    PRIMARY KEY(id),
	UNIQUE KEY (idTargeta),
	UNIQUE KEY (idPaypal),
    FOREIGN KEY (idTargeta) REFERENCES Targetes(id),
    FOREIGN KEY (idPayPal) REFERENCES PayPal(id)
);

CREATE TABLE Usuaris (
	id INT NOT NULL AUTO_INCREMENT,
    tipus VARCHAR(7),
    email VARCHAR(20),
    password VARCHAR(30),
    usuari VARCHAR(30),
    dataNaixement DATE,
    sexe VARCHAR(10),
    pais VARCHAR(20),
    codi_postal VARCHAR(6),
    idSubscripcio INT,
    CONSTRAINT CHECK (tipus IN ('free', 'premium')),
    CONSTRAINT CHECK (sexe IN ('Hombre', 'Mujer', 'No Binario')),
    FOREIGN KEY (idSubscripcio) REFERENCES Subscripcions(id),
    UNIQUE KEY (idSubscripcio),
    PRIMARY KEY (id)
);

CREATE TABLE Pagaments (
	numeroOrdre INT NOT NULL UNIQUE,
    dataPagament DATE,
    idUsuari INT NOT NULL,
    total DECIMAL (10, 2),
    PRIMARY KEY(numeroOrdre),
    FOREIGN KEY (idUsuari) REFERENCES Usuaris(id)
);

CREATE TABLE Playlist (
	id INT NOT NULL AUTO_INCREMENT,
    titol VARCHAR(50),
    quantitat INT,
    dataCreacio DATE,
    usuariPropietariID INT,
    eliminada BOOLEAN,
    dataEliminacio DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (usuariPropietariID) REFERENCES Usuaris(id)
);

CREATE TABLE Artistes (
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50),
    imatge BLOB,
    PRIMARY KEY(id)
);

CREATE TABLE Album (
	id INT NOT NULL AUTO_INCREMENT,
    titol VARCHAR(50),
    anyPublicacio YEAR,
    portada BLOB,
    artistaID INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (artistaID) REFERENCES Artistes(id)
);

CREATE TABLE Cancons (
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50),
    durada INT,
    reproduccions INT,
    albumID INT,
    PRIMARY KEY (id),
    FOREIGN KEY (albumID) REFERENCES Album(id)
);

CREATE TABLE PlaylistDetall (
    id INT NOT NULL AUTO_INCREMENT,
    playlistID INT,
    usuariID INT,
    cancoID INT,
    dataAfegida DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (playlistID) REFERENCES Playlist(id),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id),
    FOREIGN KEY (cancoID) REFERENCES Cancons(id)
);

CREATE TABLE Seguiments (
	id INT NOT NULL AUTO_INCREMENT,
    artistaID INT NOT NULL,
    usuariID INT NOT NULL,
    UNIQUE KEY (artistaID, usuariID),
    PRIMARY KEY(id),
    FOREIGN KEY (artistaID) REFERENCES Artistes(id),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id)
);

CREATE TABLE ArtistesRelacionats (
	id INT NOT NULL AUTO_INCREMENT,
    artistaID INT NOT NULL,
    artistaID2 INT NOT NULL,
    UNIQUE KEY (artistaID, artistaID2),
    PRIMARY KEY (id),
    FOREIGN KEY (artistaID) REFERENCES Artistes(id),
    FOREIGN KEY (artistaID2) REFERENCES Artistes(id)
);

CREATE TABLE AlbumsPreferits (
	id INT NOT NULL AUTO_INCREMENT,
    albumID INT NOT NULL,
    usuariID INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (albumID, usuariID),
    FOREIGN KEY (albumID) REFERENCES Album(id),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id)
);

CREATE TABLE CanconsPreferides (
	id INT NOT NULL AUTO_INCREMENT,
    cancoID INT NOT NULL,
    usuariID INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (cancoID, usuariID),
    FOREIGN KEY (cancoID) REFERENCES Cancons(id),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id)
);