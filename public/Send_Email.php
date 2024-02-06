<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

require 'vendor/autoload.php';

$mail = new PHPMailer(true);

try {
    // Server settings
    $mail->SMTPDebug = SMTP::DEBUG_SERVER;
    $mail->isSMTP();
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = 'bouwenvoorboerbert@gmail.com';
    $mail->Password   = 'olilkfxcmdohbxbb';
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port       = 587;

    // Recipients
    $mail->setFrom('bouwenvoorboerbert@gmail.com', 'Boer Bert');
    $mail->addAddress(trim('korverdamian@gmail.com'));
    $mail->addReplyTo('info@example.com', 'Information');
    $mail->addCC('cc@example.com');
    $mail->addBCC('bouwenvoorboerbert@gmail.com');

    // Attachments
    // $mail->addAttachment('/var/tmp/file.tar.gz');
    // $mail->addAttachment('/tmp/image.jpg', 'new.jpg');

    // Content
    $mail->isHTML(true);
    $mail->Subject = 'Reservering toegevoegd';

    // Build the email body with user information
    $body = '<b>Bedankt voor uw reservering!</b>';
    $body .= '<br><br>';
    $body .= '<br>Beste ' . $_SESSION["aanhef"] .' '. $_SESSION["voornaam"] . ',';
    $body .= '<br>U heeft het volgende doorgegeven: <br>';
    $body .= '<br> Voornaam: ' . $_SESSION["voornaam"];
    $body .= '<br>Achternaam: ' . $_SESSION["achternaam"];
    $body .= '<br>Telefoonnummer: ' . $_SESSION["nummer"];
    $body .= '<br>Email: ' . $_SESSION["email"];
    $body .= '<br>Postcode: ' . $_SESSION["postcode"];
    $body .= '<br>Straatnaam: ' . $_SESSION["straatnaam"];
    $body .= '<br>Huisnummer: ' . ($_SESSION["huisnummer"] ?? 'Niet opgegeven');
    $body .= '<br>Middelen: ' . $_SESSION["middelen"];
    $body .= '<br>Verzoek: ' . $_SESSION["verzoek"];
    $body .= '<br>BeginDatum: ' . $_SESSION["BeginDatum"];
    $body .= '<br>EindDatum: ' . $_SESSION["EindDatum"];
    $body .= '<br>Volwassenen: ' . $_SESSION["Volwassenen"];
    $body .= '<br>Kinderen: ' . $_SESSION["kinderen"];

    // Add more user information as needed

    $mail->isHTML(true);
    $mail->Body    = $body;
    $mail->AltBody = 'Beste , uw reservering is toegevoegd.';

   if($mail->send()) {   
       echo 'Message has been sent';
    } else {
        echo "Email kon niet worden verzonden";
    }
} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}
