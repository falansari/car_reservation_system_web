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
        $q = 'SELECT model FROM models WHERE id = ' . $id;
       

        $data = $db->singleFetch($q);


        ?>
        

    <center>
        <div id="edit">
            <form action="EditModel.php" method="post">
                

                Car Category :
                <input  name="model" type="text" value="<?php echo $data->model ?>" >
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
    $model = $_POST['model'];
    

    $q3 = "Update models set model = '$model'  where id = $idd";
    $data3 = $db->querySQL($q3);
    
     echo '<script>window.location = "carModel.php"</script>';
        
      
}
?>