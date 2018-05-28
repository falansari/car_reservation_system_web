<?php
//include 'header.php';

class Database1
{

    public $dbc = NULL;
    
    public function getDBConnection() {

        if ($this->dbc == NULL)
            $this->dbc = mysqli_connect('localhost','root','', 'car_reservation_system');

        if (mysqli_connect_errno()) {
            printf("Connect failed: %s\n", mysqli_connect_error());
            die('b0ther');
        }

        return $this->dbc;
    }
    
    public function getConnection()
    {
        return $this->getDBConnection();
    }
    
    function __destruct() {
      //print "Destroying the connection<br>";
      $this->closeDB();
    }
    
     public function closeDB()
    {
         mysqli_close($this->dbc);  
    }

     
 }

/* this file should be stored outside of the web directory for security purposes - this will
 * prevent a web browser from being able to see it
 */

//print_r($dbc);

/*$mySQL = 'SELECT * from test.Users;';
$res = mysqli_query($mySQL, $dbc);

if($res == FALSE)
    echo "Query Failed";

mysqli_close($dbc) or die('close db failed');
  
 */
?>
