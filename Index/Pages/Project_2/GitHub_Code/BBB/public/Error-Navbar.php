<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="/Images/BBB.ico" />
  <meta name="description" content="BBB" />
  <title>BBB</title>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <link rel="stylesheet" href="/Css/navbar.css">
</head>
<body class="indexBody">
  <div class="Navbar">
    <a class="logo" href="/">
      <img src="/Images/BBB2.png" alt="logo" width="50px" height="50px">
      <div>  </div>
      <div>De Groene Weide</div>
    </a>
    <div class="navlink">
      <!-- <a href="https://groeneweide.dkorver.com/">Home</a> -->
      <a href="https://groeneweide.dkorver.com/">De Camping</a>
      <a href="https://groeneweide.dkorver.com/mapPage">Plattegrond</a>
      <a href="https://groeneweide.dkorver.com/Boeken">Boeken</a>    
     <!-- moet eigenlijk worden afgezonderd van de rest, maar voor nu is het prima -->
      <a href="https://groeneweide.dkorver.com/Reserveringen">Resrveringen</a>

    </div>
  </div>
</body>
<script>
  var currentPagePath = window.location.pathname;
  var currentPageFile = currentPagePath.split('/').pop(); // get path, split by /, get last element

  $('.navlink a').removeClass('active'); // remove active class from all links

  $('.navlink a[href*="' + currentPageFile + '"]').addClass('active'); // add active class to link that contains the current page
  </script>
</html>
