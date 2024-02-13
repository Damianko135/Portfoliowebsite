<?php

// Define database connection constants
define('DB_HOST', 'localhost');
define('DB_PORT', 3306);
define('DB_NAME', 'Portfolio');
define('DB_USER', 'root');
define('DB_PASS', '');

// Global variable to hold the database connection
global $PDO;

// Function to establish a database connection
function connectToDatabase() {
    global $PDO;
    try {
        // Use the constants in the PDO connection string
        $PDO = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
        // Set the PDO error mode to exception
        $PDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {
        // Throw an exception if the connection fails
        throw new Exception("Database connection failed: " . $e->getMessage());
    }
}

// Function to execute a query
function executeQuery($sql) {
    global $PDO;
    try {
        // Check if PDO is null (database connection failed)
        if ($PDO === null) {
            throw new Exception("Database connection is not established.");
        }
        // Execute the query and fetch results
        return $PDO->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    } catch(PDOException $e) {
        // Throw an exception if query execution fails
        throw new Exception("Query execution failed: " . $e->getMessage());
    }
}
