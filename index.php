<!DOCTYPE html>
<html lang="en">
    <head>
        <title></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body>

<?php
include_once 'Header.php';
include_once 'models/Cars.php';

$cars = new Cars();
//$row = $cars->list();

$row = $cars->searchCarsQueryBuilder('2018-05-24', '2018-05-27');
//$row = $cars->searchCarsQueryBuilder('2018-05-19','2018-5-25', '', '', '', 13);

if (!empty($row)) {
    for ($i = 0; $i < count($row); $i++) {
        echo $row[$i]->id;
        echo $row[$i]->manufacturer;
        echo $row[$i]->model;
        echo $row[$i]->year;
        echo $row[$i]->category;
        echo '<br />';
    }
} else {
    echo '<p class="error">' . $q . '</p>';
    echo '<p class="error"> There was an error.</p>';
    echo '<p class="error">' . mysqli_error($dbc) . '</p>';
}
?>

<div id="sidebar">

    <center>
        <h1>Booking Search</h1>
        <h4>Search available cars based on your booking dates and other criteria.</h4>
    </center>

    <form action="index.php" method="post">
        <label for="startDate">Start Date:</label>
        <input type="date" name="startDate" value="" onchange="updateValue(this.value)" id="startDate" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required>
        <label for="endDate">End Date:</label>
        <input type="date" name="endDate" id="endDate" value="" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required>
        <h4>Car manufacturer :</h4>
        <select class="styled-select slate">
            <option value="0">Any</option>
            <option value="1">SUV</option>
        </select>

        <h4>Car Category :</h4>
        <select class="styled-select slate">
            <option value="1">Select One:</option>
            <option value="volvo">Volvo</option>
            <option value="saab">Saab</option>
            <option value="opel">Opel</option>
            <option value="audi">Audi</option>
        </select>

        <center>
            <input type ="submit" class ="button SubButton" value ="Search" />
            <input type="hidden" name="submitted" value="1" />
        </center>
    </form>

</div> <!-- END SIDEBAR -->

</body>

<script>
    let date = new Date();

    function addMonthsToDate(input, noOfMonths) {
        input.setMonth(input.getMonth() + noOfMonths);
        return input.toISOString().substr(0,10);
    };

    // Default value today
    let today = date.toISOString().substr(0,10);
    
    function updateValue(startDate) {
        // Default endDate value is start date value
        today = startDate;
        return today;
    }
    console.log(JSON.parse(JSON.stringify(today)));

    document.getElementById("startDate").value = today;
    
    // Minimum selectable start day today
    document.getElementById("startDate").setAttribute("min", today);
    
    // Maximum selectable day 6 months from today
    let max = addMonthsToDate(date, 6);
    document.getElementById("startDate").setAttribute("max", max);

    let startDate = document.getElementById("startDate").value;

    document.getElementById("endDate").value = today;

    // Minimum selectable end date is start date value
    document.getElementById("endDate").setAttribute("min", today);
    // Maximum selectable end date is six months from today
    document.getElementById("endDate").setAttribute("min", max);
</script>

</html>