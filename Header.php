<?php
session_start();
if (!isset($_SESSION["role"]))
   $_SESSION["role"] = 0;
$role = $_SESSION["role"];
 
?>
</head>
<link rel="stylesheet" type="text/css" href="css/cars.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">

<body>
    <div class="layer">
    <?php
    
    if ($role != 0){
    echo'  <ul >
        <li><a  href="index.php"><i class="fa fa-home"> Home</i></a></li>
        <li><a href="About.php"> About Us</a></li>
        <li><a href="contactUs.php">Contact Us</a></li>
        
        <li style="float:right"><a href="AdminHome.php"><span class="fas fa-sign-in-alt"> Admin Dashboard</span></a></li>
       <li style="float:right"><a href="logout.php"><span class="fas fa-sign-in-alt"> Logout</span></a></li>
       
        
  
  
</ul>'  ;
        
        
    }
 
  
    else{
        
       
       echo'  <ul >
        <li><a  href="index.php"><i class="fa fa-home"> Home</i></a></li>
        <li><a href="About.php"> About Us</a></li>
        <li><a href="contactUs.php">Contact Us</a></li>
        <li><a href="searchReservation.php">Search Reservation</a></li>
        
       <li style="float:right"><a href="LoginPage.php"><span class="fas fa-sign-in-alt"> Login</span></a></li>
        
  
  <li style="float:right"><a href="Register.php"><i class="fas fa-user-plus"> Register</i></a></li>
  
</ul>'  ;
    
    }
    
    ?>
        
</div>
</body>
</html>
