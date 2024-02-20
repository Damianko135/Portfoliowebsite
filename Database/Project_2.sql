DROP DATABASE IF EXISTS Reserveringen;

CREATE DATABASE IF NOT EXISTS Reserveringen;
USE Reserveringen;

CREATE TABLE IF NOT EXISTS persoonsgegevens (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Aanhef VARCHAR(255),
    VoorNaam VARCHAR(255),
    AchterNaam VARCHAR(255),
    TelefoonNummer VARCHAR(20),
    Email VARCHAR(255),
    Verzoek VARCHAR(255),
    Volwassenen VARCHAR(20),
    kinderen VARCHAR(20),
    Aantal_Personen VARCHAR(20)
);

SELECT * FROM persoonsgegevens;

CREATE TABLE IF NOT EXISTS adresgegevens (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES persoonsgegevens(UserID),
    Postcode VARCHAR(255),
    Huisnummer VARCHAR(20),
    Straatnaam VARCHAR(255),
    Kampeermiddel VARCHAR(255)
);

SELECT * FROM adresgegevens;


CREATE TABLE IF NOT EXISTS users (
    PersonID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50),
    pwd VARCHAR(255),
    Email VARCHAR(100)
);

SELECT * FROM users;

CREATE TABLE IF NOT EXISTS popupInhoud (
    PlekID INT AUTO_INCREMENT PRIMARY KEY,
    Grootte CHAR(255),
    Kampeermiddel VARCHAR(255),
    PlekNmr CHAR(3),
    Personen CHAR(2),
    Bijzettentjes CHAR(1),
    Stroom VARCHAR(4),
    Water VARCHAR(7)
);

INSERT INTO popupInhoud (Grootte, Kampeermiddel, PlekNmr, Personen, Bijzettentjes, Stroom, Water)
VALUES 
/* bigcamp 1 */     ('80', 'tent/caravan/camper', '1', '5', '1', 'wel', 'ook tot'),
/* bigcamp 2 */     ('80', 'tent/caravan/camper', '2', '5', '1', 'wel', 'ook tot'),
/* bigcamp 3 */     ('80', 'tent/caravan/camper', '3', '5', '1', 'wel', 'ook tot'),
/* bigcamp 4 */     ('80', 'tent/caravan/camper', '4', '5', '1', 'wel', 'ook tot'),
/* bigcamp 5 */     ('80', 'tent/caravan/camper', '5', '5', '1', 'wel', 'ook tot'),
/* bigcamp 6 */     ('80', 'tent/caravan/camper', '6', '5', '1', 'wel', 'ook tot'),
/* bigcamp 7 */     ('80', 'tent/caravan/camper', '7', '5', '1', 'wel', 'ook tot'),
/* bigcamp 8 */     ('80', 'tent/caravan/camper', '8', '5', '1', 'wel', 'ook tot'),
/* bigcamp 9 */     ('80', 'tent/caravan/camper', '9', '5', '1', 'wel', 'ook tot'),
/* bigcamp 10 */    ('80', 'tent/caravan/camper', '10', '5', '1', 'wel', 'ook tot'),
/* bigcamp 11 */    ('80', 'tent/caravan/camper', '11', '5', '1', 'wel', 'ook tot'),
/* bigcamp 12 */    ('80', 'tent/caravan/camper', '12', '5', '1', 'wel', 'ook tot'),
/* bigcamp 13 */    ('80', 'tent/caravan/camper', '13', '5', '1', 'wel', 'ook tot'),
/* bigcamp 14 */    ('80', 'tent/caravan/camper', '14', '5', '1', 'wel', 'ook tot'),
/* bigcamp 15 */    ('80', 'tent/caravan/camper', '15', '5', '1', 'wel', 'ook tot'),
    
