<?php
/**
 * PHP version 5.6
 *
 * Script for connecting PHP app to MySQL database.
 * Documented by Fatima A. Alansari <fatima.a.alansari@outlook.com>
 *
 * @category Connector
 * @package  Database
 * @author   Bahrain Polytechnic <polytechnic.staff@polytechnic.bh>
 * @link     https://github.com/falansari/car_reservation_system_web/tree/issue37
 */

/**
 * PHP version 5.6
 *
 * MySQL Database connection class.
 * Documented by Fatima A. Alansari <fatima.a.alansari@outlook.com>
 *
 * @category Connector
 * @author   Bahrain Polytechnic <polytechnic.staff@polytechnic.bh>
 */
class Database
{
    public static $instance = null;
    public $dblink = null;

    /**
     * Create new database instance.
     *
     * @return void
     */
    public static function getInstance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new Database();
        }
        return self::$instance;
    }

    /**
     * Database connection constructor.
     *
     * @return void
     */
    public function __construct()
    {
        if (is_null($this->dblink)) {
            $this->connect();
        }
    }

    /**
     * MySQL database connection string.
     *
     * mysqli_connect(server_ip, db_username, db_user_password, db_name)
     *
     * @return void
     */
    public function connect()
    {
        $this->dblink = mysqli_connect(
            'localhost', 'root', '', 'car_reservation_system'
        )
        or die('CAN NOT CONNECT');
    }

    /**
     * Destroy database instance.
     *
     * @return void
     */
    public function __destruct()
    {
        if (!is_null($this->dblink)) {
            $this->close($this->dblink);
        }
    }

    /**
     * Close database connection.
     *
     * @return void
     */
    public function close()
    {
        mysqli_close($this->dblink);
    }

    /**
     * Send PHP query to database.
     *
     * @param SQL $sql query
     *
     * @return void
     */
    public function querySQL($sql)
    {
        if ($sql != null || $sql != '') {
            mysqli_query($this->dblink, $sql);
        }
    }

    /**
     * Fetch a single database object/row based on query.
     *
     * @param SQL $sql query
     *
     * @return Object
     */
    public function singleFetch($sql)
    {
        //echo $sql = $this->mkSafe($sql);
        $fet = null;
        if ($sql != null || $sql != '') {
            $res = mysqli_query($this->dblink, $sql);
            $fet = mysqli_fetch_object($res);
        }
        return $fet;
    }

    /**
     * Fetch multiple database objects/rows based on query.
     *
     * @param SQL $sql query
     *
     * @return Data
     */
    public function multiFetch($sql)
    {
        //$sql = $this->mkSafe($sql);
        $result = [];
        $counter = 0;
        if ($sql != null || $sql != '') {
            if ($res = mysqli_query($this->dblink, $sql)) {
                while ($obj = mysqli_fetch_object($res)) {
                    $result[$counter] = $obj;
                    $counter++;
                }
            } else {
                var_dump(mysqli_error($this->dblink));
            }
            return $result;
        }
        $this->dblink->close();
    }

    /**
     * Strip HTML & PHP tags from a string. Use before sending
     * query to database.
     *
     * @param string $string user input
     *
     * @return String
     */
    public function mkSafe($string)
    {
        $string = strip_tags($string);
        if (!get_magic_quotes_gpc()) {
            $string = addslashes($string);
        } else {
            $string = stripslashes($string);
        }
        $string = str_ireplace("script", "blocked", $string);

        $string = trim($string);
        $string = mysqli_escape_string($this->dblink, $string);

        return $string;
    }

    /**
     * Return table rows based on query.
     *
     * @param SQL $sql query
     *
     * @return Data rows
     */
    public function getRows($sql)
    {
        $rows = 0;
        if ($sql != null || $sql != '') {
            $result = mysqli_query($this->dblink, $sql);
            $rows = mysqli_num_rows($result);
        }
        return $rows;
    }

}
