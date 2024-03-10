    <?php
    include_once('Connection.php');

    function show($PDO) {
        $stmt = $PDO->prepare("SELECT * FROM popupInhoud");
        $stmt->execute();
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $stmt2 = $PDO->prepare("SELECT * FROM gebouwPopup");
        $stmt2->execute();
        $results2 = $stmt2->fetchAll(PDO::FETCH_ASSOC);        
        }
    ?>

    <!DOCTYPE html>
    <html lang="nl">
    <head>
        <?php include('navbar.php'); ?>
        <link rel="stylesheet" href="./Css/Plattegrond.css">
        <script type="text/javascript" src="./es6-promise.js"></script>
        <script type="text/javascript" src="./jquery.imagemapster.js"></script>
        <script>
            // Misschien 2 maken? 1 voor de plekken 1 voor de gebouwen?
            function showPopupKamp(id) {
                document.getElementById('popup').style.display = 'block';
                document.getElementById('overlay').style.display = 'block';
                document.getElementById('popupContent').innerHTML = plek[id - 1];
                console.log(plek.get(id -1))

            .catch(error => console.error('Error:', error));
            }

            function showPopupGeb(id) {
                    document.getElementById('popup').style.display = 'block';
                    document.getElementById('overlay').style.display = 'block';
                    document.getElementById('popupContent').innerHTML = gebouw[id - 1];
                    console.log(gebouw.get(id -1))
                
                .catch(error => console.error('Error:', error));
            }  

            function closePopup() {
                document.getElementById('popup').style.display = 'none';
                document.getElementById('overlay').style.display = 'none';
            }
        </script>
    </head>
    <body>
        <div class="mapBackground">
        <container class="mapContainer">
            <container class="infoContainer">
                <div class="info">
                    <li id="SP" class="staanplaatsen" onclick="groupsSelect('SP')">Staanplaatsen</li>
                    <li id="TT" class="toiletten" onclick="groupsSelect('TT')">Toiletten</li>
                    <li id="ZB" class="zwembad" onclick="groupsSelect('ZB')">Zwembaden</li>
                    <li id="ST" class="speeltuin" onclick="groupsSelect('ST')">Activiteiten</li>
                    <li id="BB" class="huisBert" onclick="groupsSelect('BB')">Huis van Bert</li>
                    <li id="PP" class="parkeerplekken" onclick="groupsSelect('PP')">Parkeerplekken</li>
                </div>
            </container>
            <container class="imageContainer">
        <img src="./Images/high fid.png" class="test" usemap="#image-map" id="plattegrond">
        <map name="image-map" id="image-map">
            <area id="1" groupKey="1, ST" alt="Recreatie tehuis" title="Recreatie tehuis" onclick="showPopupGeb(id)" href="#" coords="25,22,234,277" shape="rect">
            <area id="2" groupKey="2, ST" alt="Reseptie" title="Reseptie" onclick="showPopupGeb(id)" href="#" coords="56,316,156,388" shape="rect">
            <area id="3" groupKey="3, ST" alt="Tennis baan" title="Tennis baan" onclick="showPopupGeb(id)" href="#" coords="242,30,451,153" shape="rect">
            <area id="4" groupKey="4, ST" alt="Voetbalveld" title="Voetbalveld" onclick="showPopupGeb(id)" href="#" coords="459,30,563,153" shape="rect">
            <area id="5" groupKey="5, ST" alt="Vollybalveld" title="Vollybalveld" onclick="showPopupGeb(id)" href="#" coords="572,31,675,153" shape="rect">
            <area id="6" groupKey="6, ST" alt="Voetbalveld" title="Voetbalveld" onclick="showPopupGeb(id)" href="#" coords="243,180,452,302" shape="rect">
            <area id="7" groupKey="7, ST" alt="Fitniss" title="Fitniss" onclick="showPopupGeb(id)" href="#" coords="460,302,563,180" shape="rect">
            <area id="8" groupKey="8, ST" alt="Fossielen veld" title="Fossielen veld" onclick="showPopupGeb(id)" href="#" coords="570,303,675,179" shape="rect">
            <area id="9" groupKey="9, ST" alt="Batminton veld" title="Batminton veld" onclick="showPopupGeb(id)" href="#" coords="242,446,343,311" shape="rect">
            <area id="10" groupKey="10, ST" alt="Teras" title="Teras" onclick="showPopupGeb(id)" href="#" coords="350,446,451,310" shape="rect">
            <area id="11" groupKey="11, ST" alt="Teras" title="Teras" onclick="showPopupGeb(id)" href="#" coords="459,446,564,311" shape="rect">
            <area id="12" groupKey="12, ZB" alt="zwembadklein" title="zwembadklein" onclick="showPopupGeb(id)" href="#" coords="571,446,675,310" shape="rect">
            <area id="13" groupKey="13, ZB" alt="zwembadgroot" title="zwembadgroot" onclick="showPopupGeb(id)" href="#" coords="476,693,688,557" shape="rect">
            <area id="14" groupKey="14, ST" alt="Wasserette" title="Wasserette" onclick="showPopupGeb(id)" href="#" coords="468,694,255,557" shape="rect">
            <area id="15" groupKey="15, PP" alt="Parkeerplaats" title="Parkeerplaats" onclick="showPopupGeb(id)" href="#" coords="35,682,245,557" shape="rect">
            <area id="16" groupKey="16, TT" alt="Toilet" title="Toilet" onclick="showPopupGeb(id)" href="#" coords="701,681,723,660" shape="rect">
            <area id="17" groupKey="17, TT" alt="Toilet" title="Toilet" onclick="showPopupGeb(id)" href="#" coords="701,634,723,614" shape="rect">
            <area id="18" groupKey="18, TT" alt="Toilet" title="Toilet" onclick="showPopupGeb(id)" href="#" coords="701,589,723,567" shape="rect">
            <area id="19" groupKey="19, TT" alt="Toilet" title="Toilet" onclick="showPopupGeb(id)" href="#" coords="704,400,683,378" shape="rect">
            <area id="20" groupKey="20, TT" alt="Toilet" title="Toilet" onclick="showPopupGeb(id)" href="#" coords="704,279,683,257" shape="rect">
            <area id="21" groupKey="21, TT" alt="Toilet" title="Toilet" onclick="showPopupGeb(id)" href="#" coords="704,154,683,133" shape="rect">
            <area id="22" groupKey="22, TT" alt="Toilet" title="Toilet" onclick="showPopupGeb(id)" href="#" coords="704,55,683,33" shape="rect">
            <area id="23" groupKey="87, BB" alt="het huis van Boer Bert" title="huisBert" onclick="showPopupGeb(id)" href="#" coords="31,488,102,487,102,462,155,462,154,435,32,435,31,460" shape="poly">
            
             <area id="1" groupKey="23, SP" alt="bigCamp1" title="bigCamp1" onclick="showPopupKamp(id)" href="#" coords="838,701,877,641" shape="rect">
            <area id="2" groupKey="24, SP" alt="bigCamp2" title="bigCamp2" onclick="showPopupKamp(id)" href="#" coords="917,641,879,700" shape="rect">
            <area id="3" groupKey="25, SP" alt="bigCamp3" title="bigCamp3" onclick="showPopupKamp(id)" href="#" coords="958,641,919,700" shape="rect">
            <area id="4" groupKey="26, SP" alt="bigCamp4" title="bigCamp4" onclick="showPopupKamp(id)" href="#" coords="998,641,960,700" shape="rect">
            <area id="5" groupKey="27, SP" alt="bigCamp5" title="bigCamp5" onclick="showPopupKamp(id)" href="#" coords="1039,641,1000,701" shape="rect">
            <area id="6" groupKey="28, SP" alt="bigCamp6" title="bigCamp6" onclick="showPopupKamp(id)" href="#" coords="838,597,877,538" shape="rect">
            <area id="7" groupKey="29, SP" alt="bigCamp7" title="bigCamp7" onclick="showPopupKamp(id)" href="#" coords="917,538,879,597" shape="rect">
            <area id="8" groupKey="30, SP" alt="bigCamp8" title="bigCamp8" onclick="showPopupKamp(id)" href="#" coords="958,537,919,597" shape="rect">
            <area id="9" groupKey="31, SP" alt="bigCamp9" title="bigCamp9" onclick="showPopupKamp(id)" href="#" coords="998,538,960,598" shape="rect">
            <area id="10" groupKey="32, SP" alt="bigCamp10" title="bigCamp10" onclick="showPopupKamp(id)" href="#" coords="1039,537,1000,597" shape="rect">
            <area id="11" groupKey="33, SP" alt="bigCamp11" title="bigCamp11" onclick="showPopupKamp(id)" href="#" coords="838,477,877,536" shape="rect">
            <area id="12" groupKey="34, SP" alt="bigCamp12" title="bigCamp12" onclick="showPopupKamp(id)" href="#" coords="878,477,918,536" shape="rect">
            <area id="13" groupKey="35, SP" alt="bigCamp13" title="bigCamp13" onclick="showPopupKamp(id)" href="#" coords="958,477,919,536" shape="rect">
            <area id="14" groupKey="36, SP" alt="bigCamp14" title="bigCamp14" onclick="showPopupKamp(id)" href="#" coords="999,477,960,536" shape="rect">
            <area id="15" groupKey="37, SP" alt="bigCamp15" title="bigCamp15" onclick="showPopupKamp(id)" href="#" coords="1039,477,1000,536" shape="rect">
            <area id="16" groupKey="38, SP" alt="smallCamp1" title="smallCamp1" onclick="showPopupKamp(id)" href="#" coords="757,350,795,389" shape="rect">
            <area id="17" groupKey="39, SP" alt="smallCamp2" title="smallCamp2" onclick="showPopupKamp(id)" href="#" coords="757,391,795,429" shape="rect">
            <area id="18" groupKey="40, SP" alt="smallCamp3" title="smallCamp3" onclick="showPopupKamp(id)" href="#" coords="797,391,836,429" shape="rect">
            <area id="19" groupKey="41, SP" alt="smallCamp4" title="smallCamp4" onclick="showPopupKamp(id)" href="#" coords="797,350,836,389" shape="rect">
            <area id="20" groupKey="42, SP" alt="smallCamp5" title="smallCamp5" onclick="showPopupKamp(id)" href="#" coords="876,388,838,350" shape="rect">
            <area id="21" groupKey="43, SP" alt="smallCamp6" title="smallCamp6" onclick="showPopupKamp(id)" href="#" coords="838,391,876,429" shape="rect">
            <area id="22" groupKey="44, SP" alt="smallCamp7" title="smallCamp7" onclick="showPopupKamp(id)" href="#" coords="878,350,917,388" shape="rect">
            <area id="23" groupKey="45, SP" alt="smallCamp8" title="smallCamp8" onclick="showPopupKamp(id)" href="#" coords="879,430,918,391" shape="rect">
            <area id="34" groupKey="46, SP" alt="smallCamp9" title="smallCamp9" onclick="showPopupKamp(id)" href="#" coords="919,429,957,391" shape="rect">
            <area id="25" groupKey="47, SP" alt="smallCamp10" title="smallCamp10" onclick="showPopupKamp(id)" href="#" coords="919,350,958,388" shape="rect">
            <area id="26" groupKey="48, SP" alt="smallCamp11" title="smallCamp11" onclick="showPopupKamp(id)" href="#" coords="960,350,998,388" shape="rect">
            <area id="27" groupKey="49, SP" alt="smallCamp12" title="smallCamp12" onclick="showPopupKamp(id)" href="#" coords="960,391,998,430" shape="rect">
            <area id="28" groupKey="50, SP" alt="smallCamp13" title="smallCamp13" onclick="showPopupKamp(id)" href="#" coords="1000,350,1039,388" shape="rect">
            <area id="29" groupKey="51, SP" alt="smallCamp14" title="smallCamp14" onclick="showPopupKamp(id)" href="#" coords="1000,391,1039,430" shape="rect">
            <area id="30" groupKey="52, SP" alt="smallCamp15" title="smallCamp15" onclick="showPopupKamp(id)" href="#" coords="756,269,795,307" shape="rect">
            <area id="31" groupKey="53, SP" alt="smallCamp16" title="smallCamp16" onclick="showPopupKamp(id)" href="#" coords="756,228,795,267" shape="rect">
            <area id="32" groupKey="54, SP" alt="smallCamp17" title="smallCamp17" onclick="showPopupKamp(id)" href="#" coords="798,269,836,307" shape="rect">
            <area id="33" groupKey="55, SP" alt="smallCamp18" title="smallCamp18" onclick="showPopupKamp(id)" href="#" coords="796,228,836,267" shape="rect">
            <area id="34" groupKey="56, SP" alt="smallCamp19" title="smallCamp19" onclick="showPopupKamp(id)" href="#" coords="838,228,876,267" shape="rect">
            <area id="35" groupKey="57, SP" alt="smallCamp20" title="smallCamp20" onclick="showPopupKamp(id)" href="#" coords="838,269,876,307" shape="rect">
            <area id="36" groupKey="58, SP" alt="smallCamp21" title="smallCamp21" onclick="showPopupKamp(id)" href="#" coords="879,228,918,267" shape="rect">
            <area id="37" groupKey="59, SP" alt="smallCamp22" title="smallCamp22" onclick="showPopupKamp(id)" href="#" coords="878,268,917,307" shape="rect">
            <area id="38" groupKey="60, SP" alt="smallCamp23" title="smallCamp23" onclick="showPopupKamp(id)" href="#" coords="919,227,958,267" shape="rect">
            <area id="39" groupKey="61, SP" alt="smallCamp24" title="smallCamp24" onclick="showPopupKamp(id)" href="#" coords="919,307,958,269" shape="rect">
            <area id="40" groupKey="62, SP" alt="smallCamp25" title="smallCamp25" onclick="showPopupKamp(id)" href="#" coords="960,269,998,307" shape="rect">
            <area id="41" groupKey="63, SP" alt="smallCamp26" title="smallCamp26" onclick="showPopupKamp(id)" href="#" coords="1000,268,1039,307" shape="rect">
            <area id="42" groupKey="64, SP" alt="smallCamp27" title="smallCamp27" onclick="showPopupKamp(id)" href="#" coords="960,267,998,227" shape="rect">
            <area id="43" groupKey="65, SP" alt="smallCamp28" title="smallCamp28" onclick="showPopupKamp(id)" href="#" coords="1000,228,1039,267" shape="rect">
            <area id="44" groupKey="66, SP" alt="smallCamp29" title="smallCamp29" onclick="showPopupKamp(id)" href="#" coords="756,147,795,186" shape="rect">
            <area id="45" groupKey="67, SP" alt="smallCamp30" title="smallCamp30" onclick="showPopupKamp(id)" href="#" coords="797,147,836,186" shape="rect">
            <area id="46" groupKey="68, SP" alt="smallCamp31" title="smallCamp31" onclick="showPopupKamp(id)" href="#" coords="756,106,795,145" shape="rect">
            <area id="47" groupKey="69, SP" alt="smallCamp32" title="smallCamp32" onclick="showPopupKamp(id)" href="#" coords="796,106,836,145" shape="rect">
            <area id="48" groupKey="70, SP" alt="smallCamp33" title="smallCamp33" onclick="showPopupKamp(id)" href="#" coords="838,107,876,145" shape="rect">
            <area id="49" groupKey="71, SP" alt="smallCamp34" title="smallCamp34" onclick="showPopupKamp(id)" href="#" coords="838,146,876,186" shape="rect">
            <area id="50" groupKey="72, SP" alt="smallCamp35" title="smallCamp35" onclick="showPopupKamp(id)" href="#" coords="878,146,917,186" shape="rect">
            <area id="51" groupKey="73, SP" alt="smallCamp36" title="smallCamp36" onclick="showPopupKamp(id)" href="#" coords="878,106,917,145" shape="rect">
            <area id="52" groupKey="74, SP" alt="smallCamp37" title="smallCamp37" onclick="showPopupKamp(id)" href="#" coords="919,146,958,186" shape="rect">
            <area id="53" groupKey="75, SP" alt="smallCamp38" title="smallCamp38" onclick="showPopupKamp(id)" href="#" coords="919,106,957,145" shape="rect">
            <area id="54" groupKey="76, SP" alt="smallCamp39" title="smallCamp39" onclick="showPopupKamp(id)" href="#" coords="959,146,998,186" shape="rect">
            <area id="55" groupKey="77, SP" alt="smallCamp40" title="smallCamp40" onclick="showPopupKamp(id)" href="#" coords="960,105,998,145" shape="rect">
            <area id="56" groupKey="78, SP" alt="smallCamp41" title="smallCamp41" onclick="showPopupKamp(id)" href="#" coords="1000,146,1039,106" shape="rect">
            <area id="57" groupKey="79, SP" alt="smallCamp42" title="smallCamp42" onclick="showPopupKamp(id)" href="#" coords="1000,186,1039,147" shape="rect">
            <area id="58" groupKey="80, SP" alt="smallCamp43" title="smallCamp43" onclick="showPopupKamp(id)" href="#" coords="757,25,795,64" shape="rect">
            <area id="59" groupKey="81, SP" alt="smallCamp44" title="smallCamp44" onclick="showPopupKamp(id)" href="#" coords="797,25,836,64" shape="rect">
            <area id="60" groupKey="82, SP" alt="smallCamp45" title="smallCamp45" onclick="showPopupKamp(id)" href="#" coords="837,24,877,64" shape="rect">
            <area id="61" groupKey="83, SP" alt="smallCamp46" title="smallCamp46" onclick="showPopupKamp(id)" href="#" coords="879,25,917,64" shape="rect">
            <area id="62" groupKey="84, SP" alt="smallCamp47" title="smallCamp47" onclick="showPopupKamp(id)" href="#" coords="919,24,958,64" shape="rect">
            <area id="63" groupKey="85, SP" alt="smallCamp48" title="smallCamp48" onclick="showPopupKamp(id)" href="#" coords="960,25,998,64" shape="rect">
            <area id="64" groupKey="86, SP" alt="smallCamp49" title="smallCamp49" onclick="showPopupKamp(id)" href="#" coords="1000,64,1039,25" shape="rect">
        </map>
        </container>    
        </container>
        
        <div id="overlay" onclick="closePopup()"></div>
        <div id="popup">
            <div id="popupContent" class="popupText"></div>
            <button onclick="closePopup()">Terug</button>
        </div>
        </div>
    </body>
    <?php
        $stmt = $PDO->prepare("SELECT * FROM popupInhoud");
        $stmt->execute();
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $stmt2 = $PDO->prepare("SELECT * FROM gebouwPopup");
        $stmt2->execute();
        $results2 = $stmt2->fetchAll(PDO::FETCH_ASSOC);        
        
        if ($results) {?>
            <script>
                var plek = [];
                <?php foreach ($results as $row) : ?>
                    plek.push([
                        '<p class="popupText" id="<?php echo $row['PlekID']; ?>" style="display: block;">',
                        'Deze plek is <?php echo $row['Grootte']; ?> m2 groot.<br>',
                        'Dit is een <?php echo $row['Kampeermiddel']; ?> plek.<br>',
                        'Dit is plek nummer <?php echo $row['PlekNmr']; ?> <br>',
                        'Dit is een plek voor maximaal <?php echo $row['Personen']; ?> personen.<br>',
                        'Er is op deze plek plaats voor <?php echo $row['Bijzettentjes']; ?> bijzettentjes.<br>',
                        'Deze plek heeft <?php echo $row['Stroom']; ?> beschikking tot stroom, en <?php echo $row['Water']; ?> water.',
                        '</p>'
                    ].join(''));
                <?php endforeach; ?>
            </script>

            <script>
                var gebouw = [];
                <?php foreach ($results2 as $row2) : ?>
                    gebouw.push([
                        '<p class="popupText" id="<?php echo $row2['GebouwID']; ?>" style="display: block;">',
                        'Dit is een <?php echo $row2['Soortgebouw']; ?>. <br>',
                        'Dit gebouw is om exact <?php echo $row2['Openingstijd']; ?> geopend.<br>',
                        'Het gebouw sluit om exact <?php echo $row2['Sluitingstijd']; ?>.<br>',
                        '</p>'
                    ].join(''));
                <?php endforeach; ?>
            </script>

        <?php } ?>
    <script>
        function groupsSelect(group) {
            var value = $('#plattegrond').mapster('get', group);
            var liElement = $("#" + group);

            if (value) {
                $('#plattegrond').mapster('set', false, group);
                liElement.removeClass('selected');
            } else {
                $('#plattegrond').mapster('set', true, group);
                liElement.addClass('selected');
            }
        }

        $(document).ready(function ()
    {
        $('#plattegrond')
        .mapster({
            isSelectable: false,
            isDeselectable: false,
            mapKey: 'groupKey',
            fillColor: "ffffff25",
            stroke: true,
            strokeColor: "fffffff",
            strokeOpacity: 1.0,
            strokeWidth: 2,
            render_highlight:  {
                fillOpacity: 0.5,
                fillColor: "FFeedd",
                stroke: true,
                strokeOpacity: 1.0,
                strokeColor: "FF0000",
                strokeWidth: 2
            },
        })
    });
    </script>
    </html>
