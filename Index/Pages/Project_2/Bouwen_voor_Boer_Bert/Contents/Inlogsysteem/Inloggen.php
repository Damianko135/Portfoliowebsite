<?php
include_once('../Herhaal/Setup.php');
?>

<title>Inloggen</title>

<body>
<div class="NavBar">
        
        <a href="Contents/Reserveringen/Reservering.php">Reservering</a>
        <!-- <a href="Contents/MapRelated/Map.html">Map</a> -->
        <a href="Contents/Inlogsysteem/Inloggen.php">Inloggen</a>
        <a href="Contents/Inlogsysteem/AccountMaken.php">Sign-up</a>
   
</div>
    <h1>Inloggen</h1>
    
    
    <form action="Login.php" method="post">
        <input type="email" name="Email" placeholder="Email" 
            <?php if (isset($_SESSION['Email'])) { echo 'value="'. $_SESSION['Email'] . '"'; } ?>
        >
        <input type="password" name="Wachtwoord" placeholder="Wachtwoord">
        <input type="submit" value="Login">
    </form>
</body>
