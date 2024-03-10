<?php

session_start();
    ?>
<!DOCTYPE html>
<html lang="nl">
<head>
    <?php include('navbar.php'); ?>
    <link rel="stylesheet" href="Css/Boeken.css">
</head>
<body>
    <div class="bodyReservering">
    <?php
    if (isset($_SESSION["ErrorMessage"])) {
        $errorMessage = $_SESSION["ErrorMessage"];
            echo '
                <p style="
                    font-family: Arial, Helvetica, sans-serif;
                    font-size: large;
                    color: red;
                ">
                    ' . $errorMessage . '
                </p>';
        }
         ?>
            <form class="reserveringForm" id="contactForm" method="post" action="Input">
                
            <?php
                  
            echo '<container class="reserveringContainer">';
            echo '  
            <select class="topForm" name="aanhef" id="aanhef">
            <option value="">Hoe wilt u geaddreseerd worden?*</option>
            <option value="Meneer" '.(isset($_SESSION['aanhef']) && $_SESSION['aanhef'] === "Meneer" ? 'selected' : '').'>Meneer</option>
            <option value="Mevrouw" '.(isset($_SESSION['aanhef']) && $_SESSION['aanhef'] === "Mevrouw" ? 'selected' : '').'>Mevrouw</option>
            <option value="Anders" '.(isset($_SESSION['aanhef']) && $_SESSION['aanhef'] === "Anders" ? 'selected' : '').'>Anders</option>
            </select>
            <div id="andersInputA" style="display: none;">
            <input type="text" name="andersAanhef" id="andersA" placeholder="Anders, specificeren:*" value="'. (isset($_SESSION['aanhef']) ? $_SESSION["aanhef"] : '') .'">
            </div>
            ';

            echo '
            <input type="text" id="voornaam" name="voornaam" placeholder="Voornaam:*" value="' . (isset($_SESSION['voornaam']) ? $_SESSION["voornaam"] : '') . '" autocomplete="given-name" />
            ';
            
            echo '
            <input type="text" id="achternaam" name="achternaam" placeholder="Achternaam:*" autocomplete="family-name" value="' . (isset($_SESSION['achternaam']) ? $_SESSION["achternaam"] : '') . '"/>
            ';

            echo '
            <input class="email" type="email" id="femail" name="femail" placeholder="Email:*" autocomplete="email" value="' . (isset($_SESSION['email']) ? $_SESSION["email"] : '') . '" />
            ';
            
            echo '
            <input type="tel" id="telNmr" name="telNmr" placeholder="06 12345678*" autocomplete="tel" inputmode="numeric"/value="' . (isset($_SESSION['nummer']) ? $_SESSION["nummer"] : '') . '"/>
            ';
            
            echo '<div class="adress">';
            echo '
            <input class="postcode" type="text" id="postcode" name="postcode" placeholder="Postcode:* " autocomplete="postal-code" value="' . (isset($_SESSION['postcode']) ? $_SESSION["postcode"] : '') . '"/>
            ';
            
            echo '
            <input class="straatnaam" type="text" id="straat" name="straat" placeholder="Straatnaam: *" autocomplete="address-line1" value="' . (isset($_SESSION['straatnaam']) ? $_SESSION["straatnaam"] : '') . '"/>
            ';
            
            echo '
            <input class="huisnummer" type="text" id="huisNmr" name="huisNmr" placeholder="Huisnummer: *" autocomplete="address-line2" value="'. (isset($_SESSION['huisnummer']) ? $_SESSION["huisnummer"] : '') . '"/>
            ';
            echo '</div>';

            echo '
                <input type="number" min="0" max="25" name="volwassenen" placeholder="Aantal volwassenen:*" value="'. (isset($_SESSION['Volwassenen']) ? $_SESSION["Volwassenen"] : '') .'">
            ';

            echo '
                <input type="number" min="0" max="25" class="bottomForm" name="kinderen" placeholder="Aantal kinderen:*" value="'.(isset($_SESSION["kinderen"]) ? $_SESSION["kinderen"] : '').'">
            ';

            echo '</container>';
            echo '<container class="reserveringContainer">';

            echo '
            <select class="topForm" name="middelen" id="middelen">
                <option value="">Waarmee komt u kamperen*</option>
                <option value="Tent" ' . (isset($_SESSION["middelen"]) && $_SESSION["middelen"] == "Tent" ? "selected" : "") . '>Tent</option>
                <option value="Caravan" ' . (isset($_SESSION["middelen"]) && $_SESSION["middelen"] == "Caravan" ? "selected" : "") . '>Caravan</option>
                <option value="Anders" ' . (isset($_SESSION["middelen"]) && $_SESSION["middelen"] == "Anders" ? "selected" : "") . '>Anders</option>
            </select>
            
            <div id="andersInput" style="display: none;">
                <input type="text" name=Middelen" id="anders" placeholder="Anders, specificeren:*" value="' . (isset($_SESSION["middelen"]) && $_SESSION["middelen"] == 'Anders' ? $_SESSION["middelen"] : '') . '">
            </div>';    

        
            

            if (isset($_SESSION['verzoek'])) {
                echo '
                <textarea class="fmsg" id="verzoek" name="verzoek" form="contactForm" placeholder="Speciale verzoeken: (Mogelijk ten extra kosten i.v.m. verzoek)">
                    ' . $_SESSION['verzoek'] . '
                </textarea>';
            } else {
                echo '
                <textarea class="fmsg" id="verzoek" name="verzoek" form="contactForm" placeholder="Speciale verzoeken: (Mogelijk ten extra kosten i.v.m. verzoek)"></textarea>
                ';
            }                    


            if (isset($_SESSION['BeginDatum'])) {
                echo '
                    <label class="label "for="begindatum">Begin datum:*</label>
                    <input type="date" id="begindatum" name="begindatum" min="' . date('Y-m-d') . '" value="' . $_SESSION['BeginDatum'] . '">
                ';
            } else {
                echo '
                    <label class="label for="begindatum">Begin datum:*</label>
                    <input type="date" id="begindatum" name="begindatum" min="' . date('Y-m-d') . '" placeholder="Begin datum?">
                ';
            }

            if (isset($_SESSION['EindDatum'])) {
                $sixtyDaysLater = date('Y-m-d', strtotime('+60 days'));
                echo '
                    <label class="label for="einddatum">Eind datum:*</label>
                    <input type="date" id="einddatum" name="einddatum" value="' . $_SESSION['EindDatum'] . '" placeholder="Eind datum? * ">
                ';
            } else {
                $sixtyDaysLater = date('Y-m-d', strtotime('+60 days'));
                echo '
                    <label class="label for="einddatum">Eind datum:*</label>
                    <input type="date" id="einddatum" name="einddatum" max="' . $sixtyDaysLater . '" placeholder="Eind datum? * ">
                ';
            }

            ?>  

