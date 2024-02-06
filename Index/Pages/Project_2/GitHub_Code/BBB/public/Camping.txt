<!DOCTYPE html>
<html lang="nl">
<head>
    <?php include('navbar.php'); ?>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="./Images/BBB.ico" />
    <link rel="stylesheet" href="./Css/camping.css">
    <meta name="description" content="BBB" />
    <title>BBB</title>
    <style>
        /* Add or modify styles if necessary */
        .option-content {
            display: none;
        }

        .option-content p {
            /* Add styles for the text within <p> tags */
            color: black; /* You can customize the color */
            font-size: 16px; /* You can customize the font size */
            /* Add other styles as needed */
        }
    </style>
</head>
<body>
    <div class="campBody">
        <div class="flex-container">
            <div class="campText">
                <div class="dropdown">
                    <div class="label" id="dropdownLabel">Locatie</div>
                    <div class="dropdown-content">
                        <a href="#option1" class="dropdown-option" data-target="option1">1</a>
                        <a href="#option2" class="dropdown-option" data-target="option2">2</a>
                        <a href="#option3" class="dropdown-option" data-target="option3">3</a>
                        <a href="#option4" class="dropdown-option" data-target="option4">4</a>
                        <a href="#option5" class="dropdown-option" data-target="option5">5</a>
                        <a href="#option6" class="dropdown-option" data-target="option6">6</a>
                        <a href="#option7" class="dropdown-option" data-target="option7">7</a>
                        <a href="#option8" class="dropdown-option" data-target="option8">8</a>
                        <a href="#option9" class="dropdown-option" data-target="option9">9</a>
                        <a href="#option10" class="dropdown-option" data-target="option10">10</a>
                        <a href="#option11" class="dropdown-option" data-target="option11">11</a>
                        <a href="#option12" class="dropdown-option" data-target="option12">12</a>
                        <a href="#option13" class="dropdown-option" data-target="option13">13</a>
                        <a href="#option14" class="dropdown-option" data-target="option14">14</a>
                    </div>
                </div>
                <div id="option1" class="option-content">
                    <p>Selected Option Text: Option 1</p>
                </div>
                <div id="option2" class="option-content">
                    <p>Selected Option Text: Option 2</p>
                </div>
                <div id="option3" class="option-content">
                    <p>Selected Option Text: Option 3</p>
                </div>
                <div id="option4" class="option-content">
                    <p>Selected Option Text: Option 4</p>
                </div>
                <div id="option5" class="option-content">
                    <p>Selected Option Text: Option 5</p>
                </div>
                <div id="option6" class="option-content">
                    <p>Selected Option Text: Option 6</p>
                </div>
                <div id="option7" class="option-content">
                    <p>Selected Option Text: Option 7</p>
                </div>
                <div id="option8" class="option-content">
                    <p>Selected Option Text: Option 8</p>
                </div>
                <div id="option9" class="option-content">
                    <p>Selected Option Text: Option 9</p>
                </div>
                <div id="option10" class="option-content">
                    <p>Selected Option Text: Option 10</p>
                </div>
                <div id="option11" class="option-content">
                    <p>Selected Option Text: Option 11</p>
                </div>
                <div id="option12" class="option-content">
                    <p>Selected Option Text: Option 12</p>
                </div>
                <div id="option13" class="option-content">
                    <p>Selected Option Text: Option 13</p>
                </div>
                <div id="option14" class="option-content">
                    <p>Selected Option Text: Option 14</p>
                </div>
                
            </div>
            <div class="nested-flex-container">
                <div class="campText2">
                   <div class="campBackground">
                     
                   </div>
                </div>
                <div class="campText3">
                    <p>[description on how to use drop down menu and what the numbers on the map correspond to]</p>
                </div>
            </div>
        </div>
    </div>

    <script>
            $(document).ready(function(){
                $(".dropdown-option").click(function(e){
                    e.preventDefault(); // Prevent the default behavior of the anchor link
                    var targetId = $(this).data("target");
                    $(".option-content").hide();
                    $("#" + targetId).show();
                    $(".dropdown-content").hide();
                    
                    // Scroll back to the top of the page
                    $('html, body').animate({scrollTop: 0});
                });

                $("#dropdownLabel").click(function(){
                    $(".dropdown-content").toggle();
                });
            });
       




    </script>
</body>
</html>

