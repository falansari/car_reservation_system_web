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
        
        include_once  'Dropdownfunctions.php';
        $drop = new Dropdownfunctions();
        if (isset($_GET['id'])) {
            $id = $_GET['id'];
        } elseif (isset($_POST['id'])) {
            $id = $_POST['id'];
        }

        include_once 'AdminHeader.php';
        include_once 'Database.php';

        $db = new Database();
        $q = 'SELECT daily_rental_price FROM cars WHERE id = ' . $id;

        $data = $db->singleFetch($q);


        ////////////////

        $q2 = "SELECT c.id,cat.id as catid,cat.category,m.id as manid,m.manufacturer,mo.id as moid, mo.model,y.id as yearid,y.year,c.daily_rental_price
from cars c
JOIN car_categories cat on cat.id = c.category_id
join make_years y on y.id = c.make_year_id
join manufacturers m on m.id = c.manufacturer_id
join models mo on mo.id = c.model_id
where c.id = $id
   
";

        $data2 = $db->singleFetch($q2);


        ////////////
        ?>
        

    <center>
        <div id="edit">
            <form action="EditCars.php" method="post">
                Select Category : <select name="Category" >
<?php
echo '<option value="' . $data2->catid . '" selected ="' . $data2->category . '" >' . $data2->category . '</option>';
$drop->category();
?>
                </select>
                <br> <br> <br>
                Select manufacturer :  <select name="manufacturer">
                    <?php
                    echo '<option value="' . $data2->manid . '" selected ="' . $data2->manufacturer . '" >' . $data2->manufacturer . '</option>';
                    $drop->manufacture()
                    ?>
                </select>
                <br> <br> <br>
                Select model : <select name="model">
                    <?php
                    echo '<option value="' . $data2->moid . '" selected ="' . $data2->model . '" >' . $data2->model . '</option>';
                    $drop->model()
                    ?>
                </select>
                <br> <br> <br>
                Select year :  <select name="year">
                    <?php
                    echo '<option value="' . $data2->yearid . '" selected ="' . $data2->year . '" >' . $data2->year . '</option>';
                    $drop->year()
                    ?>
                </select>
                <br> <br> <br>
                Daily rental price :
                <input  name="price" type="text" value="<?php echo $data->daily_rental_price ?>" >
                <br> <br> <br>
               
                <div align="center">

                    <input type ="submit" class ="Button SubButton" value ="Change" />

                </div>  
                <input type="hidden" name="submitted" value="<?php echo $id ?>" />

            </form>
        </div>
    </center>


</body>
</html>
<?php
if (isset($_POST['submitted'])) {

$idd = $_POST['submitted'];
    $cat = $_POST['Category'];
    $man = $_POST['manufacturer'];
    $mod = $_POST['model'];
    $year = $_POST['year'];
    $price = $_POST['price'];
    

    $q3 = "Update cars set manufacturer_id = $man, category_id = $cat, model_id = $mod, make_year_id = $year, daily_rental_price = $price where id = $idd";
    $data3 = $db->querySQL($q3);
     
    
            echo '<script>window.location = "AdminCars.php"</script>';
        
      

}
?>