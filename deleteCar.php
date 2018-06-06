<?php

include_once 'AdminHeader.php';

$id =0;
if( isset($_GET['id']) )
{
    $id=$_GET['id'];  
}
elseif(isset($_POST['id']))
{
    $id=$_POST['id'];    
}

echo "<h1>Are you sure you want to delete this car </h1>";

echo '<form method="post">
                    <input type="submit" class ="Button SubButton" value ="Yes" /> 
                    <input type="hidden" name="submitted" value="1" />
                </form><br>';
            
 echo '<form method="post">
                    <input type="submit" class ="Button SubButton" value ="No" /> 
                    <input type="hidden" name="submitted2" value="1" />
                </form>';

if( isset($_POST['submitted']) )
{
    include 'Database.php';
     $db = new Database();
 
      $q = "Delete from cars where id =$id ";
    $data= $db->querySQL($q);
    
      echo '<script>window.location = "AdminCars.php"</script>';
  }

if( isset($_POST['submitted2']) )
{
   echo '<script>window.location = "AdminCars.php"</script>'; 
}
