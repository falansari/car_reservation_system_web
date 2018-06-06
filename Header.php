<?php


session_start();
if (!isset($_SESSION["role"]))
   $_SESSION["role"] = 0;

 
print_r($_SESSION["role"]);
?>
</head>
<link rel="stylesheet" type="text/css" href="css/cars.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">

<body>
    <div class="layer">
    
    <ul >
        <li><a  href="index.php"><i class="fa fa-home"> Home</i></a></li>
        <li><a href="About.php"> About Us</a></li>
        <li><a href="AdminHome.php">Contact Us</a></li>
  <li style="float:right"><a href="LoginPage.php"><span class="fas fa-sign-in-alt"> Login</span></a></li>
  <li style="float:right"><a href="Register.php"><i class="fas fa-user-plus"> Register</i></a></li>
  
</ul>
</div>
</body>
</html>