<input class="submit" type="submit" value="Reserveren">
</container>
</form>

<script>
const middelenSelect = document.getElementById('middelen');
const andersInput = document.getElementById('andersInput');

middelenSelect.addEventListener('change', function() {
    handleSelectChange(this, andersInput, 'anders');
});

const aanhefSelect = document.getElementById('aanhef');
const andersInput2 = document.getElementById('andersInputA');

aanhefSelect.addEventListener('change', function() {
    handleSelectChange(this, andersInput2, 'andersA');
});

function handleSelectChange(selectElement, targetElement, exclusionId) {
    if (selectElement.value === 'Anders') {
        targetElement.style.display = 'block';
        excludedFields = excludedFields.filter(item => item !== exclusionId);
    } 
    else {
        targetElement.style.display = 'none';
        if (!excludedFields.includes(exclusionId)) {
            excludedFields.push(exclusionId);
        }
    }
    validateForm(excludedFields);
}

// JavaScript to validate the end date against the start date
document.getElementById('begindatum').addEventListener('input', function () {
    var startDate = new Date(this.value);
    var endDateInput = document.getElementById('einddatum');
    
    // If an end date is already selected and it's before the new start date, clear the end date
    if (endDateInput.value !== '' && new Date(endDateInput.value) < startDate) {
        endDateInput.value = '';
    }

    // Update the minimum allowed date for the end date to be the new start date
    endDateInput.min = this.value;
    
    // Calculate the maximum allowed date for the end date (60 days after the start date)
    var maxEndDate = new Date(startDate.getTime() + (60 * 24 * 60 * 60 * 1000));
    endDateInput.max = maxEndDate.toISOString().split('T')[0];
});

let excludedFields = ['verzoek', 'anders', 'andersA']; //fields that are not required
validateForm(excludedFields);
var isAlertShown = false;

function validateForm(excludedIds) {
    document.getElementById('contactForm').addEventListener('submit', function(event) {
        isAlertShown = false; // Reset the flag to false on submit
        // Get all input elements from within the form
        var inputs = this.querySelectorAll('input, select, textarea');
        var isEmptyFieldFound = false;
        // Loop through each input element
        inputs.forEach(function(input) {
            if (!input.value.trim() && !excludedIds.includes(input.id)) {
                isEmptyFieldFound = true;
                if (input.id === 'andersA') {
                    document.getElementById('andersInputA').classList.add('emptyField');
                }
                else if (input.id === 'anders') {
                    document.getElementById('andersInput').classList.add('emptyField');
                }
                else {
                    input.classList.add('emptyField');
                }
            }

            // Remove the "emptyField" class on focus
            input.addEventListener('focus', function() {
                if (input.id === 'andersA') {
                    document.getElementById('andersInputA').classList.remove('emptyField');
                }
                else if (input.id === 'anders') {
                    document.getElementById('andersInput').classList.remove('emptyField');
                }
                else {
                    input.classList.remove('emptyField');
                }
            });
        });
        if (isEmptyFieldFound) {
            // Prevent the form from submitting if any empty fields were found
            event.preventDefault();
            if (!isAlertShown) {
                // Show the alert only if it hasn't been shown before
                alert('Vul alle verplichte velden in');
                isAlertShown = true; // Set the flag to true after showing the alert
            }
        }
    });
}


</script>
</div>

</body>
</html>
