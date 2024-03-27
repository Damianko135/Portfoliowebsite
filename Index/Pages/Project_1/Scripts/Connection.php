<?php

define('DB_HOST', 'localhost');
define('DB_PORT', 3306);
define('DB_NAME', 'Links');
define('DB_USER', 'root');
// Set password:
define('DB_PASS', '');

global $PDO;

function connectToDatabase() {
    global $PDO;
    try {
        // Use the constants in the PDO connection string
        $PDO = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
        // set the PDO error mode to exception
        $PDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      } catch(PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
      }
}

function executeQuery($sql) {
    global $PDO;
    try {
        return $PDO->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }
    catch(PDOException $e) {
        echo "Houston, we've got a problem: " . "<br>" . $e->getMessage();
    }
}
