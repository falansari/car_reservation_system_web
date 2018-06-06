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
        
        
        $q = "SELECT reservations_count,cat.category,m.manufacturer, mo.model,y.year,c.daily_rental_price
from most_popular_cars_report r
 JOIN cars c on c.id = r.id
JOIN car_categories cat on cat.id = c.category_id
join make_years y on y.id = c.make_year_id
join manufacturers m on m.id = c.manufacturer_id
join models mo on mo.id = c.model_id
where  r.car_id = 1
ORDER BY reservations_count DESC
LIMIT 10
";
                
                
        $db = new Database();
        $data = $db->multiFetch($q);

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
                     <td><h4>Number Of Reservations</h4></td>
                     <td><h4>Category</h4></td>
                     <td><h4>Manufacturer</h4></td>
                     <td><h4>Model</h4></td>
                     <td><h4>Year</h4></td>
                     <td><h4>Daily Rent Price</h4></td>
                     ';

                $bg = '#f2f2f2';

                for ($i = 0; $i < $row_cnt; $i++) {
                    $bg = ($bg == '#f2f2f2' ? '#f2f2f2' : '#f2f2f2');

                    $table .= '<tr bgcolor="' . $bg . '">
                          <td>' . $data[$i]->reservations_count. '</td>
                          <td>' . $data[$i]->category. '</td>
                          <td>' . $data[$i]->manufacturer . '</td>
                          <td>' . $data[$i]->model . '</td>
                          <td>' . $data[$i]->year. '</td>
                          <td>' . $data[$i]->daily_rental_price . '</td>';

                }
                $table .= '</table>';

                echo $table;
            }
        }
        else {
            echo '<p class="error"> Oh dear. There was an error</p>';
        }
        ?>
    </body>
</html>
