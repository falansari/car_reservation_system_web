<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>

<?php
include_once 'Header.php';
?>

        <div id="sidebar">


                <center><h1>Book Your Car Today!</h1></center>
<form action="index.php" method="post">



    <h4>Car manufacturer :</h4><select class="styled-select slate">
  <option value="1">Select One:</option>
  <option value="volvo">Any</option>
  <option value="saab">SUV</option>
  <option value="opel">Truck</option>
  <option value="audi">Hybrid</option>
</select>

    <h4>Car Category :</h4><select class="styled-select slate">
  <option value="1">Select One:</option>
  <option value="volvo">Volvo</option>
  <option value="saab">Saab</option>
  <option value="opel">Opel</option>
  <option value="audi">Audi</option>
</select>

    <center><input type ="submit" class ="button SubButton" value ="Search" />

            <input type="hidden" name="submitted" value="1" />

     </center>
</form>
          </div>

    </body>
</html>
