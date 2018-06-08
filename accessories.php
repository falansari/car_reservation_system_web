<!DOCTYPE html>
<?php
include_once 'models/Accessories.php';
$accessories = new Accesssories();
$accessoriesList = $accessories->listAll();

if (isset($_GET['id'])) {
    $car_id = trim($_GET['id']);
}
?>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Accessories to Reservation</title>
        <link rel="stylesheet" href="css/table.css">
    </head>
    <body>
        <?php
include_once 'Header.php';
?>
    <center>
        <div id="aboutsidebar" class="overflow">
            <h1>Add Accessories</h1>
            <h4>Check the boxes you want accessories for.</h4>
            <button onclick="location.href='checkout.php?car_id=<?php echo $car_id; ?>'" type="button">Skip</button>
            &nbsp
            <button onclick="location.href='index.php'" type="button">Cancel Reservation</button>
            <form action="checkout.php" method="POST">
            <table>
                <tr>
                    <th>Accessory</th>
                    <th>Available Quantity</th>
                    <th>Daily Rental Price</th>
                    <th>Add to Reservation</th>
                </tr>
                <tbody>
                    <?php
if (!empty($accessoriesList)) {
    for ($i = 0; $i < count($accessoriesList); $i++) {
        echo '<tr><td>' . $accessoriesList[$i]->accessory . '</td>
        <td>' . $accessoriesList[$i]->available_qty . '</td>
        <td>' . $accessoriesList[$i]->daily_rental_price . 'BHD</td>
        <td><input type="checkbox" name="accessory_list[]" value="' . $accessoriesList[$i]->id . '"></td>
        </tr>';
    }
} else {
    echo '<p class="error">There was an error with accessories.</p>';
}
?>
                </tbody>
            </table>
            <br />
            <input type="submit" value="Add Accessories" />
            <input type="hidden" name="car_id" value="<?php echo $car_id; ?>">
            <input type="hidden" name="submitted" value="1">
            </form>
        </div>
      </center>
    </body>
</html>