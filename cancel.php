<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        include_once 'Header.php';

        if (isset($_POST['submitted'])) {
            include 'Database.php';

            if (isset($_POST['reservation'])) {
                $code = trim($_POST['reservation']);
            }

            function findReservation($code) {
                $db = new Database();
                $q = "SELECT id FROM reservations WHERE id = $code";

                $data = $db->singleFetch($q);
                if ($data != null) {
                    return $data->id;
                } else {
                    Echo "Reservation Code: $code does not exist";
                }
                return $data;
            }
            
            $foundReservation = findReservation($code);
            
            if ($foundReservation != NULL)
            {
                include_once 'models/Reservations.php';
                $reservations = new Reservations();
                $reservations->delete($code);
                echo "<script type='text/javascript'>location.href = 'index.php?deleted=true';</script>";
            }
            ?>

    <?php
}
?>
    <center>
        <div id="reg">
            <h1>Cancel Reservation</h1>
            <form action="cancel.php" method="post">
                <table>
                    <tr><td><h4>Reservation Code: </h4><td> <input type="text" name="reservation" size="20" value="" />

                </table>
                <div align="center">
                    <input type ="submit" class ="Button SubButton" value ="cancel" />
                </div>
                <input type="hidden" name="submitted" value="1" />
            </form>
        </div>
    </center>
</body>
</html>