CREATE DATABASE IF NOT EXISTS pizzeria;

USE pizzeria;

CREATE TABLE IF NOT EXISTS Clients (
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(15),
    cognoms VARCHAR (40),
	adreca VARCHAR (40),
    codi_postal VARCHAR (6),
    localitat VARCHAR(40),
    provincia VARCHAR(40),
    telefon VARCHAR(6),
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Botigues (
	id INT NOT NULL AUTO_INCREMENT,
    adreca VARCHAR(40),
    codi_postal VARCHAR(6),
    localitat VARCHAR(40),
    província VARCHAR(40),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Empleats ( 
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(40),
    cognoms VARCHAR(40),
    NIF VARCHAR(9),
    telefon VARCHAR(9),
    categoria VARCHAR(40),
    CONSTRAINT CHECK (categoria IN ('Repartidor', 'Cuiner')),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Comandes (
	id INT NOT NULL AUTO_INCREMENT,
    datahora DATETIME,
    domicili BOOLEAN,
    clientID INT NOT NULL,
    botigaID INT NOT NULL,
    repartidorID INT,	
    lliurament DATETIME,
	PRIMARY KEY (id),
    FOREIGN KEY (clientID) REFERENCES Clients(id),
    FOREIGN KEY (botigaID) REFERENCES Botigues(id),
    FOREIGN KEY (repartidorID) REFERENCES Empleats(id)
);

CREATE TABLE IF NOT EXISTS CategoriaPizza (
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(20),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Productes (
	id INT NOT NULL AUTO_INCREMENT,
    tipus VARCHAR(20) NOT NULL,
    nom VARCHAR(40) NOT NULL,
    descripcio VARCHAR(255),
    idCategoriaPizza INT,
    imatge BLOB,
    preu INT,
    PRIMARY KEY (id),
    FOREIGN KEY (idCategoriaPizza) REFERENCES CategoriaPizza(id),
    CONSTRAINT CHECK (tipus IN ('Beguda', 'Hamburguesa', 'Pizza'))
);

CREATE TABLE IF NOT EXISTS DetallComanda (
	id INT NOT NULL AUTO_INCREMENT,
    idComanda INT NOT NULL,
    idProducte INT NOT NULL,
    quantitat INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idComanda) REFERENCES Comandes(id),
    FOREIGN KEY (idProducte) REFERENCES Productes(id)
);

-- Valores dummy creados con ChatGPT --

INSERT INTO Clients (nom, cognoms, adreca, codi_postal, localitat, provincia, telefon)
VALUES
    ('John', 'Doe', '123 Main St', '12345', 'Cityville', 'Provinceville', '555123'),
    ('Alice', 'Smith', '456 Elm St', '67890', 'Townville', 'Countyville', '555456'),
    ('Bob', 'Johnson', '789 Oak St', '54321', 'Villageville', 'Territoryville', '555789');

INSERT INTO Botigues (adreca, codi_postal, localitat, província)
VALUES
    ('101 Shop St', '12345', 'Cityville', 'Provinceville'),
    ('202 Store Ave', '67890', 'Townville', 'Countyville'),
    ('303 Market Rd', '54321', 'Villageville', 'Territoryville');
    
INSERT INTO Empleats (nom, cognoms, NIF, telefon, categoria)
VALUES
    ('David', 'Martinez', '123456789', '555111', 'Repartidor'),
    ('Laura', 'Garcia', '987654321', '555222', 'Repartidor'),
    ('Sara', 'Perez', '456123789', '555333', 'Cuiner');
    
INSERT INTO Comandes (datahora, domicili, clientID, botigaID, repartidorID, lliurament)
VALUES
    ('2023-09-11 10:00:00', TRUE, 1, 1, 1, '2023-09-11 12:00:00'),
    ('2023-09-12 11:30:00', FALSE, 2, 2, NULL, NULL),
    ('2023-09-13 14:45:00', TRUE, 3, 3, 2, '2023-09-13 16:30:00');
    
INSERT INTO CategoriaPizza (nom)
VALUES
    ('Clàssica'),
    ('Vegetariana'),
    ('Especial');
    
INSERT INTO Productes (tipus, nom, descripcio, idCategoriaPizza, imatge, preu)
VALUES
    ('Beguda', 'Coca-Cola', 'Refresc de cola 0,33L', NULL, NULL, 3),
    ('Pizza', 'Pizza Margherita', 'Tomàquet, mozzarella, albahaca', 1, NULL, 10),
    ('Pizza', 'Pizza Vegetariana', 'Verdures, formatge, salsa de tomàquet', 2, NULL, 12),
    ('Hamburguesa', 'Hamburguesa de Pollastre', 'Amb lletuga i tomàquet', NULL, NULL, 8),
    ('Pizza', 'Pizza Prosciutto', 'Formatge, prosciutto, salsa de tomàquet', 1, NULL, 11),
    ('Beguda', 'Aigua Mineral', 'Aigua embotellada 0,5L', NULL, NULL, 2),
    ('Hamburguesa', 'Hamburguesa de Vedella', 'Amb formatge i bacon', NULL, NULL, 9),
    ('Pizza', 'Pizza Quatre Formatges', 'Mozzarella, gorgonzola, parmesà, formatge de cabra', 2, NULL, 13);
    
INSERT INTO DetallComanda (idComanda, idProducte, quantitat)
VALUES
    (1, 1, 2),
    (1, 5, 1),
    (2, 2, 3),
    (3, 1, 1),
    (3, 6, 2);
    
-- Consultes --
-- Llista quants productes de tipus “Begudes”. s'han venut en una determinada localitat.

SELECT COUNT(*) AS TotalBegudes
FROM DetallComanda 
JOIN Productes ON DetallComanda.id = Productes.id 
JOIN Comandes ON DetallComanda.id = Comandes.id 
JOIN Botigues ON Comandes.botigaID = Botigues.id 
WHERE Productes.tipus = 'Beguda' AND Botigues.localitat = 'Cityville';	

SELECT Comandes.id AS NumeroComanda, Comandes.datahora, Comandes.lliurament, Empleats.nom, Empleats.cognoms FROM Comandes JOIN Empleats ON Empleats.id = Comandes.repartidorID WHERE Empleats.id = 1;