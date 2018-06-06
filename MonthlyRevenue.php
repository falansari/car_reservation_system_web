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
        include_once 'AdminHeader.php';
        
        
       ?>
        <form action="MonthlyRevenue.php" method="post">

        <div align="center">
                
                  <input type ="submit" class ="Button SubButton" value ="View Revenue For Month of <?php echo date('M');?>" 
       />
            </div>  
            <input type="hidden" name="submitted" value="1" />
        </form>
            <?php
            

    if( isset($_POST['submitted']) )
{
       
        echo " this month $month";
        
        
       // $q= "SELECT SUM(transaction_amount) FROM sales_revenue_report WHERE MONTH(transaction_date) = $month" ;
        //continue the code for output
        
}
?>
            
    <form action="MonthlyRevenue.php" method="post">
        <input type="date" name="From" value="<?php echo date("Y-m-d");?>">  <input type="date" name="TO" value="<?php echo date("Y-m-d");?>">
      <input type="submit" value="Send">
      <input type="hidden" name="submitted1" value="1" />
        </form>
      <?php
       if( isset($_POST['submitted1']) )
{
           $fromdate = $_POST['From'];
           $todate = $_POST['TO'];
           echo"$fromdate ---- $todate";
           
       }
        ?>         
        
    </body>
</html>
