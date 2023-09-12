CREATE DATABASE pizzeria;

USE pizzeria;

CREATE TABLE clientes (
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(15),
    cognoms VARCHAR (40),
	adreca VARCHAR (40),
    codi_postal VARCHAR (6),
    localitat VARCHAR(30),
    provincia VARCHAR(40),
    telefon VARCHAR(6)
);

CREATE TABLE comandes (
	id INT NOT NULL AUTO_INCREMENT,
    datahora DATETIME,
    domicili BOOLEAN,
    productes INT
);
