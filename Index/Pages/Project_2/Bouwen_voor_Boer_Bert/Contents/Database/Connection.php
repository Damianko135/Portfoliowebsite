<?php
if (file_exists('Connection.php')) {
    header('Location: ../../index.html');
    exit(); // Ensure the script stops after redirection
}

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
