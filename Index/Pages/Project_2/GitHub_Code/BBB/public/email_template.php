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
    max-width: 600px;
    margin: 20px auto;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    background-color: #fff;
}

.confirm {
    text-align: center;
}

h1 {
    color: #333;
}

h2 {
    color: #555;
}

ul {
    list-style: none;
    padding: 0;
}

li {
    margin-bottom: 10px;
}

a {
    text-decoration: none;
    color: #3498db;
}

a:hover {
    text-decoration: underline;
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
            </div>
        </div>
    </div>
</body>

</html>
