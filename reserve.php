<!DOCTYPE html>
<?php
include_once 'models/Cars.php';
$cars = new Cars();

if (isset($_GET['id'])) {
    $id = trim($_GET['id']);
}
$car = $cars->getCar($id);

$image = $car->image;
$image = '<img src="data:image/jpg;base64,' . base64_encode($image) . '" width="200px"/>';
?>
<html>
    <head>
        <meta charset="UTF-8">
        <title><?php echo $car->model . ' ' . $car->year; ?></title>
        <link rel="stylesheet" href="css/table.css">
    </head>
    <body>
        <?php
include_once 'Header.php';
?>
    <center>
        <div id="aboutsidebar" class="overflow">
            <h1><?php echo $car->model . ' ' . $car->year . ' Reservation'; ?></h1>
            <table>
                <tr>
                    <th>Image</th>
                    <th>Manufacturer</th>
                    <th>Model</th>
                    <th>Make Year</th>
                    <th>Category</th>
                    <th>Daily Rental Price</th>
                </tr>
                <tbody>
                    <tr>
                        <td><?php echo $image; ?></td>
                        <td><?php echo $car->manufacturer; ?></td>
                        <td><?php echo $car->model; ?></td>
                        <td><?php echo $car->year; ?></td>
                        <td><?php echo $car->category; ?></td>
                        <td><?php echo $car->daily_rental_price . 'BHD'; ?></td>
                    </tr>
                </tbody>
            </table>
            <br />
            <button onclick="location.href='index.php'" type="button">Cancel Reservation</button>
            &nbsp
            <button onclick="location.href='accessories.php?id=<?php echo $id; ?>'" type="button">Proceed with Reservation</button>
        </div>
      </center>
    </body>
</html>
