<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
include_once 'Header.php';
if (isset($_POST['reservationCode'])) {
    $id = trim($_POST['reservationCode']);
} elseif (isset($_GET['reservationCode']))
{
    $id = trim($_GET['reservationCode']);
}

include_once 'Dropdownfunctions.php';
$drop = new Dropdownfunctions();

include_once 'Database.php';
$db = new Database();
$q = "SELECT  payment_type_id FROM reservations WHERE id =$id";

$data = $db->singleFetch($q);

$pay = $data->payment_type_id;

$q2 = "SELECT  pay.payment_type, pro.card_provider,c.country_name_en,r.total_rental_cost ,r.first_name, r.middle_name, r.last_name, r.address, r.CPR, r.phone_no, r.card_number, r.card_expiry_date, r.card_security_digits
from reservations r
JOIN payment_types pay on pay.id = r.payment_type_id
left join  card_providers pro on pro.id = r.card_provider_id
join countries c on c.id = r.country_id
where r.id = $id";

$data2 = $db->singleFetch($q2);

$q3 = "SELECT  a.id,a.accessory, ra.reserve_qty from  reservation_accessories ra join  accessories a on a.id = ra.accessory_id where reservation_id =$id";

$data3 = $db->singleFetch($q3);

?>

         <center>
        <div id="adminalter">
            <form action="editReservation.php" method="post">
                <h3 style="color: red">Editing Reservation will add 10% surcharge!</h3>
                <b>Customer Information</b> <br> <br>
                <b>First Name</b> <input type="text" name="firstName" size="20" value="<?php echo $data2->first_name; ?>" /> <br><br>
                <b>Middle Name</b>  <input type="text" name="middleName" size="20" value="<?php echo $data2->middle_name; ?>" /> <br><br>
                <b>Last Name</b>  <input type="text" name="lastName" size="20" value="<?php echo $data2->last_name; ?>" /> <br> <br>
                <b>CPR</b>  <input type="text" name="CPR" size="20" value="<?php echo $data2->CPR; ?>" /> <br> <br>
                <b>Phone Number</b>  <input type="text" name="phone" size="20" value="<?php echo $data2->phone_no; ?>" /> <br> <br>

                <b>Address</b>  <input type="textbox" name="address" size="20" value="<?php echo $data2->address; ?>" /> <br> <br>


                 <b>Car Items</b><br> <br>
                 Select Accessory :
                    <?PHP
$drop->accessory()
?>
                </checkbox>  <br> <br>



<div align="center">

                    <input type ="submit" class ="Button SubButton" value ="Change" />

                </div>
                <input type="hidden" name="submitted" value="<?php echo $id; ?>" />

            </form>
        </div>
    </center>


</body>
</html>
<?php
if (isset($_POST['submitted'])) {
    $reservationId = trim($_POST['submitted']);
    $fname = trim($_POST['firstName']);
    $mname = trim($_POST['middleName']);
    $lname = trim($_POST['lastName']);
    $CPR = trim($_POST['CPR']);
    $phone = trim($_POST['phone']);
    $address = trim($_POST['address']);

    $q4 = "UPDATE reservations 
    SET first_name ='$fname', 
    middle_name ='$mname',
    last_name ='$lname',
    address ='$address', 
    CPR = $CPR, 
    phone_no = '$phone',
    total_rental_cost = total_rental_cost + (total_rental_cost * 0.1) 
    WHERE id = $reservationId ";
    $data4 = $db->querySql($q4);

    echo '<script>window.location = "index.php"</script>';

}
?>