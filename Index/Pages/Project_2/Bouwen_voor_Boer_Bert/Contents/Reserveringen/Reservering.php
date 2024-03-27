<?php


session_start();
if(isset($_SESSION['ErrorMessage'])&&isset($_SESSION['ErrorMessage'])){
    echo $_SESSION['ErrorMessage'];
};
?>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../Styling/Reservering.css">
</head> 
<body class="d-flex">
    <container>
    <h1>Reserveren voor xx/xx/xxxx t/m xx/xx/xxx</h1>
    <form id="contactForm" method="post" action="Input.php">
        <input class="email" type="email" id="femail" name="femail" placeholder="Email:"/> 
        <select name="fname" id="fname" onchange="aanhefCheck(selected);">
            <option value="" disabled selected hidden>Hoe wilt u geaddreseerd worden</option>
            <option value="Heer">Heer</option>
            <option value="Mvr.">Mvr.</option>
            <option value="Geen">Geen</option>
            <option value="Anders:">Anders:</option>
        </select>   
        <input type="text" id="anders" name="anders" style="display: none;" placeholder="Aanhef:"/>
        <input type="text" id="voornaam" name="voornaam" placeholder="Vooraam:"/>
        <input type="text" id="tussen" name="tussen" placeholder="Tussenvoegsel:"/>
        <input type="text" id="achternaam" name="achternaam" placeholder="Achternaam:"/>
        <input type="tel" id="telNmr" name="telNmr" placeholder="Telefoon nummer: (met landcode)"/>
        <input class="postcode" type="text" id="postcode" name="postcode" placeholder="Postcode:"/>
        <input class="straatnaam" type="text" id="straat" name="straat" placeholder="Straatnaam:"/>
        <input class="huisnummer" type="text" id="huisNmr" name="huisNmr" placeholder="Huisnummer:"/>
        <input class="toevoeging" type="text" id="huisNmr+" name="huisNmr+" placeholder="Toevoeging:"/>
        <input type="text" id="gemeente" name="gemeente" placeholder="Gemeente:"/>
        <input type="text" id="land" name="land" placeholder="Land:"/>
        <select name="middelen" id="middelen" required>
            <option value="">Selecteer een optie</option>
            <option value="Tent">Tent</option>
            <option value="caravan">Caravan</option>
            <option value="Anders">Anders</option>
        </select>
        <div id="andersInput" style="display: none;">
            <label for="anders">Anders, specificeren:</label>
            <input type="text" name="anders" id="anders">
        </div>
        <textarea class="fmsg" id="verzoek" name="verzoek" form="contactForm" placeholder="Speciale verzoeken: (Mogelijk ten extra kosten i.v.m. verzoek)"></textarea>
        <input class="submit" type="submit" value="Submit"/>
    </form>
    </container>

    <script>
        const middelenSelect = document.getElementById('middelen');
        const andersInput = document.getElementById('andersInput');

        middelenSelect.addEventListener('change', function() {
            if (this.value === 'Anders') {
                andersInput.style.display = 'block';
                andersInput.querySelector('input').setAttribute('required', 'true');
            } else {
                andersInput.style.display = 'none';
                andersInput.querySelector('input').removeAttribute('required');
            }
        });
    </script> 
    

<?php
session_unset();
?>

</body>
</html>
