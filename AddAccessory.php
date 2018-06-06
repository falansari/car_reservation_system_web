<?php

include_once 'AdminHeader.php';
        
?>



<center>
        <div id="reg">
    
            <form action="AddAccessory.php" method="post">
    <table>
            
        <tr><td><h4>Accessory :</h4><td> <input type="text" name="Accessory" size="20" value="" /> 
    
                 
               
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
    
    
    $Accessory= $_POST['Accessory'];
    include 'Database.php';
     $db = new Database();
 
      $q = "Insert into accessories(accessory) value ('$Accessory')";
    $data= $db->querySQL($q);
    
      echo '<script>window.location = "carAccessories.php"</script>';
    
           
}
   
    

?>