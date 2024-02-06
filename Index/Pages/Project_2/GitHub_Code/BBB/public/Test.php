<?php
include_once('Connection.php');

function show($PDO) {
    $stmt = $PDO->prepare("SELECT * FROM popupInhoud");
    $stmt->execute();
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($results) {?>
    <script>
        var plekData = <?php echo json_encode($results); ?>;
    </script>
    
<?php }} 

?>

<!DOCTYPE html>
<html lang="nl">
<head>
    <?php include('navbar.php'); ?>
    <link rel="stylesheet" href="./Css/mapPage.css">
    <link rel="stylesheet" href="./Css/Style.css">
    <script type="text/javascript" src="./es6-promise.js"></script>
    <script type="text/javascript" src="./jquery.imagemapster.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
    <map name="image-map" id="image-map">
        <?php
            $stmt = $PDO->prepare("SELECT * FROM popupInhoud");
            $stmt->execute();
            $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if ($results) {?>
                <script>
                    var plek = [];
                    <?php foreach ($results as $row) : ?>
                        plek.push([
                            '<p class="Pop-Up" id="<?php echo $row['PlekID']; ?>" style="display: block;">',
                            'Deze plek is <?php echo $row['Grootte']; ?> m2 groot.<br>',
                            'Dit is een <?php echo $row['Kampeermiddel']; ?> plek.<br>',
                            'Dit is plek nummer <?php echo $row['PlekNmr']; ?> <br>',
                            'Dit is een plek voor maximaal <?php echo $row['Personen']; ?> personen.<br>',
                            'Er is op deze plek plaats voor <?php echo $row['Bijzettentjes']; ?> bijzettentjes.<br>',
                            'Deze plek heeft <?php echo $row['Stroom']; ?> beschikking tot stroom, en <?php echo $row['Water']; ?> water.',
                            '</p>'
                        ]);
                    <?php endforeach; ?>
                </script>
            <?php } ?>

            <div class="mapBackground">
            <container class="mapContainer">
                <container class="infoContainer">
                    <div class="info">
                        <li class="staanplaatsen" onclick="groupsSelect('SP')">Staanplaatsen</li>
                        <li class="toiletten" onclick="groupsSelect('TT')">Toiletten</li>
                        <li class="zwembad" onclick="groupsSelect('ZB')">Zwembaden</li>
                        <li class="speeltuin" onclick="groupsSelect('ST')">Speeltuin</li>
                        <li class="huisBert" onclick="groupsSelect('BB')">Huis van Bert</li>
                        <li class="parkeerplekken" onclick="groupsSelect('PP')">Parkeerplekken</li>
                    </div>
                </container>
                <container class="imageContainer">
                    <img src="./Images/test.png" class="test" usemap="#image-map" id="plattegrond">
                        <map name="image-map" id="image-map">
                            <area id="1" alt="1" title="1" groupKey="1, SP" onclick="showPopup(id)" href="#" coords="200,179,44,47" shape="rect">
                            <area id="2" alt="2" title="2" groupKey="2, TT" onclick="showPopup(id)" href="#" coords="23,447,201,608" shape="rect">
                            <area id="3" alt="3" title="3" groupKey="3, ZB" onclick="showPopup(id)" href="#" coords="439,449,565,569" shape="rect">
                            <area id="4" alt="4" title="4" groupKey="4, ST" onclick="showPopup(id)" href="#" coords="585,319,714,440" shape="rect">
                            <area id="5" alt="5" title="5" groupKey="5, SP" onclick="showPopup(id)" href="#" coords="438,42,563,150" shape="rect">
                            <area id="6" alt="6" title="6" groupKey="6, TT" onclick="showPopup(id)" href="#" coords="714,152,571,42" shape="rect">
                            <area id="7" alt="7" title="7" groupKey="7, ST" onclick="showPopup(id)" href="#" coords="784,49,914,154" shape="rect">
                            <area id="8" alt="8" title="8" groupKey="8, BB" onclick="showPopup(id)" href="#" coords="785,320,905,449" shape="rect">
                            <area id="9" alt="9" title="9" groupKey="9, PP" onclick="showPopup(id)" href="#" coords="919,448,1066,571" shape="rect">
                            <area id="10" alt="10" title="10" groupKey="10, PP" onclick="showPopup(id)" href="#" coords="930,154,1072,43" shape="rect">
                        </map>
                </container>
            </container>

            <div id="overlay" onclick="closePopup()"></div>
            <div id="popup">
                <div id="popupContent"></div>
                <button onclick="closePopup()">Terug</button>
            </div>
        </div>

        <script>
            function groupsSelect(group) {
                var value = $('#plattegrond').mapster('get', group);

                if (value) {
                    $('#plattegrond').mapster('set', false, group);
                } else {
                    $('#plattegrond').mapster('set', true, group);
                }
            }

            $(document).ready(function () {
                $('#plattegrond').mapster({
                    mapKey: 'groupKey',
                    fillColor: "d42e16",
                    stroke: true,
                    strokeColor: "ff0000",
                    strokeOpacity: 1.0,
                    strokeWidth: 2,
                    render_highlight: {
                        fillOpacity: 0.5,
                        fillColor: "FFeedd",
                        stroke: true,
                        strokeOpacity: 1.0,
                        strokeColor: "FF0000",
                        strokeWidth: 2
                    }
                });
            });

            function showPopup(id) {
                document.getElementById('popup').style.display = 'block';
                document.getElementById('overlay').style.display = 'block';
                document.getElementById('popupContent').innerHTML = plek[id];

                fetch(`get_data.php?areaId=${id}`)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.text();
                    })
                    .then(data => {
                        document.getElementById('popup').innerHTML = data;
                        document.getElementById('popup').style.display = 'block';
                    })
                    .catch(error => console.error('Error:', error));
            }

            function closePopup() {
                document.getElementById('popup').style.display = 'none';
                document.getElementById('overlay').style.display = 'none';
            }

            console.log(plekData);

        </script>
    </map>
</body>
</html>
