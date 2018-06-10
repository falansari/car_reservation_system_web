<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
       <style>
table,th,td {
    border: 4px solid #1f1f7a;
     border-collapse: collapse;
     padding: 8px;
     border-spacing: 10px;
}

</style>
    </head>
    <body>
        <?php
        
        include_once 'Database.php';
        include_once 'AdminHeader.php';
        
        
        $q = "SELECT c.image,c.id,cat.category,m.manufacturer, mo.model,y.year,c.daily_rental_price
from cars c
JOIN car_categories cat on cat.id = c.category_id
join make_years y on y.id = c.make_year_id
join manufacturers m on m.id = c.manufacturer_id
join models mo on mo.id = c.model_id
";
                
                
        $db = new Database();
        $data = $db->multiFetch($q);
           ?>
        <form>
            <center><h2>Add New Car </h2><input type="button" class="Button SubButton" value="Add a new car" onclick="window.location.href='AddCar.php'" /></center>
</form>
            <center>
<?php

        if (!empty($data)) {
            $row_cnt = count($data);

            if ($row_cnt == 0) {
                echo '<br>';
                echo '<p>sorry no data found</p>';
            } else {
                echo '<br>';
                //display a table of results
                $table = '<table class="CSSTableGenerator" width="95%">' .
                        '<tr bgcolor="#f2f2f2">
                      
                      <td><h4>Edit</h4></td>
                      <td><h4>Delete</h4></td>
                    <td><h4>Image</h4></td>
                     <td><h4>Category</h4></td>
                     <td><h4>Manufacturer</h4></td>
                     <td><h4>Model</h4></td>
                     <td><h4>Year</h4></td>
                     <td><h4>Daily Rent Price</h4></td>
                     ';

                $bg = '#f2f2f2';
                
                

                for ($i = 0; $i < $row_cnt; $i++) {
                    $bg = ($bg == '#f2f2f2' ? '#f2f2f2' : '#f2f2f2');
$img = $data[$i]->image;
$img = '<img src="data:image/jpg;base64,'.base64_encode( $img ).'" width="200px"/>';
                    $table .= '<tr bgcolor="' . $bg . '">
                        <center>
                        <td><a href="EditCars.php?id=' .  $data[$i]->id . '">Edit</a></td>
                            <td><a href="deleteCar.php?id=' .  $data[$i]->id . '">Delete</a></td>
                          <td>' . $img.'</td>
                          <td>' . $data[$i]->category. '</td>
                          
                          <td>' . $data[$i]->manufacturer . '</td>
                          <td>' . $data[$i]->model . '</td>
                          <td>' . $data[$i]->year. '</td>
                          <td>' . $data[$i]->daily_rental_price . '</td></tr>';

                }
                $table .= '</table>';

                echo $table;
               
            }
        }
        else {
            echo '<p class="error"> Oh dear. No Data Found</p>';
        }
        ?>
    </body>
</html>
