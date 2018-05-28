<?php
include_once 'mysqli_connect.php';
//include_once 'debugging.php';

function absolute_url($page = 'index.php')
{
    //header('Location: http:\\localhost');
    //exit(); //terminates the script
    
    $url = 'http://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['PHP_SELF']);
    $url = rtrim($url, '/\\');
    $url .= '/' . $page;
    
    return $url;
}

function checkLogin($email, $password) 
{
  $errors = array();
    
  if(empty($email))
    $errors[] = 'You must enter email';
 
  if(empty($password))
    $errors[] = 'You must enter a password';
 
  if(empty($errors))
  {
      require_once 'mysqli_connect.php';
////set up database econnection
     
         
      $db = new Database1();
      $dbc = $db->getConnection();

      $q = "SELECT * FROM users where email = '$email' and password= '$password'";

      $r = mysqli_query($dbc, $q);
                
      if($r)
      {
          
          
          if(mysqli_affected_rows($dbc) != 0)
          {
            $row = mysqli_fetch_array($r, MYSQLI_ASSOC);
            return array(true, $row);
          }
          else
          {
            $errors[] = 'Passwords do not match';
          }
      }
      else{
        echo '<p class="error"> Oh dear. There was a databse error</p>';
        echo '<p class = "error">' . mysqli_error($dbc) .'</p>';
      }

  }
  
  return array(false, $errors);
      
}


?>