/* smallcamp 1 */     ('45', 'tent/kleine caravan', '1', '10', '4', 'wel', 'ook tot'),
/* smallcamp 2 */     ('45', 'tent/kleine caravan', '2', '10', '4', 'wel', 'ook tot'),
/* smallcamp 3 */     ('45', 'tent/kleine caravan', '3', '10', '4', 'wel', 'ook tot'),
/* smallcamp 4 */     ('45', 'tent/kleine caravan', '4', '10', '4', 'wel', 'ook tot'),
/* smallcamp 5 */     ('45', 'tent/kleine caravan', '5', '10', '4', 'wel', 'ook tot'),
/* smallcamp 6 */     ('45', 'tent/kleine caravan', '6', '10', '4', 'wel', 'ook tot'),
/* smallcamp 7 */     ('45', 'tent/kleine caravan', '7', '10', '4', 'wel', 'ook tot'),
/* smallcamp 8 */     ('45', 'tent/kleine caravan', '8', '10', '4', 'wel', 'ook tot'),
/* smallcamp 9 */     ('45', 'tent/kleine caravan', '9', '10', '4', 'wel', 'ook tot'),
/* smallcamp 10 */    ('45', 'tent/kleine caravan', '10', '10', '4', 'wel', 'ook tot'),
/* smallcamp 11 */    ('45', 'tent/kleine caravan', '11', '10', '4', 'wel', 'ook tot'),
/* smallcamp 12 */    ('45', 'tent/kleine caravan', '12', '10', '4', 'wel', 'ook tot'),
/* smallcamp 13 */    ('45', 'tent/kleine caravan', '13', '10', '4', 'wel', 'ook tot'),
/* smallcamp 14 */    ('45', 'tent/kleine caravan', '14', '10', '4', 'wel', 'ook tot'),
/* smallcamp 15 */    ('45', 'tent/kleine caravan', '15', '10', '4', 'wel', 'ook tot'),
/* smallcamp 16 */    ('45', 'tent/kleine caravan', '16', '10', '4', 'wel', 'ook tot'),
/* smallcamp 17 */    ('45', 'tent/kleine caravan', '17', '10', '4', 'wel', 'ook tot'),
/* smallcamp 18 */    ('45', 'tent/kleine caravan', '18', '10', '4', 'wel', 'ook tot'),
/* smallcamp 19 */    ('45', 'tent/kleine caravan', '19', '10', '4', 'wel', 'ook tot'),
/* smallcamp 20 */    ('45', 'tent/kleine caravan', '20', '10', '4', 'wel', 'ook tot'),
/* smallcamp 21 */    ('45', 'tent/kleine caravan', '21', '10', '4', 'wel', 'ook tot'),
/* smallcamp 22 */    ('45', 'tent/kleine caravan', '22', '10', '4', 'wel', 'ook tot'),
/* smallcamp 23 */    ('45', 'tent/kleine caravan', '23', '10', '4', 'wel', 'ook tot'),
/* smallcamp 24 */    ('45', 'tent/kleine caravan', '24', '10', '4', 'wel', 'ook tot'),
/* smallcamp 25 */    ('45', 'tent/kleine caravan', '25', '10', '4', 'wel', 'ook tot'),
/* smallcamp 26 */    ('45', 'tent/kleine caravan', '26', '10', '4', 'wel', 'ook tot'),
/* smallcamp 27 */    ('45', 'tent/kleine caravan', '27', '10', '4', 'wel', 'ook tot'),
/* smallcamp 28 */    ('45', 'tent/kleine caravan', '28', '10', '4', 'wel', 'ook tot'),
/* smallcamp 29 */    ('45', 'tent/kleine caravan', '29', '10', '4', 'wel', 'ook tot'),
/* smallcamp 30 */    ('45', 'tent/kleine caravan', '30', '10', '4', 'wel', 'ook tot'),
/* smallcamp 31 */    ('45', 'tent/kleine caravan', '31', '10', '4', 'wel', 'ook tot'),
/* smallcamp 32 */    ('45', 'tent/kleine caravan', '32', '10', '4', 'wel', 'ook tot'),
/* smallcamp 33 */    ('45', 'tent/kleine caravan', '33', '10', '4', 'wel', 'ook tot'),
/* smallcamp 34 */    ('45', 'tent/kleine caravan', '34', '10', '4', 'wel', 'ook tot'),
/* smallcamp 35 */    ('45', 'tent/kleine caravan', '35', '10', '4', 'wel', 'ook tot'),
/* smallcamp 36 */    ('45', 'tent/kleine caravan', '36', '10', '4', 'wel', 'ook tot'),
/* smallcamp 37 */    ('45', 'tent/kleine caravan', '37', '10', '4', 'wel', 'ook tot'),
/* smallcamp 38 */    ('45', 'tent/kleine caravan', '38', '10', '4', 'wel', 'ook tot'),
/* smallcamp 39 */    ('45', 'tent/kleine caravan', '39', '10', '4', 'wel', 'ook tot'),
/* smallcamp 40 */    ('45', 'tent/kleine caravan', '40', '10', '4', 'wel', 'ook tot'),
/* smallcamp 41 */    ('45', 'tent/kleine caravan', '41', '10', '4', 'wel', 'ook tot'),
/* smallcamp 42 */    ('45', 'tent/kleine caravan', '42', '10', '4', 'wel', 'ook tot'),
/* smallcamp 43 */    ('45', 'tent/kleine caravan', '43', '10', '4', 'wel', 'ook tot'),
/* smallcamp 44 */    ('45', 'tent/kleine caravan', '44', '10', '4', 'wel', 'ook tot'),
/* smallcamp 45 */    ('45', 'tent/kleine caravan', '45', '10', '4', 'wel', 'ook tot'),
/* smallcamp 46 */    ('45', 'tent/kleine caravan', '46', '10', '4', 'wel', 'ook tot'),
/* smallcamp 47 */    ('45', 'tent/kleine caravan', '47', '10', '4', 'wel', 'ook tot'),
/* smallcamp 48 */    ('45', 'tent/kleine caravan', '48', '10', '4', 'wel', 'ook tot'),
/* smallcamp 49 */    ('45', 'tent/kleine caravan', '49', '10', '4', 'wel', 'ook tot'),
/* smallcamp 50 */    ('45', 'tent/kleine caravan', '50', '10', '4', 'wel', 'ook tot');
    

