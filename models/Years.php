<?php
if ($_SERVER['DOCUMENT_ROOT'] . '/Database.php')
{
    include_once $_SERVER['DOCUMENT_ROOT'] . '/Database.php';
} else {
    include_once '../Database.php';
}
/**
 * PHP version 5.6
 *
 * Model class for make_years database table.
 *
 * @category year
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */
class Years
{
    /**
     * Class variables
     *
     * Initialized with data types. Ensures no other data types may be used.
     */
    private $id = 0;
    private $year = 0;
    private $created_at;
    private $updated_at;

    /**
     * Class constructor.
     */
    public function _construct()
    {
        $this->id = null;
        $this->year = null;
        $this->created_at = null;
        $this->updated_at = null;
    }

    /*** GETTERS ***/
    /**
     * INT OUT for $id
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * INT OUT for $year
     */
    public function getYear()
    {
        return $this->year;
    }

    /**
     * TIMESTAMP OUT for $created_at
     */
    public function getCreatedAt()
    {
        return $this->created_at;
    }

    /**
     * TIMESTAMP OUT for $updated_at
     */
    public function getUpdatedAt()
    {
        return $this->updated_at;
    }

    /*** SETTERS ***/

    /**
     * INT IN for $id
     */
    public function setId($id)
    {
        if (is_integer($id)) {
            $this->id = (integer) $id;
        }
    }

    /**
     * STRING IN for $year
     */
    public function setYear($year)
    {
        if (is_integer($year)) {
            $this->year = (integer) $year;
        }
    }

    /**
     * Initialize new record data
     */
    public function initWith($id, $year, $created_at, $updated_at)
    {
        $this->id = $id;
        $this->year = $year;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    /**
     * Initialize with existing record data
     */
    public function initWithId($id)
    {
        $db = Database::getInstance();
        $data = $db->singleFetch('SELECT * FROM make_years WHERE id = ' . $id);
        $this->initWith($data->id, $data->year, $data->created_at,
            $data->updated_at);
    }

    /**
     * Retrieve all make years with available associated cars from db.
     */
    function listAll()
    {
        $db = Database::getInstance();
        $sql = "SELECT make_years.id, make_years.year\n"
            . " FROM make_years, cars\n"
            . " WHERE make_years.id = cars.make_year_id\n"
            . " GROUP BY make_years.id";
        $data = $db->multiFetch($sql);
        return $data;
    }

}