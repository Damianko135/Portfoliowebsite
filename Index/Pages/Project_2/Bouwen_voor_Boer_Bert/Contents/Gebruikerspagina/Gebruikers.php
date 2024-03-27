<?php
if (!isset($_SESSION["id"])) {
    header("Location: ../../index.html");
    exit(); // Ensure that the script stops executing after the redirection
}
?>
