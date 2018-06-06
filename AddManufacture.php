<?php
include_once 'AdminHeader.php';
        
?>



<center>
        <div id="reg">
    
            <form action="AddManufacture.php" method="post">
    <table>
            
        <tr><td><h4>Manufacture :</h4><td> <input type="text" name="Manufacture" size="20" value="" /> 
    
                 
               
            <div align="center">
                
                  <input type ="submit" class ="Button SubButton" value ="Add" />
            </div>  
            <input type="hidden" name="submitted" value="1" />
     
</form>    

</div>
        </center>
<?php


    if( isset($_POST['submitted']) )
{
    
    
    $Manufacture = $_POST['Manufacture'];
    include 'Database.php';
     $db = new Database();
 
      $q = "Insert into manufacturers(manufacturer) value ('$manufacturer')";
    $data= $db->querySQL($q);
    
      echo '<script>window.location = "CarManufacture.php"</script>';
    
           
}
   
    

?>