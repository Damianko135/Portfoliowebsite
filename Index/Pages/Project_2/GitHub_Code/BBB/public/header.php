<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="./Images/BBB.ico" />
  <meta name="theme-color" content="#000000" />
  <meta name="description" content="BBB" />
  <title>BBB</title>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <link rel="stylesheet" href="index.css">
</head>
<body class="indexBody" onload="loadHomepage()">
  <container class="Navbar">
    <div class="logo" >
      <img src="./Images/BBB2.png" alt="logo" width="50px" height="50px">
      <div>De Groene Weide</div>
    </div>
    <ul id="linkList">
      <li><a href="./homePage">Home</a></li>
      <li><a href="./camping">De Camping</a></li>
      <li><a href="./mapPage">Plattegrond</a></li>
      <li><a href="./Reservering">Reserveren</a></li>
      <li><a href="./mapInfo">Map Information</a></li>
    </ul>
  </container>
  <script>
    function loadHomepage() {
      // Set the window location to your homepage URL
      window.location.href = 'homePage.html';
    }
  </script>
</body>
</html>
