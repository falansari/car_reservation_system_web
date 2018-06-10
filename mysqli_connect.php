<?php

class Database1
{

    public $dbc = NULL;
    
    public function getDBConnection() {

        if ($this->dbc == NULL)
            $this->dbc = mysqli_connect('10.31.40.60','20900029','20900029', '20900029');
            //$this->dbc = mysqli_connect('localhost','root','', 'car_reservation_system');

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
?>
