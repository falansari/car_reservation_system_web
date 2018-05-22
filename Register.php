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
    
     <tr><td><h4>Last Name : </h4><td><input type="text" name="lastName" size="20" value="" />
     
     <tr><td><h4>CPR Number : </h4><td><input type="text" name="password" size="10" value="" />
            
                
    <tr><td><h4>Email : </h4><td><input type="email" name="email" size="50" value="" />
      
    <tr><td><h4>Password : </h4><td><input type="password" name="password" size="10" value="" />
            
    <tr><td><h4>Confirm Password : </h4><td><input type="password" name="password" size="10" value="" />
               
                
    
    <tr><td><h4>Card Number :</h4> <td><input type="text" name="CardNum" size="50" value="" />
    
    <tr><td><h4>Card Name :</h4><td> <input type="text" name="CardName" size="50" value="" />
    
    <tr><td> <h4>Expiry Date : </h4><td> <input type="month" name="Exdate" size="50" value="" /></td></tr>
        </table>        
               
            <div align="center">
                
                  <input type ="submit" class ="Button SubButton" value ="Register" />
            </div>  
            <input type="hidden" name="submitted" value="1" />
     
</form>    

</div>
        </center>
<?php

    
   
    

?>