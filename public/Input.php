<!-- Mocht de gebruiker blijven hangen om een of andere reden... -->
<a href='./'>Oeps, terug naar pagina..</a>

<?php
include_once('Connection.php');
global $PDO;

try {
    
    if (isset($_REQUEST['aanhef'])) {
        $_SESSION['aanhef'] = $Aanhef = isset($_REQUEST['aanhef']) ? trim($_REQUEST['aanhef']) : '';
    } else {
        $_SESSION['aanhef'] = $Aanhef = isset($_REQUEST['andersAanhef']) ? trim($_REQUEST['andersAanhef']) : '';
    }   
    $_SESSION['voornaam'] = $VoorNaam = isset($_REQUEST['voornaam']) ? trim($_REQUEST['voornaam']) : '';
    $_SESSION['achternaam'] = $AchterNaam = isset($_REQUEST['achternaam']) ? trim($_REQUEST['achternaam']) : '';
    $_SESSION['nummer'] = $Nummer = isset($_REQUEST['telNmr']) ? trim($_REQUEST['telNmr']) : '';
    $TelefoonNummer = substr($Nummer, 0, 5);    
    $_SESSION['email'] = $FullEmail = isset($_REQUEST['femail']) ? trim($_REQUEST['femail']) : '';

    // Function to extract the part before '@' in an email address
    function extractUsername($email) {
        $parts = explode('@', $email);
        return $parts[0];
    }
    $emailAddress = $FullEmail;
    $Email = extractUsername($emailAddress);

    
    $_SESSION['postcode'] = $PostCode = isset($_REQUEST['postcode']) ? trim($_REQUEST['postcode']) : '';
    $_SESSION['straatnaam'] = $StraatNaam = isset($_REQUEST['straat']) ? trim($_REQUEST['straat']) : '';
    $_SESSION['huisnummer'] = $HuisNummer = isset($_REQUEST['huisNmr']) ? trim($_REQUEST['huisNmr']) : '';
    $_SESSION['middelen'] = $Middelen = isset($_REQUEST['middelen']) ? trim($_REQUEST['middelen']) : '';
    if (!isset ($Middelen)){
    $_SESSION['middelen'] = $Middelen = isset($_REQUEST['Middelen']) ? trim($_REQUEST['Middelen']) : '';
    }
    $_SESSION['verzoek'] = $Verzoek = isset($_REQUEST['verzoek']) ? trim($_REQUEST['verzoek']) : '';
    $_SESSION['BeginDatum'] = $BeginDatum = isset($_REQUEST['begindatum']) ? trim($_REQUEST['begindatum']) : '';
    $_SESSION['EindDatum'] = $EindDatum = isset($_REQUEST['einddatum']) ? trim($_REQUEST['einddatum']) : '';
    $_SESSION['Volwassenen'] = $Volwassenen = isset($_REQUEST['volwassenen']) ? trim($_REQUEST['volwassenen']) : '';
    $_SESSION['kinderen'] = $Kinderen = isset($_REQUEST['kinderen']) ? trim($_REQUEST['kinderen']) : 0;
    $_SESSION['aantal'] = $aantal = (isset($_SESSION['kinderen']) && isset($_SESSION['Volwassenen'])) ? ($Kinderen + $Volwassenen) : $Volwassenen;    

    if (!empty($VoorNaam) && !empty($AchterNaam) && !empty($TelefoonNummer) && !empty($Email) && !empty($Middelen) && !empty($Volwassenen) && !empty($EindDatum) && !empty($BeginDatum) && !empty($PostCode)) {

    
        $sql = 'INSERT INTO adresgegevens (Postcode, Huisnummer, Straatnaam, Kampeermiddel) VALUES (:Postcode, :Huisnummer, :Straatnaam, :Kampeermiddel)';
        $stmt = $PDO->prepare($sql);
        $stmt->bindParam(':Postcode', $PostCode, PDO::PARAM_STR);
        $stmt->bindParam(':Huisnummer', $HuisNummer, PDO::PARAM_STR);
        $stmt->bindParam(':Straatnaam', $StraatNaam, PDO::PARAM_STR);
        $stmt->bindParam(':Kampeermiddel', $Middelen, PDO::PARAM_STR);
        $stmt->execute();
    
        $sql2 = 'INSERT INTO persoonsgegevens (Aanhef, VoorNaam, AchterNaam, TelefoonNummer, Email, Verzoek, Volwassenen, kinderen, Aantal_Personen) VALUES (:aanhef, :voornaam, :achternaam, :telNmr, :femail, :verzoek, :volwassenen, :kinderen, :aantal)';
        $stmt2 = $PDO->prepare($sql2);
        $stmt2->bindParam(':aanhef', $Aanhef, PDO::PARAM_STR);
        $stmt2->bindParam(':voornaam', $VoorNaam, PDO::PARAM_STR);
        $stmt2->bindParam(':achternaam', $AchterNaam, PDO::PARAM_STR);
        $stmt2->bindParam(':telNmr', $TelefoonNummer, PDO::PARAM_STR);
        $stmt2->bindParam(':femail', $Email, PDO::PARAM_STR);
        $stmt2->bindParam(':verzoek', $Verzoek, PDO::PARAM_STR);
        $stmt2->bindParam(':volwassenen', $Volwassenen, PDO::PARAM_STR);
        $stmt2->bindParam(':kinderen', $Kinderen, PDO::PARAM_STR);
        $stmt2->bindParam(':aantal', $aantal, PDO::PARAM_STR);
        
        if ($stmt2->execute()) {
            $ErrorMessage = 'Reservering is toegevoegd';
            // include_once('Send_Email.php');
            header('Location: confirm?');
            die();
        };
        
    } else {
        $ErrorMessage = 'Vul alle velden in aub.';
    }
} catch (Exception $e) {
    $ErrorMessage = 'There was an error: ' . $e->getMessage();
}

$_SESSION['ErrorMessage'] = $ErrorMessage;
header('Location: Boeken');
exit();

// Debug Stuff

// $PDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

// var_dump(!empty($VoorNaam), !empty($AchterNaam), !empty($TelefoonNummer), !empty($Email), !empty($Middelen), !empty($Volwassenen), !empty($EindDatum), !empty($BeginDatum), !empty($PostCode));


// error_reporting(E_ALL);
// ini_set('display_errors', 1);
