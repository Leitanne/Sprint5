CREATE DATABASE IF NOT EXISTS Youtube;

USE Youtube;

CREATE TABLE Usuaris (
	id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(20) UNIQUE,
    password VARCHAR(20),
    usuari VARCHAR(15),
    data_neixament DATE,
    sexe VARCHAR(10),
    pais VARCHAR(20),
    codi_postal VARCHAR(6),
    CONSTRAINT CHECK(sexe IN ('Mujer', 'Hombre', 'No binario')),
    PRIMARY KEY (id)
);

CREATE TABLE Etiquetes (
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(30),
    PRIMARY KEY(id)
);

CREATE TABLE Videos (
	id INT NOT NULL AUTO_INCREMENT,
    titol VARCHAR(50),
    descripció VARCHAR(255),
    grandària DECIMAL,
    nom_arxiu VARCHAR(20),
    duradaMinuts DECIMAL(5, 2),
    miniatura BLOB,
    reproduccions INT,
    likes INT,
    dislikes INT,
    estat VARCHAR(6),
    usuariID INT NOT NULL,
    dataHoraPublicacio DATETIME,
    CONSTRAINT CHECK (estat IN ('public', 'ocult', 'privat')),
    PRIMARY KEY (id),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id)
);

CREATE TABLE DetallEtiquetes(
	id INT NOT NULL AUTO_INCREMENT,
    idVideo INT NOT NULL,
    idEtiqueta INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idVideo) REFERENCES Videos(id),
    FOREIGN KEY (idEtiqueta) REFERENCES Etiquetes(id)
);

CREATE TABLE Canals(
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(15)	,
    descripcio VARCHAR(255),
    dataCreacio DATE,
    usuariID INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id)
);

CREATE TABLE Subscriptors (
	id INT NOT NULL AUTO_INCREMENT,
	canalID INT NOT NULL,
    usuariID INT NOT NULL,
    PRIMARY KEY(id),
    UNIQUE KEY (canalID, usuariID),
    FOREIGN KEY (canalID) REFERENCES Canals(id),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id)
);

CREATE TABLE LikesVideo (
	id INT NOT NULL AUTO_INCREMENT,
    usuariID INT NOT NULL,
    videoID INT NOT NULL,
    liAgrada BOOLEAN NOT NULL,
    dataHora DATETIME NOT NULL,
    UNIQUE KEY(usuariID, videoID),
    PRIMARY KEY (id),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id),
    FOREIGN KEY (videoID) REFERENCES Videos(id)
);

CREATE TABLE Playlists (
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(20),
    dataCreacio DATE,
    estat VARCHAR(7),
    usuariID INT,
    PRIMARY KEY (id),
    CONSTRAINT CHECK (estat IN('privada', 'publica')),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id)
);

CREATE TABLE Comentaris (
	id INT NOT NULL AUTO_INCREMENT,
    comentari VARCHAR(255),
    dataHora DATETIME,
    usuariID INT NOT NULL,
    videoID INT NOT NULL,
	PRIMARY KEY (id),
    UNIQUE KEY(usuariID, videoID),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id),
    FOREIGN KEY (videoID) REFERENCES Videos(id)
);

CREATE TABLE likesComentaris (
	id INT NOT NULL AUTO_INCREMENT,
    liAgrada BOOLEAN NOT NULL,
    dataHora DATETIME NOT NULL,
    comentariID INT NOT NULL,
    usuariID INT NOT NULL,
    PRIMARY KEY(id),
	UNIQUE KEY(usuariID, comentariID),
    FOREIGN KEY (usuariID) REFERENCES Usuaris(id),
    FOREIGN KEY (comentariID) REFERENCES Comentaris(id)
);

-- Valors de test creats amb ChatGPT --
-- Insert data into the Usuaris table
INSERT INTO Usuaris (email, password, usuari, data_neixament, sexe, pais, codi_postal)
VALUES
    ('user1@example.com', 'password1', 'user1', '1990-01-01', 'Hombre', 'Spain', '12345'),
    ('user2@example.com', 'password2', 'user2', '1995-02-15', 'Mujer', 'USA', '54321'),
    ('user3@example.com', 'password3', 'user3', '1988-11-10', 'No binario', 'Canada', '67890');

-- Insert data into the Etiquetes table
INSERT INTO Etiquetes (nom)
VALUES
    ('Technology'),
    ('Music'),
    ('Travel'),
    ('Cooking');

-- Insert data into the Videos table
INSERT INTO Videos (titol, descripció, grandària, nom_arxiu, duradaMinuts, miniatura, reproduccions, likes, dislikes, estat, usuariID, dataHoraPublicacio)
VALUES
    ('Video 1', 'Description for Video 1', 1024.50, 'video1.mp4', 10.5, NULL, 1000, 50, 5, 'public', 1, NOW()),
    ('Video 2', 'Description for Video 2', 2048.75, 'video2.mp4', 15.25, NULL, 800, 60, 8, 'public', 2, NOW()),
    ('Video 3', 'Description for Video 3', 512.25, 'video3.mp4', 5.75, NULL, 1200, 45, 3, 'public', 3, NOW());

-- Insert data into the DetallEtiquetes table
INSERT INTO DetallEtiquetes (idVideo, idEtiqueta)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Insert data into the Canals table
INSERT INTO Canals (nom, descripcio, dataCreacio, usuariID)
VALUES
    ('Channel 1', 'Description for Channel 1', '2022-01-01', 1),
    ('Channel 2', 'Description for Channel 2', '2022-02-15', 2),
    ('Channel 3', 'Description for Channel 3', '2022-03-10', 3);

-- Insert data into the Subscriptors table
INSERT INTO Subscriptors (canalID, usuariID)
VALUES
    (1, 2),
    (2, 3),
    (3, 1);

-- Insert data into the LikesVideo table
INSERT INTO LikesVideo (usuariID, videoID, liAgrada, dataHora)
VALUES
    (1, 2, TRUE, NOW()),
    (2, 3, TRUE, NOW()),
    (3, 1, TRUE, NOW());

-- Insert data into the Playlists table
INSERT INTO Playlists (nom, dataCreacio, estat, usuariID)
VALUES
    ('My Playlist 1', '2022-01-05', 'publica', 1),
    ('My Playlist 2', '2022-02-20', 'privada', 2);

-- Insert data into the Comentaris table
INSERT INTO Comentaris (comentari, dataHora, usuariID, videoID)
VALUES
    ('Great video!', NOW(), 1, 1),
    ('Nice content!', NOW(), 2, 2),
    ('Awesome!', NOW(), 3, 3);

-- Insert data into the likesComentaris table
INSERT INTO likesComentaris (liAgrada, dataHora, comentariID, usuariID)
VALUES
    (TRUE, NOW(), 1, 2),
    (TRUE, NOW(), 2, 3),
    (TRUE, NOW(), 3, 1);