SELECT * FROM popupInhoud;

CREATE TABLE gebouwPopup(
    GebouwID INT AUTO_INCREMENT PRIMARY KEY,
    Soortgebouw VARCHAR(255),
    Openingstijd CHAR(6),
    Sluitingstijd CHAR(6)
);

INSERT INTO gebouwPopup(Soortgebouw, Openingstijd, Sluitingstijd)
VALUES
    ('Recreatie tehuis', '8:30', '20:30'),
    ('Reseptie', '8:00', '20:00'),
    ('Tennis baan', '10:00', '20:00'),
    ('Voetbalveld', '00:00', '00:00'),
    ('Vollybalveld', '00:00', '00:00'),
    ('Voetbalveld', '00:00', '00:00'),
    ('Fitniss', '8:00', '21:30'),
    ('Fossielen veld', '10:00', '20:00'),
    ('Batminton veld', '10:00', '20:00'),
    ('Teras', '10:00', '22:00'),
    ('Teras', '10:00', '22:00'),
    ('zwembadklein', '8:30', '20:00'),
    ('zwembadgroot', '8:30', '20:00'),
    ('Wasserette', '7:30', '21:00'),
    ('Parkeerplaats', '00:00', '00:00'),
    ('Toilet', '00:00', '00:00'),
    ('Toilet', '00:00', '00:00'),
    ('Toilet', '00:00', '00:00'),
    ('Toilet', '00:00', '00:00'),
    ('Toilet', '00:00', '00:00'),
    ('Toilet', '00:00', '00:00'),
    ('Toilet', '00:00', '00:00'),
    ('het huis van Boer Bert', '00:00', '00:00');

SELECT * FROM gebouwPopup;
