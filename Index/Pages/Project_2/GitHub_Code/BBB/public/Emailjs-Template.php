<!DOCTYPE html>
<html lang="nl">

<head>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    .contact-form {
        position: relative;
        max-width: 600px;
        margin: 20px auto;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .contact-form::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: url(https://groeneweide.dkorver.com/Images/Home.jpg);
        background-size: cover;
        z-index: -1;
    }

    .confirm {
        text-align: center;
        position: relative;
        z-index: 1;
    }

    h1 {
        color: white;
    }

    h2 {
        color: whitesmoke;
    }

    ul {
        list-style: none;
        padding: 0;
        color: whitesmoke;
    }

    li {
        margin-bottom: 10px;
        color: whitesmoke;
    }

    li:nth-child(3), 
    li:nth-child(4) {
        color: whitesmoke;
        background-color: rgba(0, 0, 0, 0.3);
        width: fit-content;
        margin-inline: auto;

    }

    footer {
        color: whitesmoke;
    }
</style>

</head>

<body>
    <div class="contact-form">
        <div class="test">
            <div class="confirm">
                <input type="email" name="from_email" style="display: none;" value='{{from_email}}'>
                    <h1>Bedankt voor uw reservering!</h1>
                    <h2>Beste <span name="FirstName">{{FirstName}}</span> <span name="LastName">{{LastName}}</span></h2>
                    <h2>U heeft gereserveerd voor <span name="StartDate">{{StartDate}}</span> tot en met <span name="EndDate">{{EndDate}}</span></h2>
                    <h2>U heeft het volgende aangegeven:</h2>
                    <ul>
                        <li>
                            Aantal personen: <span name="amount">{{amount}}</span><br> waarvan: <span name="grownups">{{grownups}}</span> Volwassenen en <span name="kids">{{kids}}</span> kinderen.
                        </li>
                        <li>
                            Mobiele nummer:<span name="number">{{number}}</span>
                        </li>
                        <li>
                            U komt met: een <span name='arrive_with'>{{arrive_with}}</span>
                        </li>
                        <li>
                            Met bericht: <span name='request'>{{request}}</span>
                        </li>
                    </ul>

                    <h2>Wij wensen u een fijne vakantie!</h2>
                <footer>Dit is een geautomatiseerd bericht, u kunt hier niet op reageren.</footer>
            </div>
        </div>
    </div>
</body>
</html>


