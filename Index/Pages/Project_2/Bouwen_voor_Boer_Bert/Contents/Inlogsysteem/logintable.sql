-- Verwijder de database als deze bestaat en maak deze opnieuw aan
DROP DATABASE IF EXISTS Reserveringen;

-- Maak de database aan als deze nog niet bestaat en selecteer deze
CREATE DATABASE IF NOT EXISTS Reserveringen;
USE Reserveringen;

-- Maak tabel voor persoonsgegevens
CREATE TABLE IF NOT EXISTS persoonsgegevens (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    VoorNaam VARCHAR(255),
    TussenVoegsel VARCHAR(20),
    AchterNaam VARCHAR(255),
    TelefoonNummer VARCHAR(20),
    Email VARCHAR(255),
    Aantal_Personen INT,
    Verzoek VARCHAR(255)
);

-- Haal alle records op uit de persoonsgegevens tabel
SELECT * FROM persoonsgegevens;

-- Maak tabel voor adresgegevens
CREATE TABLE IF NOT EXISTS adresgegevens (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Postcode VARCHAR(255),
    Huisnummer INT,
    Toevoeging VARCHAR(255),
    Straatnaam VARCHAR(255),
    Woonplaats VARCHAR(255),
    Land VARCHAR(255),
    Kampeermiddel VARCHAR(255)
);

-- Maak tabel voor gebruikers
CREATE TABLE IF NOT EXISTS users (
    PersonID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL
);
