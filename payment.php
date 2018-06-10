<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Reservation Payment</title>
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

include_once 'models/PaymentTypes.php';
$paymentTypes = new PaymentTypes();
$paymentTypeslist = $paymentTypes->listAll();

include_once 'models/CardProviders.php';
$cardProviders = new CardProviders();
$cardProvidersList = $cardProviders->listAll();
?>
<center>
<div id="aboutsidebar" class="overflow">
    <h1>Payment</h1>
    <h3>Add Payment Details</h4>
    <form action="summary.php" method="POST">
        <input type="hidden" name="car_id" value="<?php echo $car_id; ?>">
        <input type="hidden" name="startDate" value="<?php echo $startDate; ?>">
        <input type="hidden" name="endDate" value="<?php echo $endDate; ?>">
        <input type="hidden" name="firstName" value="<?php echo $firstName; ?>">
        <input type="hidden" name="middleName" value="<?php echo $middleName; ?>">
        <input type="hidden" name="lastName" value="<?php echo $lastName; ?>">
        <input type="hidden" name="nationality" value="<?php echo $nationality; ?>">
        <input type="hidden" name="cpr" value="<?php echo $cpr; ?>">
        <input type="hidden" name="phone" value="<?php echo $phone; ?>">
        <input type="hidden" name="address" value="<?php echo $address; ?>">
        <input type="hidden" name="totalDays" value="<?php echo $totalDays; ?>">
        <input type="hidden" name="totalCost" value="<?php echo $totalCost; ?>">
        <?php
if (!empty($accessories)) {
    for ($i = 0; $i < count($accessories); $i++) {
        echo '<input type="hidden" name="accessoriesList[]" value="' . $accessories[$i] . '" />';
    }
}
?>
        <fieldset>
            <legend>Payment Method:</legend>
            <div class="row">
                <div class="column">
                    <label for="paymentType">Payment Type:</label>
                    <select name="paymentType" id="paymentType" required>
                        <option value="0">Payment Method</option>
                        <?php
if (!empty($paymentTypeslist)) {
    for ($i = 0; $i < count($paymentTypeslist); $i++) {
        echo '<option value="' . $paymentTypeslist[$i]->id . '">' . $paymentTypeslist[$i]->payment_type . '</option>';
    }
}
?>
                    </select>
                </div>
            </div>
        </fieldset>
        <fieldset>
            <legend>Card Details <u>(For Paying with Card Only):</u></legend>
            <div class="row">
                <div class="column">
                    <label for="cardProvider">Card Provider:</label>
                    <select name="cardProvider" id="cardProvider">
                        <option value="0">Card Provider</option>
                        <?php
if (!empty($cardProvidersList)) {
for ($i = 0; $i < count($cardProvidersList); $i++) {
    echo '<option value="' . $cardProvidersList[$i]->id . '">' . $cardProvidersList[$i]->card_provider . '</option>';
}
}
?>
                    </select>
                </div>
                <div class="column">
                    <label for="cardNumber">Card Number:</label>
                    <input type="number" name="cardNumber" id="cardNumber">
                </div>
            </div>
            <br><br>
            <div class="row">
                <div class="column">
                    <label for="cardExpiry">Card Expiry Date:</label>
                    <input name="cardExpiry" id="cardExpiry" placeholder="MM-YYYY">
                </div>
                <div class="column">
                    <label for="cvc">Card CVC:</label>
                    <input name="cvc" id="cvc" type="password" maxlength="4">
                </div>
            </div>
        </fieldset>
        <br><br>
        <button type="submit">Submit Reservation</button>
    </form>
</div>
</center>
</body>
</html>