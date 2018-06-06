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
       
        if (isset($_GET['id'])) {
            $id = $_GET['id'];
        } elseif (isset($_POST['id'])) {
            $id = $_POST['id'];
        }

        include_once 'AdminHeader.php';
        include_once 'Database.php';

        $db = new Database();
        $q = 'SELECT accessory FROM accessories WHERE id = ' . $id;
       

        $data = $db->singleFetch($q);


        ?>
        

    <center>
        <div id="edit">
            <form action="EditAccessory.php" method="post">
                

                Car Category :
                <input  name="Accessory" type="text" value="<?php echo $data->accessory ?>" >
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
    $Accessory = $_POST['Accessory'];
    

    $q3 = "Update models set accessories = '$Accessory '  where id = $idd";
    $data3 = $db->querySQL($q3);
    
     echo '<script>window.location = "carAccessories.php"</script>';
        
      
}
?>