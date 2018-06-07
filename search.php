<!DOCTYPE html>
<?php
require_once 'models/Cars.php';
$cars = new Cars();

if (isset($_POST['startDate'])) {
    $startDate = trim($_POST['startDate']);
} else {
    $startDate = date('Y-m-d');
}

if (isset($_POST['endDate'])) {
    $endDate = trim($_POST['endDate']);
} else {
    $endDate = date('Y-m-d');
}

if (isset($_POST['manufacturer'])) {
    $manufacturer = trim($_POST['manufacturer']);
} else {
    $manufacturer = 0;
}

if (isset($_POST['category'])) {
    $category = trim($_POST['category']);
} else {
    $category = 0;
}

if (isset($_POST['model'])) {
    $model = trim($_POST['model']);
} else {
    $model = 0;
}

if (isset($_POST['year'])) {
    $year = trim($_POST['year']);
} else {
    $year = 0;
}

if (isset($_POST['minPrice'])) {
    $minPrice = trim($_POST['minPrice']);
} else {
    $minPrice = $cars->minPrice();
}

if (isset($_POST['maxPrice'])) {
    $maxPrice = trim($_POST['maxPrice']);
} else {
    $maxPrice = $cars->maxPrice();
}

/*** PAGINATION ***/
// How many records displayed per page
$display = 2;
// Which record row number to start with.
if (isset($_GET['s'])) {
    $start = trim($_GET['s']);
} else {
    $start = 0;
}

$dataRows = $cars->searchCarsQueryBuilder(
    $start, $display,
    $startDate, $endDate, $manufacturer, $model, $year,
    $category, $minPrice, $maxPrice);

$totRows = $cars->searchCarsQueryBuilder(null, null,
    $startDate, $endDate, $manufacturer, $model, $year,
    $category, $minPrice, $maxPrice);

$rowCount = count($totRows);

if (isset($_GET['p'])) {
    $pages = trim($_GET['p']);
} else {
    if ($rowCount > $display) {
        $pages = (int) ceil($rowCount / $display);
    } else {
        $pages = 1;
    }
}
?>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Car Search Results</title>
        <link rel="stylesheet" href="css/table.css">
        <link rel="stylesheet" href="css/pagination.css">
    </head>
    <body>
        <?php
include_once 'Header.php';
?>
    <center>
        <div id="aboutsidebar" class="overflow">
            <h1>Search Results</h1>
            <table>
                <tr>
                    <th>Image</th>
                    <th>Car</th>
                    <th>Category</th>
                    <th>Daily Price</th>
                    <th>Book Car</th>
                </tr>
                <tbody>
                    <?php
if (!empty($dataRows)) {
    for ($i = 0; $i < $display; $i++) {
        $image = $dataRows[$i]->image;
        $image = '<img src="data:image/jpg;base64,' . base64_encode($image) . '"/>';
        echo '<tr>
        <td>' . $image . '</td>
        <td>' . $dataRows[$i]->model . ' ' . $dataRows[$i]->year . '</td>
        <td>' . $dataRows[$i]->category . '</td>
        <td>' . $dataRows[$i]->daily_rental_price . '</td>
        <td><a href="reserve.php?id=' . $dataRows[$i]->id . '">Book Now</a></td>
        </tr>';
    }
    if ($pages > 1) {
        echo '<br /><ul class="pagination">';
        $currentPage = ($start / $display) + 1;
        // Create previous button if not on first page
        if ($currentPage != 1) {
            echo '<li><a href="search.php?s=' . ($start - $display) .
                '&p=' . $pages . '">&laquo;</a></li>';
        }
        // Create page links except on current page
        for ($i = 1; $i <= $pages; $i++) {
            if ($i != $currentPage) {
                echo '<li><a href="search.php?s=' . ($display * ($i - 1)) .
                    '&p=' . $pages . '">&nbsp' . $i . '&nbsp</a></li>';
            }
        }
        // Create next button if not on last page
        if ($currentPage != $pages) {
            echo '<li><a href="search.php?s=' . ($start + $display) . '&p=' . $pages .
                '">&raquo;</a></li>';
        }
        echo '</ul>';
    }
} else {
    echo '<p class="error">No cars matching your search criteria found.</p>';
}
?>
                </tbody>
            </table>
        </div>
      </center>
    </body>
</html>
