<?php
session_start();

define('DB_HOST', 'localhost');
define('DB_PORT', 3306);
define('DB_NAME', 'Reserveringen');
define('DB_USER', 'root');
define('DB_PASS', '');


global $PDO;

try {
    // Use the constants in the PDO connection string
    $PDO = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
    // set the PDO message mode to exception
    $PDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}


$VoorNaam = isset($_REQUEST['voornaam']) ? trim($_REQUEST['voornaam']) : ''; // Need to include this
$TussenVoegsel = isset($_REQUEST['tussen']) ? trim($_REQUEST['tussen']) : '';
$AchterNaam = isset($_REQUEST['achternaam']) ? trim($_REQUEST['achternaam']) : ''; // Need to include this
$TelefoonNummer = isset($_REQUEST['telNmr']) ? trim($_REQUEST['telNmr']) : ''; // Need to include this
$Email = isset($_REQUEST['femail']) ? trim($_REQUEST['femail']) : ''; // Need to include this
$PostCode = isset($_REQUEST['postcode']) ? trim($_REQUEST['postcode']) : ''; // Need to include this
$StraatNaam = isset($_REQUEST['straat']) ? trim($_REQUEST['straat']) : '';
$HuisNummer = isset($_REQUEST['huisNmr']) ? trim($_REQUEST['huisNmr']) : '';
$HuisNummerToeVoegsel = isset($_REQUEST['huisNmr+']) ? trim($_REQUEST['huisNmr+']) : '';
$Gemeente = isset($_REQUEST['gemeente']) ? trim($_REQUEST['gemeente']) : ''; 
$Land = isset($_REQUEST['land']) ? trim($_REQUEST['land']) : '';
$Middelen = isset($_REQUEST['middelen']) ? trim($_REQUEST['middelen']) : ''; // Need to include this 
$Verzoek = isset($_REQUEST['verzoek']) ? trim($_REQUEST['verzoek']) : '';
$AantalPersonen = isset($_REQUEST['aantal']) ? trim($_REQUEST['aantal']) : '';

if (!empty($VoorNaam) && !empty($AchterNaam)) {
    if (!empty($TelefoonNummer)) {
        if (!empty($Email)) {   
            if (!empty($PostCode)) {
                if (!empty($Middelen)) {
                    $sql = "INSERT INTO adresgegevens (Postcode, Huisnummer, Toevoeging, Straatnaam, Woonplaats, Land, Kampeermiddel) VALUES (:Postcode, :Huisnummer, :Toevoeging, :Straatnaam, :Woonplaats, :Land, :Kampeermiddel)";
                    $stmt = $PDO->prepare($sql);
                    $stmt->bindParam(':Postcode', $PostCode, PDO::PARAM_STR);
                    $stmt->bindParam(':Huisnummer', $HuisNummer, PDO::PARAM_STR);
                    $stmt->bindParam(':Toevoeging', $HuisNummerToeVoegsel, PDO::PARAM_STR);
                    $stmt->bindParam(':Straatnaam', $StraatNaam, PDO::PARAM_STR);
                    $stmt->bindParam(':Woonplaats', $Gemeente, PDO::PARAM_STR);
                    $stmt->bindParam(':Land', $Land, PDO::PARAM_STR);
                    $stmt->bindParam(':Kampeermiddel', $Middelen, PDO::PARAM_STR);
                    $stmt->execute();

                    $sql2 = "INSERT INTO persoonsgegevens (VoorNaam, TussenVoegsel, AchterNaam, TelefoonNummer, Email, Verzoek, Aantal_Personen) VALUES (:voornaam, :tussen, :achternaam, :telNmr, :femail, :verzoek, :aantal)";
                    $stmt2 = $PDO->prepare($sql2);
                    $stmt2->bindParam(':voornaam', $VoorNaam, PDO::PARAM_STR);
                    $stmt2->bindParam(':tussen', $TussenVoegsel, PDO::PARAM_STR);
                    $stmt2->bindParam(':achternaam', $AchterNaam, PDO::PARAM_STR);
                    $stmt2->bindParam(':telNmr', $TelefoonNummer, PDO::PARAM_STR);
                    $stmt2->bindParam(':femail', $Email, PDO::PARAM_STR);
                    $stmt2->bindParam(':verzoek', $Verzoek, PDO::PARAM_STR);
                    $stmt2->bindParam(':aantal', $AantalPersonen, PDO::PARAM_STR);
                    if ($stmt2->execute()) {
                        $message = "reservering is toegevoegd";
                    }              
                } else {
                    $message = "Wat neemt u mee?";
                };
            } else {
                $message = "Geen Postcode opgegeven";
            };
        } else {
            $message = "Email AUB"; 
        };
    } else {
    $message= "Telefoon nummer AUB.";
    };
}
else {
    $message = "Geen gegevens ingevuld.";
};


$_SESSION['ErrorMessage'] = $message;
echo "<script> 
      window.history.go(-1);
      </script>";