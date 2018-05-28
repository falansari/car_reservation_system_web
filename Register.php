<?php

include_once 'Header.php';
//include 'debugging.php';

?>



<center>
        <div id="reg">
    
<h1>Register as a New user</h1>
<form action="Register.php" method="post">
    <table>
            
        <tr><td><h4>First Name :</h4><td> <input type="text" name="firstName" size="20" value="" /> 
    
                 <tr><td><h4>middle Name : </h4><td><input type="text" name="middleName" size="20" value="" />
     <tr><td><h4>Last Name : </h4><td><input type="text" name="lastName" size="20" value="" />
     
   
                
    <tr><td><h4>Email : </h4><td><input type="email" name="email" size="50" value="" />
      
    <tr><td><h4>Password : </h4><td><input type="password" name="password" size="10" value="" />
            
   
               
                
        </table>        
               
            <div align="center">
                
                  <input type ="submit" class ="Button SubButton" value ="Register" />
            </div>  
            <input type="hidden" name="submitted" value="1" />
     
</form>    

</div>
        </center>
<?php

    if( isset($_POST['submitted']) )
{
    include_once 'Users.php';       
         
    $user = new Users();
    
    
    $user->setFirstname($_POST['firstName']);
    $user->setMiddlename($_POST['middleName']);
    $user->setLastname($_POST['lastName']);
    $user->setEmail($_POST['email']);
    $user->setPassword($_POST['password']);
            
    
    
   if ($user->initWithemail()) {

        if ($user->registerUser())
            echo 'Registerd Successfully';
        else
            echo '<p class="error"> Not Successfull </p>';
    }else {
        echo '<p class="error"> Username Already Exists </p>';
    }
}
   
    

?>