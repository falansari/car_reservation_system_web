<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Reservation Summary</title>
        <link rel="stylesheet" href="css/table.css">
    </head>
    <body>
<?php
include_once 'Header.php';
if (isset($_POST['car_id'])) {
    $car_id = trim($_POST['car_id']);
}
if (!empty($_POST['accessoriesList'])) {
    $accessories = $_POST['accessoriesList'];
} else {
    $accessories = null;
}
if (isset($_POST['startDate'])) {
    $startDate = trim($_POST['startDate']);
}
if (isset($_POST['endDate'])) {
    $endDate = trim($_POST['endDate']);
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
if (isset($_POST['totalDays'])) {
    $totalDays = trim($_POST['totalDays']);
}
if (isset($_POST['totalCost'])) {
    $totalCost = trim($_POST['totalCost']);
}
if (isset($_POST['paymentType'])) {
    $paymentType = trim($_POST['paymentType']);
}
if (isset($_POST['cardProvider'])) {
    $cardProvider = trim($_POST['cardProvider']);
} else {
    $cardProvider = null;
}
if (isset($_POST['cardNumber'])) {
    $cardNumber = trim($_POST['cardNumber']);
} else {
    $cardNumber = null;
}
if (isset($_POST['cardExpiry'])) {
    $cardExpiry = trim($_POST['cardExpiry']);
} else {
    $cardExpiry = null;
}
if (isset($_POST['cvc'])) {
    $cvc = trim($_POST['cvc']);
} else {
    $cvc = null;
}

include_once 'models/Reservations.php';
$reservations = new Reservations();
$newReservation = $reservations->save($car_id, $accessories, $paymentType,
    $nationality, $startDate, $endDate, $totalCost, $firstName, $middleName,
    $lastName, $address, $cpr, $phone, $cardProvider, $cardNumber, $cardExpiry, $cvc);
$reservationData = $reservations->reservationDetails($newReservation);
$reservationAccessories = $reservations->reservationAccessories($newReservation);

$image = $reservationData->image;
$image = '<img src="data:image/jpg;base64,' . base64_encode($image) . '" width="200px"/>';
?>
<center>
<div id="aboutsidebar" class="overflow">
    <h1>Summary</h1>
    <h4>Reservation Code <?php echo $reservationData->id; ?></h4>
    <form>
                <fieldset>
                    <legend>Reservation Details:</legend>
                    <div class="row">
                        <div class="column">
                            <label for="startDate">Start Date:</label>
                            <input type="date" name="startDate" id="startDate" value="<?php echo $reservationData->start_date; ?>" readonly>
                        </div>
                        <div class="column">
                            <label for="endDate">End Date:</label>
                            <input type="date" name="endDate" id="endDate" value="<?php echo $reservationData->end_date; ?>" readonly>
                        </div>
                    </div>
                    <br><br>
                    <div class="row">
                        <div class="column">
                            <label for="totalDays">Total Reservation Days: <?php echo $totalDays; ?></label>
                        </div>
                        <div class="column">
                            <label for="totalCost">Total Reservation Cost: <?php echo $reservationData->total_rental_cost . 'BHD'; ?></label>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Customer Details:</legend>
                    <div class="row">
                        <div class="column">
                            <label for="firstName">First Name: <?php echo $reservationData->first_name; ?></label>
                        </div>
                        <div class="column">
                            <label for="middleName">Middle Name: <?php echo $reservationData->middle_name; ?></label>
                        </div>
                    </div>
                    <br><br>
                    <div class="row">
                        <div class="column">
                            <label for="lastName">Last Name: <?php echo $reservationData->last_name; ?></label>
                        </div>
                        <div class="column">
                            <label for="phone">Phone/Mobile Number: <?php echo $reservationData->phone_no; ?></label>
                        </div>
                    </div>
                    <br><br>
                    <div class="row">
                        <div class="column">
                            <label for="country">Country: <?php echo $reservationData->country_name_en; ?></label>
                        </div>
                        <div class="column">
                            <label for="nationality">Nationality: <?php echo $reservationData->country_nationality_en; ?></label>
                        </div>
                    </div>
                    <br><br>
                    <div class="row">
                        <div class="column">
                            <label for="cpr">National Identity Number: <?php echo $reservationData->CPR; ?></label>
                        </div>
                        <div class="column">
                            <label for="address">Billing Address:</label>
                            <textarea name="address" id="address" cols="40" rows="1" readonly><?php echo $reservationData->address; ?></textarea>
                        </div>
                    </div>
                    <br><br>
                    <div class="row">
                        <div class="column"></div>
                        <div class="column">
                            <label for="cardNumber">Credit Card Number: <?php echo $reservationData->card_number; ?></label>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Car Details:</legend>
                    <div class="row">
                        <div class="column">
                            <h2><?php echo $reservationData->model . ' ' . $reservationData->year . ' ' . $reservationData->category; ?></h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="column">
                            <?php echo $image; ?>
                        </div>
                        <div class="column">
                        <label for="dailyPrice">Daily Rental Price:</label>
                            <label for="dailyPrice"><?php echo $reservationData->daily_rental_price . 'BHD'; ?></label>
                            <br><br>
                            <label for="accessoriesList">Rental Accessories:</label>
                            <ol>
<?php
if (!empty($reservationAccessories)) {
    for ($i = 0; $i < count($reservationAccessories); $i++) {
        echo '<li>' . $reservationAccessories[$i]->accessory . ', ' . $reservationAccessories[$i]->daily_rental_price . 'BHD per day</li><br/>';
    }
} else {
    echo '<li>No accessories added.</li>';
}
?>
                            </ol>
                        </div>
                    </div>
                </fieldset>
                <input type="hidden" name="car_id" value="<?php echo $car->id; ?>">
                <br />
                <button onclick="location.href='index.php'" type="button">Back to Homepage</button>
            </form>
</div>
</center>
</body>
</html>