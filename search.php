<?php
require_once 'models/Cars.php';

$startDate = trim($_POST['startDate']);
var_dump('start ' . $startDate);
$endDate = trim($_POST['endDate']);
$manufacturer = trim($_POST['manufacturer']);
$category = trim($_POST['category']);
$model = trim($_POST['model']);
$year = trim($_POST['year']);
$minPrice = trim($_POST['minPrice']);
$maxPrice = trim($_POST['maxPrice']);
var_dump($startDate, $endDate, $manufacturer, $category, $model, $year, $minPrice, $maxPrice);

$cars = new Cars();
$row = $cars->searchCarsQueryBuilder($startDate, $endDate, $manufacturer, $model, $year, $category, $minPrice, $maxPrice);
var_dump($row);
if (!empty($row)) {
    echo '<p>';
    for ($i = 0; $i < count($row); $i++) {
        echo $row[$i]->id;
        echo $row[$i]->manufacturer;
        echo $row[$i]->model;
        echo $row[$i]->year;
        echo $row[$i]->category;
        echo '<br />';
    }
    echo '</p>';
} else {
    echo '<p class="error">No results found.</p>';
}
