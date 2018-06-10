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
        include 'Database.php';
        
        
       ?>
        <br><br>
<br>        <form action="MonthlyRevenue.php" method="post">

        <div align="center">
                
                  <input type ="submit" class ="Button SubButton" value ="View Revenue For Month of <?php echo date('M');?>" 
       />
            </div >  
            <input type="hidden" name="submitted" value="1" />
        </form>
            <?php
            

    if( isset($_POST['submitted']) )
{
        $month = date('m');
        $mon = date('M');
       
       
        $q= "SELECT transaction_amount,transaction_date FROM sales_revenue_report WHERE MONTH(transaction_date) = $month" ;
        
        $db = new Database();
        $data = $db->multiFetch($q);

        if (!empty($data)) {
            $row_cnt = count($data);
        /////////////////////////////////////////////////////    
                   require_once 'mysqli_connect.php';
////set up database econnection
     
         
      $db = new Database1();
      $dbc = $db->getConnection();
        
        
      $qq = "Select SUM(transaction_amount) FROM sales_revenue_report WHERE MONTH(transaction_date) = $month";
      

      $rr = mysqli_query($dbc, $qq);
            if($row = mysqli_fetch_array($rr))
                {
                    $sum = $row[0];
                }
            
                echo "<h2>Total Revenue BHD $sum for the month of $mon</h2>";
/////////////////////////////////////////
            if ($row_cnt == 0) {
                echo '<br>';
                echo '<p>sorry no data found</p>';
            } else {
                echo '<br>';
                //display a table of results
                $table = '<table class="CSSTableGenerator" width="95%">' .
                        '<tr bgcolor="#f2f2f2">
                            <td><h4>date</h4></td>
                     <td><h4>amount</h4></td>
                     
              
                     ';

                $bg = '#f2f2f2';

                for ($i = 0; $i < $row_cnt; $i++) {
                    $bg = ($bg == '#f2f2f2' ? '#f2f2f2' : '#f2f2f2');

                    $table .= '<tr bgcolor="' . $bg . '">
                         <td>' . $data[$i]->transaction_date . '</td>
                          <td>' . $data[$i]->transaction_amount. '</td>
                    
                         ';

                }
                $table .= '</table>';
                

                echo $table;
                
          
            
            }
        }
        else {
            echo '<p class="error"> Oh dear. There was an error</p>';
        }
        
}
?>













<br><br><br><br>
        <div align="center">       
    <form action="MonthlyRevenue.php" method="post">
        <input type="date" name="From" value="<?php echo date("Y-m-d");?>">  <input type="date" name="TO" value="<?php echo date("Y-m-d");?>">
      <input type="submit" value="Send">
      <input type="hidden" name="submitted1" value="1" />
        </form>
        </div>
      <?php
       if( isset($_POST['submitted1']) )
{
           $fromdate = $_POST['From'];
           $todate = $_POST['TO'];
        
           
           $q= "SELECT transaction_amount,transaction_date FROM sales_revenue_report WHERE transaction_date between '$fromdate' and '$todate'" ;
       
        $db = new Database();
        $data = $db->multiFetch($q);

        if (!empty($data)) {
            $row_cnt = count($data);
        /////////////////////////////////////////////////////    
                   require_once 'mysqli_connect.php';
////set up database econnection
     
         
      $db = new Database1();
      $dbc = $db->getConnection();
        
        
      $qq = "Select SUM(transaction_amount) FROM sales_revenue_report WHERE transaction_date between '$fromdate' and '$todate'";
      

      $rr = mysqli_query($dbc, $qq);
            if($row = mysqli_fetch_array($rr))
                {
                    $sum = $row[0];
                }
            
                echo "<h2>Total Revenue BHD $sum </h2>";
/////////////////////////////////////////
            if ($row_cnt == 0) {
                echo '<br>';
                echo '<p>sorry no data found</p>';
            } else {
                echo '<br>';
                //display a table of results
                $table = '<table class="CSSTableGenerator" width="95%">' .
                        '<tr bgcolor="#f2f2f2">
                            <td><h4>date</h4></td>
                     <td><h4>amount</h4></td>
                     
              
                     ';

                $bg = '#f2f2f2';

                for ($i = 0; $i < $row_cnt; $i++) {
                    $bg = ($bg == '#f2f2f2' ? '#f2f2f2' : '#f2f2f2');

                    $table .= '<tr bgcolor="' . $bg . '">
                         <td>' . $data[$i]->transaction_date . '</td>
                          <td>' . $data[$i]->transaction_amount. '</td>
                    
                         ';

                }
                $table .= '</table>';
                

                echo $table;
                
          
            
            }
        }
        else {
            echo '<p class="error"> Oh dear. There was an error</p>';
        }
           
       }
        ?>         
        
    </body>
</html>
