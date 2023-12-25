<?php

include_once("../Database/Connection.php");
include_once("../Database/Nah_uh_uh.php");


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


if (!empty($VoorNaam) && !empty($AchterNaam) && !empty($TelefoonNummer) && !empty($Email) && !empty($PostCode) && !empty($Middelen)) {
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
        $message = "Reservering is toegevoegd";  
    } else {
        $message = "Er is een probleem opgetreden bij het toevoegen van de reservering. Probeer het later opnieuw.";
    }
} else {
$message = "Er zijn gegevens niet ingevuld of onvolledig.";
}

$_SESSION['ErrorMessage'] = $message;
header("Location: Reservering.php");
die();
?>
