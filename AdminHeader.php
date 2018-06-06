<?php


session_start();


if($_SESSION["role"] != 1)
    header("Location: LoginPage.php");
print_r($_SESSION["role"]);

?>
</head>
<link rel="stylesheet" type="text/css" href="css/cars.css">

<body>
    <div class="layer">
    
    <ul >
        <li><a  href="AdminHome.php"> Dashboard</a></li>
        
  
  <li style="float:right"><a href="#"> Logout</a></li>
  
</ul>
</div>
</body>
</html>
