<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        
         <link rel="stylesheet" type="text/css" href="Stylesheet.css">

        	
       
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        include_once 'Header.php';
        ?>
     
    <center>
        <div id="log">
            
            
                <center><h1>Please Enter Your Login Details </h1></center> 
        <form action="LoginPage.php" method="post" id="content">
        <fieldset>    
            <h3>CPR/Email : <input type="text" name="UserName" value="" />
            <h3>Password : <input type="password" name="Password" value=""/>
        <br><br>
        <input  type="submit" class ="button SubButton" name="submit" value="Login" /> 
            

        
        
         <input type ="hidden" name="submitted" value="1">
                 </fieldset>    

</form>
        </div>
        </center>
</body>
</html>


<?php


if (isset($_POST['submitted'])) {
    //require_once is similar to 'include' but ensures the code is not copied multiple times
    require_once('LoginFunctions.php');

    //list() is a way of assigning multiple values at the same time
    //checkLogin() function returns an array so list here assigns the values in the array to $check and $data 
     $usern = $_POST['UserName'];
   $pass = $_POST['Password'];
       
    

    
   list($check, $data) = checkLogin($usern, $pass);
   if ($check) {
        
        $_SESSION['UserName'] =$usern;
        $_SESSION['Id'] = $data['user_id'];
     
       
            
        }else {
        $errors = $data;
    }
}

//create a sopace between the button and the error messages
echo'<div class="spacer"></div>';

if (!empty($errors)) {
    echo '<br/> <p class="error">The following errors occurred: <br />';

    //foreach is a simplified version of the 'for' loop
    foreach ($errors as $err) {
        echo "$err <br />";
    }

    echo '</p>';
}
    
    
