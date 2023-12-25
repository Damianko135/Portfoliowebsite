<?php
include_once('config_session.php');
include_once('../Database/Nah_uh_uh.php');
include_once('../Database/Connection.php');

$email = isset($_REQUEST["Email"]) ? $_REQUEST["Email"] : "";
$password = isset($_REQUEST["password"]) ? $_REQUEST["password"] : "";

if (isset($email, $password) && !empty($email) && !empty($password)) {
    $email = filter_var($email, FILTER_SANITIZE_EMAIL);

    $sqlLogin = "SELECT id, password FROM users WHERE email = :email";
    $stmtLogin = $PDO->prepare($sqlLogin);
    $stmtLogin->bindParam(":email", $email, PDO::PARAM_STR);
    $stmtLogin->execute();
    $result = $stmtLogin->fetch(PDO::FETCH_ASSOC);

    if ($result) {
        $storedPassword = $result["password"];
        if (password_verify($password, $storedPassword)) {
            $_SESSION["user_id"] = $result["id"];
            $_SESSION["Message"] = "Login successful!";
            header("Location: dashboard.php");
            exit();
        } else {
            // Generic error message to prevent revealing specific information
            $_SESSION["Message"] = "Invalid email or password.";
        }
    } else {
        $_SESSION["Message"] = "Invalid email or password.";
    }
} else {
    $_SESSION["Message"] = "Invalid email or password.";
}

header("Location: login.php");
exit();
?>
