CREATE DATABASE IF NOT EXISTS optica;

USE optica;

CREATE TABLE IF NOT EXISTS proveidors(
	id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(20) NOT NULL,
    carrer VARCHAR(50),
    numero VARCHAR(5),
    pis VARCHAR(2),
    porta VARCHAR(5),
    ciutat VARCHAR(15) NOT NULL,
    codi_postal VARCHAR(5) NOT NULL,
    pais VARCHAR(20) NOT NULL,
    telefon VARCHAR(12) NOT NULL,
    fax VARCHAR(12),
    NIF VARCHAR(9) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS empleats (
	id INT NOT NULL AUTO_INCREMENT,
	nom VARCHAR(20) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS clients (
	id INT NOT NULL AUTO_INCREMENT,
	nom VARCHAR(20),
    direccio VARCHAR(50),
    telefon VARCHAR(12) NOT NULL,
    email VARCHAR(30),
    data_registre DATE,
    id_recomanacio INT,
    PRIMARY KEY (id),
    CONSTRAINT referencia FOREIGN KEY (id_recomanacio) REFERENCES clients (id)
);

CREATE TABLE IF NOT EXISTS ulleres(
	id INT NOT NULL AUTO_INCREMENT,
	marca VARCHAR(15) NOT NULL,
    graduacio_dret INT,
    graduacio_esquerra INT,
    tipus_montura VARCHAR(15),
    color_montura VARCHAR(20),
    color_vidre VARCHAR(20),
    preu INT NOT NULL,
    inici_venda DATE,
    fi_venda DATE,
    idEmpleat INT,
    idProveidor INT,
    idClient INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_empleat_ulleres FOREIGN KEY (idEmpleat) REFERENCES empleats (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_proveidor_ulleres FOREIGN KEY (idProveidor) REFERENCES proveidors (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_client_ulleres FOREIGN KEY (idClient) REFERENCES clients (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO proveidors (nom, carrer, numero, ciutat, codi_postal, pais, telefon, NIF) VALUES ('Proveidor 1', 'carrer torrent', '42', 'Barcelona', '08025', 'España', '912232031', '28492123K'); 
INSERT INTO proveidors (nom, carrer, numero, ciutat, codi_postal, pais, telefon, NIF) VALUES ('Proveidor 2', 'carrer font', '35', 'Barcelona', '08002', 'España', '995221201', '23232343F'); 
INSERT INTO empleats (nom) VALUES ("Joan");
INSERT INTO empleats (nom) VALUES ("Judit");
INSERT INTO clients (nom, direccio, telefon, email, data_registre) VALUES ("Marc Ventura", "Carrer Puig 32", '649232192', 'marcventura@correu.com', '2022-07-09');
INSERT INTO clients (nom, direccio, telefon, email, data_registre, id_recomanacio) VALUES ("Roger Grau", "Carrer Argent 2", '689347211', 'rogergrau@correu.com', '2023-03-09', 1);
INSERT INTO ulleres (marca, preu, inici_venda, fi_venda, idEmpleat, idProveidor, idClient) VALUES ('Marca 1', 60, '2023-09-01', '2023-09-03', 1, 1, 2);
INSERT INTO ulleres (marca, preu, inici_venda, fi_venda, idEmpleat, idProveidor, idClient) VALUES ('Marca 2', 40, '2023-08-30', '2023-09-05', 2, 1, 1);
INSERT INTO ulleres (marca, preu, inici_venda, fi_venda, idEmpleat, idProveidor, idClient) VALUES ('Marca 3', 10, '2023-07-30', '2023-08-31', 1, 2, 1);
INSERT INTO ulleres (marca, preu, inici_venda, fi_venda, idEmpleat, idProveidor, idClient) VALUES ('Marca 4', 30, '2023-07-30', null, null, 2, null);
INSERT INTO ulleres (marca, preu, inici_venda, fi_venda, idEmpleat, idProveidor, idClient) VALUES ('Marca 5', 20, '2022-03-30', '2022-05-30', 2, 2, 2);

SELECT * FROM proveidors;
SELECT * FROM empleats;
SELECT * FROM clients;
SELECT * FROM ulleres;

SELECT marca, preu, inici_venda, fi_venda, clients.nom FROM ulleres INNER JOIN clients ON idClient = clients.id;
SELECT marca, preu, inici_venda, fi_venda, empleats.nom FROM ulleres INNER JOIN empleats ON idEmpleat = empleats.id WHERE fi_venda > '2022-09-09' AND empleats.id = 2;
SELECT proveidors.nom, ulleres.marca, fi_venda FROM proveidors INNER JOIN ulleres ON proveidors.id = ulleres.idProveidor WHERE fi_venda IS NOT null;