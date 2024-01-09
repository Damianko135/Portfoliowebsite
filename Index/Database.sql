DROP DATABASE IF EXISTS Portfolio;

CREATE DATABASE IF NOT EXISTS Portfolio;

USE Portfolio;

CREATE TABLE links (
    linkID      INT AUTO_INCREMENT PRIMARY KEY,
    Link        VARCHAR(255) UNIQUE,
    Username    VARCHAR(100),
    userIP      VARCHAR(20),
    Date        VARCHAR(29)
);

CREATE TABLE persoonsgegevens (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    VoorNaam VARCHAR(255),
    TussenVoegsel VARCHAR(20),
    AchterNaam VARCHAR(255),
    TelefoonNummer VARCHAR(20),
    Email VARCHAR(255),
    Aantal_Personen INT,
    Verzoek VARCHAR(255)
);

CREATE TABLE adresgegevens (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Postcode VARCHAR(255),
    Huisnummer INT,
    Toevoeging VARCHAR(255),
    Straatnaam VARCHAR(255),
    Woonplaats VARCHAR(255),
    Land VARCHAR(255),
    Kampeermiddel VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES persoonsgegevens(UserID)
);

CREATE TABLE users (
    UserID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    pwd VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE popupInhoud (
    PlekID INT AUTO_INCREMENT PRIMARY KEY,
    length_value INT,
    width_value INT
);

INSERT INTO popupInhoud (length_value, width_value)
    VALUES 
    (1, 1), 
    (2, 2),
    (3, 3),
    (4, 4);

SELECT * FROM popupInhoud;

SELECT * FROM users;
