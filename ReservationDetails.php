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
    </head>
    <body>


        <?php
        //Get Code
        if (isset($_POST['reservationCode'])) {
            $id = $_POST['reservationCode'];
        }
        
        include_once 'Header.php';
        include_once 'Database.php';

        $db = new Database();
        $q = "SELECT  payment_type_id FROM reservations WHERE id = $id";
       

        $data = $db->singleFetch($q);

        $pay = $data->payment_type_id;
        //echo $pay;


        $q2 = "SELECT  pay.payment_type, pro.card_provider,c.country_name_en,r.total_rental_cost ,r.first_name, r.middle_name, r.last_name, r.address, r.CPR, r.phone_no, r.card_number, r.card_expiry_date, r.card_security_digits
from reservations r
JOIN payment_types pay on pay.id = r.payment_type_id
left join  card_providers pro on pro.id = r.card_provider_id
join countries c on c.id = r.country_id

where r.id = $id";

        $data2 = $db->singleFetch($q2);

        $q3 = "SELECT  a.id,a.accessory, ra.reserve_qty from  reservation_accessories ra join  accessories a on a.id = ra.accessory_id where reservation_id =$id";

        $data3 = $db->singleFetch($q3);
        
        $q4 = "SELECT car_id from reservation_cars where reservation_id = $id";

        $data4 = $db->singleFetch($q4);
        $carid = $data4->car_id;

        $q5 = "SELECT c.image,c.id,cat.category,m.manufacturer, mo.model,y.year,c.daily_rental_price
from cars c
JOIN car_categories cat on cat.id = c.category_id
join make_years y on y.id = c.make_year_id
join manufacturers m on m.id = c.manufacturer_id
join models mo on mo.id = c.model_id
where c.id = $carid
";
        $data5 = $db->singleFetch($q5);

        $img = $data5->image;
        $img = '<img src="data:image/jpg;base64,' . base64_encode($img) . '" height="100px" width="120px"/>';
        
        if ($data3 != null){
            
        }
        ?>

    <center>
        <div id="reservation">

            <b>Customer Information</b>  <br> <br><br>
            <b>First Name: </b> <?php echo $data2->first_name; ?> <br><br> 
            <b>Middle Name: </b> <?php echo $data2->middle_name; ?>  <br><br>
            <b>Last Name: </b> <?php echo $data2->last_name; ?> <br> <br> 
            <b>CPR: </b> <?php echo $data2->CPR; ?> <br> <br>
            <b>Phone Number: </b> <?php echo $data2->phone_no; ?><br> <br>
            <b>Address: </b> <?php echo $data2->address; ?> <br> <br><br>
            <b>Rented Car: </b><br> <br>
            <?php echo $img; ?> <br> <br>
            <b>Car category: </b> <?php echo $data5->category; ?> <br> <br>
            <b>Car Model: </b> <?php echo $data5->model; ?> <br> <br>
            <b>Car Year: </b> <?php echo $data5->year; ?> <br> <br><br>
            <b>Added Car Items</b><br> <br>  
            <b>Accessory: </b> <?php 
            if ($data3 != null){
            echo $data3->accessory;
        }
        else {
            echo 'No accessory';
        }
            
            ?> <br> <br>  
            <b>Quantity: </b> <?php
            
            if ($data3 != null){
            echo $data3->reserve_qty;
        }
        else {
            echo 'No accessory';
        }
            
            ?> <br> <br>
            <br>
            <b>Total Rental Cost: </b> <?php echo $data2->total_rental_cost; ?> <br> <br>


<form action="editReservation.php" method="post" id="code">
    <input type ="submit" class ="Button SubButton" value ="Edit" />
                <input type="hidden" name="reservationCode" value="<?php echo $id; ?>" />
                
            </form>
        </div>
    </center>


</body>
</html>
