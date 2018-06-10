<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Car Search Results</title>
        <link rel="stylesheet" href="css/table.css">
        <link rel="stylesheet" href="css/pagination.css">
    </head>
    <body>
<?php
include_once 'Header.php';

/*** MANUFACTURER ***/
include_once 'models/Manufacturers.php';
$manufacturers = new Manufacturers();
$manufacturersList = $manufacturers->listAll();

/*** CATEGORY ***/
include_once 'models/Categories.php';
$categories = new Categories();
$categoriesList = $categories->listAll();

/*** MODEL ***/
include_once 'models/Models.php';
$models = new Models();
$modelsList = $models->listAll();

/*** MAKE YEARS ***/
include_once 'models/Years.php';
$years = new Years();
$yearsList = $years->listAll();

/*** PRICE RANGE ***/
include_once 'models/Cars.php';
$cars = new Cars();
$minPrice = $cars->minPrice();
$maxPrice = $cars->maxPrice();

if (isset($_GET['deleted']))
{
    $deletedReservation = trim($_GET['deleted']);
    if ($deletedReservation == TRUE)
    {
        echo '<h3>You have successfully cancelled your reservation.</h3>';
    }
}
?>
        
<div id="sidebar">
  <?php
  
  ?>
    
    <center>
        <h1>Booking Search</h1>
        <p>Search available cars based on your booking dates and other criteria.</p>
    </center>
    <form action="search.php" method="POST">
        <fieldset>
            <label for="startDate">Start Date:</label>
            <input type="date" name="startDate" value="<?php echo date('Y-m-d'); ?>" onchange="updateValue(this.value)" id="startDate" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required> 
            &nbsp&nbsp&nbsp&nbsp
            <label for="endDate">End Date:</label>
            <input type="date" name="endDate" id="endDate" value="<?php echo date('Y-m-d'); ?>" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required>
        </fieldset>
        <fieldset>
            <label for="manufacturer">Manufacturer:</label>
            <select id="manufacturer" name="manufacturer">
            <option value="0">Any</option>
<?php
if (!empty($manufacturersList)) {
    for ($i = 0; $i < count($manufacturersList); $i++) {
        echo '<option value="' . $manufacturersList[$i]->id . '">' . $manufacturersList[$i]->manufacturer . '</option>';
    }
} else {
    echo '<p class="error"> There was an error.</p>';
}
?>
            </select> <!-- END MANUFACTURERS -->
            &nbsp&nbsp&nbsp&nbsp
            <label for="category">Car Category:</label>
            <select id="category" name="category">
                <option value="0">Any</option>
<?php
if (!empty($categoriesList)) {
    for ($i = 0; $i < count($categoriesList); $i++) {
        echo '<option value="' . $categoriesList[$i]->id . '">' . $categoriesList[$i]->category . '</option>';
    }
} else {
    echo '<p class="error">There was an error with categories.</p>';
}
?>
            </select> <!-- END CATEGORIES -->
        </fieldset>
        <fieldset>
            <label for="model">Car Model:</label>
            <select name="model" id="model">
                <option value="0">Any</option>
<?php
if (!empty($modelsList)) {
    for ($i = 0; $i < count($modelsList); $i++) {
        echo '<option value="' . $modelsList[$i]->id . '">' . $modelsList[$i]->model . '</option>';
    }
} else {
    echo '<p class="error">There was an error with models.</p>';
}
?>
            </select>
            &nbsp&nbsp&nbsp&nbsp
            <label for="year">Car Make Year:</label>
            <select name="year" id="year">
                <option value="0">Any</option>
<?php
if (!empty($yearsList)) {
    for ($i = 0; $i < count($yearsList); $i++) {
        echo '<option value="' . $yearsList[$i]->id . '">' . $yearsList[$i]->year . '</option>';
    }
} else {
    echo '<p class="error">There was an error with years.</p>';
}
?>
            </select>
        </fieldset>
        <fieldset>
            <label for="minPrice">Min Daily Price:</label>
            <input type="range" name="minPrice" id="minPrice" value="<?php echo $minPrice; ?>" min="<?php echo $minPrice; ?>" max="<?php echo $maxPrice; ?>" oninput="range_min_disp.value = minPrice.value" onchange="document.getElementById('maxPrice').min=document.getElementById('minPrice').value;">
            <output  id="range_min_disp"><?php echo $minPrice; ?></output>
        </fieldset>
        <fieldset>
            <label for="maxPrice">Max Daily Price:</label>
            <input type="range" name="maxPrice" id="maxPrice" value="<?php echo $minPrice; ?>" min="<?php echo $minPrice; ?>" max="<?php echo $maxPrice; ?>" oninput="range_max_display.value = maxPrice.value">
            <output for="maxPrice" id="range_max_display"></output>
        </fieldset>
        <center>
            <input type ="submit" class ="button SubButton" value ="Search" />
            <input type="hidden" name="submitted" value="1" />
        </center>
    </form>
</div> <!-- END SIDEBAR -->
</body>
<!-- DATES -->
<script type="text/javascript">
    let date = new Date();

    function addMonthsToDate(input, noOfMonths) {
        input.setMonth(input.getMonth() + noOfMonths);
        return input.toISOString().substr(0,10);
    }
    // Default value today
    let today = date.toISOString().substr(0,10);

    function updateValue(startDate) {
        // Default endDate value is start date value
        today = startDate;
        let endDate = document.getElementById("endDate").getAttribute('value');
        if (today > endDate)
            {
                document.getElementById("endDate").value = today;
                document.getElementById("endDate").setAttribute("min", today);
                // Maximum selectable end date is six months from today
                document.getElementById("endDate").setAttribute("max", max);
            }
        return today;
    }
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
    document.getElementById("endDate").setAttribute("max", max);
</script>
</html>