<?php
include_once $_SERVER['DOCUMENT_ROOT'] . '/Database.php';

/**
 * PHP version 5.6
 *
 * Model class for manufacturers database table.
 *
 * @category Model
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */
class Manufacturers
{

    /**
     * Class variables
     *
     * Initialized with data types. Ensures no other types may be used.
     */
    private $id = 0;
    private $manufacturer = 'Unknown Manufacturer';
    private $created_at;
    private $updated_at;

    /**
     * Class constructor.
     */
    public function _construct()
    {
        $this->id = null;
        $this->manufacturer = null;
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
     * STRING OUT for $manufacturer
     */
    public function getManufacturer()
    {
        return $this->manufacturer;
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
     * STRING IN for $manufacturer
     */
    public function setManufacturer($manufacturer)
    {
        if (is_string($manufacturer)) {
            $this->manufacturer = (string) $manufacturer;
        }
    }

    /**
     * Initialize new record data
     */
    public function initWith($id, $manufacturer, $created_at, $updated_at)
    {
        $this->id = $id;
        $this->manufacturer = $manufacturer;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    /**
     * Initialize with existing record data
     */
    public function initWithId($id)
    {
        $db = Database::getInstance();
        $data = $db->singleFetch('SELECT * FROM manufacturers WHERE id = ' . $id);
        $this->initWith($data->id, $data->manufacturer, $data->created_at,
            $data->updated_at);
    }

    /**
     * Retrieve all manufacturers from database where an associated car exists.
     */
    public function listAll()
    {
        $db = Database::getInstance();
        $sql = 'SELECT manufacturers.id, manufacturers.manufacturer
            FROM manufacturers, cars
            WHERE manufacturers.id = cars.manufacturer_id
            GROUP BY manufacturers.id';
        $data = $db->multiFetch($sql);
        return $data;
    }

    /**
     * Add new manufacturer to database
     */
    public function createManufacturer()
    {
        try {
            $db = Database::getInstance();
            $data = $db->querySql("INSERT INTO `manufacturers` (`id`, `manufacturer`)
                VALUES (NULL, '\'$this->manufacturer\'')");
            return true;
        } catch (Exception $exception) {
            echo 'Exception: ' . $exception;
            return false;
        }
    }

}
