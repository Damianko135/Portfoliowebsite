<?php
include_once('../Database/Connection.php');
include_once('../Herhaal/Setup.php')
?>

<title>Account aanmaken</title>
  
</head>
<body>
<div class="NavBar">
        
        <a href="Contents/Reserveringen/Reservering.php">Reservering</a>
        <a href="Contents/Inlogsysteem/Inloggen.php">Inloggen</a>
        <a href="Contents/Inlogsysteem/AccountMaken.php">Sign-up</a>
   
</div>
  <h1>Creëer een account</h1>
    <form class="Login" action="Sign-up.php" method="post" >
      <input type="text" placeholder="Gebruikersnaam" name="Gebruiker" >  
      <input type="email" name="Email" id="Mail"  placeholder="Email" >  
      <input type="password" placeholder="Wachtwoord" name="Wachtwoord" >
      <input type="password" placeholder="Herhaal wachtwoord" name="Wachtwoord" >
      <button type="submit" >Maak account</button>
    </form>
</body>
</html>