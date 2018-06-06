<?php
include_once 'AdminHeader.php';
        
?>



<center>
        <div id="reg">
    
            <form action="AddModel.php" method="post">
    <table>
            
        <tr><td><h4>Model :</h4><td> <input type="text" name="model" size="20" value="" /> 
    
                 
               
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
    
    
    $model= $_POST['model'];
    include 'Database.php';
     $db = new Database();
 
      $q = "Insert into models(model) value ('$model')";
    $data= $db->querySQL($q);
    
      echo '<script>window.location = "carModel.php"</script>';
    
           
}
   
    

?>