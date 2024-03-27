<?php
include_once("../Database/Connection.php");
include_once("../Database/Nah_uh_uh.php");

$email = isset($_REQUEST["Email"]) ? $_REQUEST["Email"] : "";
$gebruikersnaam = isset($_REQUEST["Gebruikersnaam"]) ? $_REQUEST["Gebruikersnaam"] : "";
$wachtwoord = isset($_REQUEST["wachtwoord"]) ? $_REQUEST["wachtwoord"] : "";
$Herhaal_wachtwoord = isset($_REQUEST["Herhaal_wachtwoord"]) ? $_REQUEST["Herhaal_wachtwoord"] : "";

if ($wachtwoord === $Herhaal_wachtwoord) {
    if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $gehasht_wachtwoord = password_hash($wachtwoord, PASSWORD_DEFAULT);

        $sqlSignUp = "INSERT INTO Users (Username, pwd, Email) VALUES (:Gebruikersnaam, :wachtwoord, :Email)";
        $stmtSignUp = $PDO->prepare($sqlSignUp);
        $stmtSignUp->bindParam(":wachtwoord", $gehasht_wachtwoord, PDO::PARAM_STR);
        $stmtSignUp->bindParam(":Gebruikersnaam", $gebruikersnaam, PDO::PARAM_STR);
        $stmtSignUp->bindParam(":Email", $email, PDO::PARAM_STR);

        if ($stmtSignUp->execute()) {
            $message = "Account toegevoegd"; 
        } else {
            $message = "Er is een fout opgetreden, probeer het later opnieuw. Mocht de fout blijven optreden, neem contact met ons op.";
        }
    } else {
        $message = "Ongeldig e-mailadres"; // Handle invalid email
    }
} else {
    $message = "Wachtwoorden komen niet overeen"; // Handle password mismatch
}

$_SESSION['Message'] = $message;
header('location: AccountMaken.php');
?>
