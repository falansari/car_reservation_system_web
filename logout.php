<?php

$page_title = 'Logout';

include 'Header.php';



if (!isset($_SESSION['role']) ) //if no session exists go to the index page
{
     require_once('LoginFunctions.php');
     $url = absolute_url();
     header("Location: $url");
     exit();
}
else{ //cancel the session
   $_SESSION = array(); //clear the session variables
   $_SESSION["role"] =0;
   session_destroy(); //removes session data from server
   
   setcookie('PHPSESSID','', time()-3600,'/','',0,0); //destroy cookie
}
 echo '<script>window.location = "index.php"</script>';
    

?>
