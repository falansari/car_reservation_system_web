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
    var_dump('car: ' . $car_id);
}
if (!empty($_POST['accessoriesList'])) {
    $accessories = $_POST['accessoriesList'];
    var_dump($accessories);
}
if (isset($_POST['startDate'])) {
    $startDate = trim($_POST['startDate']);
    var_dump('start: ' . $startDate);
}
if (isset($_POST['endDate'])) {
    $endDate = trim($_POST['endDate']);
    var_dump('end: ' . $endDate);
}
if (isset($_POST['firstName'])) {
    $firstName = trim($_POST['firstName']);
    var_dump('first: ' . $firstName);
}
if (isset($_POST['middleName'])) {
    $middleName = trim($_POST['middleName']);
    var_dump('middle: ' . $middleName);
}
if (isset($_POST['lastName'])) {
    $lastName = trim($_POST['lastName']);
    var_dump('last: ' . $lastName);
}
if (isset($_POST['nationality'])) {
    $nationality = trim($_POST['nationality']);
    var_dump('nationality: ' . $nationality);
}
if (isset($_POST['cpr'])) {
    $cpr = trim($_POST['cpr']);
    var_dump('cpr: ' . $cpr);
}
if (isset($_POST['phone'])) {
    $phone = trim($_POST['phone']);
    var_dump('phone: ' . $phone);
}
if (isset($_POST['address'])) {
    $address = trim($_POST['address']);
    var_dump('address: ' . $address);
}
if (isset($_POST['totalDays'])) {
    $totalDays = trim($_POST['totalDays']);
    var_dump('total days: ' . $totalDays);
}
if (isset($_POST['totalCost'])) {
    $totalCost = trim($_POST['totalCost']);
    var_dump('total cost: ' . $totalCost);
}
if (isset($_POST['paymentType']))
{
    $paymentType = trim($_POST['paymentType']);
    var_dump($paymentType);
}
if (isset($_POST['cardProvider']))
{
    $cardProvider = trim($_POST['cardProvider']);
    var_dump($cardProvider);
}
if (isset($_POST['cardNumber']))
{
    $cardNumber = trim($_POST['cardNumber']);
    var_dump($cardNumber);
}
if (isset($_POST['cardExpiry']))
{
    $cardExpiry = trim($_POST['cardExpiry']);
    var_dump($cardExpiry);
}
if (isset($_POST['cvc']))
{
    $cvc = trim($_POST['cvc']);
    var_dump($cvc);
}
?>
<center>
<div id="aboutsidebar" class="overflow">
    <h1>Summary</h1>
    <h4>Thank You for Your Order</h4>
</div>
</center>
</body>
</html>