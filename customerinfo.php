<!DOCTYPE html>
<?php
include_once 'models/Cars.php';
include_once 'models/Countries.php';
$countries = new Countries();
$nationalities = $countries->listNationalitiesEn();

if (isset($_POST['car_id'])) {
    $car_id = trim($_POST['car_id']);
}
if (isset($_GET['car_id'])) {
    $car_id = trim($_GET['car_id']);
}

if (!empty($_POST['accessory_list'])) {
    $accessories = $_POST['accessory_list'];
}
?>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Reservation Details</title>
        <link rel="stylesheet" href="css/table.css">
    </head>
    <body>
        <?php
include_once 'Header.php';

if (isset($_POST['submitted'])) {
    if (!empty($_POST['car_id']) && !empty($_POST['startDate']) && !empty($_POST['endDate'])) {
        $car = trim($_POST['car_id']);
        $start = trim($_POST['startDate']);
        $end = trim($_POST['endDate']);

        $cars = new Cars();
        $doubleBooked = $cars->checkDoubleBooking($car, $start, $end);

        if ($doubleBooked === true) {
            echo '<p class="error">This car is not available within the specified dates. Please change dates or choose a different car.</p>';
        } else { // Pass all data to checkout page
            if (!empty($_POST['accessoriesList'])) {
                $accessories = serialize($_POST['accessoriesList']);
            }
            if (isset($_POST['firstName'])) {
                $firstName = trim($_POST['firstName']);
            }
            if (isset($_POST['middleName'])) {
                $middleName = trim($_POST['middleName']);
            }
            if (isset($_POST['lastName'])) {
                $lastName = trim($_POST['lastName']);
            }
            if (isset($_POST['nationality'])) {
                $nationality = trim($_POST['nationality']);
            }
            if (isset($_POST['cpr'])) {
                $cpr = trim($_POST['cpr']);
            }
            if (isset($_POST['phone'])) {
                $phone = trim($_POST['phone']);
            }
            if (isset($_POST['address'])) {
                $address = trim($_POST['address']);
            }

            $url = 'checkout.php?car_id=' . $car . '&startDate=' . $start . '&endDate=' . $end .
                '&firstName=' . $firstName . '&middleName=' . $middleName . '&lastName=' . $lastName .
                '&nationality=' . $nationality . '&cpr=' . $cpr . '&phone=' . $phone . '&address=' . $address .
                '&accessoriesList[]=' . $accessories . '';
            header("Location: " . $url . ""); /* Redirect browser */
            exit();
        }
    }
}
?>
    <center>
        <div id="aboutsidebar" class="overflow">
            <h1>Reservation Details</h1>
            <form action="customerinfo.php" method="POST">
                <fieldset>
                    <legend>Reservation Dates:</legend>
                    <div class="row">
                        <div class="column">
                            <label for="startDate">Start Date*:</label>
                            <input type="date" name="startDate" id="startDate" value="<?php echo date('Y-m-d'); ?>" onchange="updateValue(this.value)" id="startDate" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required>
                        </div>
                        <div class="column">
                            <label for="endDate">End Date*:</label>
                            <input type="date" name="endDate" id="endDate" value="<?php echo date('Y-m-d'); ?>" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Customer Info:</legend>
                    <div class="row">
                        <div class="column">
                            <label for="firstName">First Name*:</label>
                            <input type="text" name="firstName" id="firstName" placeholder="Your first name" required>
                        </div>
                        <div class="column">
                            <label for="middleName">Middle Name*:</label>
                            <input type="text" name="middleName" id="middleName" placeholder="Your middle name" required>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="column">
                            <label for="lastName">Last Name*:</label>
                            <input type="text" name="lastName" id="lastName" placeholder="Your last name" required>
                        </div>
                        <div class="column">
                            <label for="nationality">Nationality*:</label>
                            <select name="nationality" id="nationality" required>
                                <option value="">Select Your Nationality</option>
                            <?php
if (!empty($nationalities)) {
    for ($i = 0; $i < count($nationalities); $i++) {
        echo '<option value="' . $nationalities[$i]->id . '">' . $nationalities[$i]->country_nationality_en . '</option>';
    }
} else {
    echo '<p class="error">There was a problem with nationalities.</p>';
}
?>
                            </select> <!-- END NATIONALITIES -->
                        </div>
                    </div>
                    <br><br>
                    <div class="row">
                        <div class="column">
                            <label for="cpr">CPR Number*:</label>
                            <input type="text" name="cpr" id="cpr" placeholder="National Identity number" required>
                        </div>
                        <div class="column">
                            <label for="phone">Phone/Mobile Number*:</label>
                            <input type="tel" name="phone" id="phone" placeholder="Your phone number" required>
                        </div>
                    </div>
                    <br><br>
                    <div class="row">
                        <div class="column left">
                            <label for="address">Billing Address*:</label>
                            <textarea name="address" id="address" cols="50" rows="1" placeholder="BLD No - Road No - Block No - City, Country" required></textarea>
                        </div>
                    </div>
                </fieldset>
                <br>
                <button onclick="location.href='index.php'" type="button">Cancel Reservation</button>
                &nbsp&nbsp&nbsp&nbsp
                <button type="submit" value="continue">Proceed with Reservation</button>
                <input type="hidden" name="submitted" value="1" />
                <input type="hidden" name="car_id" value="<?php echo $car_id; ?>" required>
                <?php
if (!empty($accessories)) {
    $value = "";
    for ($i = 0; $i < count($accessories); $i++) {
        $value .= '<input type="hidden" name="accessoriesList[' . $accessories[$i] . ']" value="' . $accessories[$i] . '" required />';
    }
    echo $value;
}
?>
            </form>
            <br />
        </div>
      </center>
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