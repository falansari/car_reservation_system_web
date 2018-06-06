<?php

include_once 'AdminHeader.php';
        
?>



<center>
        <div id="reg">
    
            <form action="AddCategory.php" method="post">
    <table>
            
        <tr><td><h4>Category :</h4><td> <input type="text" name="category" size="20" value="" /> 
    
                 
               
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
    
    
    $category = $_POST['category'];
    include 'Database.php';
     $db = new Database();
 
      $q = "Insert into car_categories(category) value ('$category')";
    $data= $db->querySQL($q);
    
      echo '<script>window.location = "CarCategories.php"</script>';
    
           
}
   
    

?>