<?php
include_once $_SERVER['DOCUMENT_ROOT'] . '/Database.php';

/**
 * PHP version 5.6
 *
 * Model class for accessories database table.
 *
 * @category Model
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/19
 */
class Accesssories
{

    /**
     * Class variables
     *
     * Initialized with data types. Ensures no other types may be used.
     */
    private $id = 0;
    private $accessory = 'Unknown Accessory';
    private $daily_rental_price = 0.0;
    private $available_qty = 0;
    private $reserved_qty = 0;
    private $total_qty = 0;
    private $created_at;
    private $updated_at;

    /**
     * Class constructor.
     */
    public function _construct()
    {
        $this->id = null;
        $this->accessory = null;
        $this->daily_rental_price = null;
        $this->available_qty = null;
        $this->reserved_qty = null;
        $this->total_qty = null;
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
     * STRING OUT for $accessory
     */
    public function getAccessory()
    {
        return $this->accessory;
    }

    /**
     * FLOAT OUT for $daily_rental_price
     */
    public function getDailyRentalPrice()
    {
        return $this->daily_rental_price;
    }

    /**
     * INT OUT for $available_qty
     */
    public function getAvailableQty()
    {
        return $this->available_qty;
    }

    /**
     * INT OUT for $reserved_qty
     */
    public function getReservedQty()
    {
        return $this->reserved_qty;
    }

    /**
     * INT OUT for $total_qty
     */
    public function getTotalQty()
    {
        return $this->total_qty;
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
     * STRING IN for $accessory
     */
    public function setAccessory($accessory)
    {
        if (is_string($accessory)) {
            $this->accessory = (string) $accessory;
        }
    }

    /**
     * FLOAT IN for $daily_rental_price
     */
    public function setDailyRentalPrice($daily_rental_price)
    {
        if (is_numeric($daily_rental_price)) {
            $this->daily_rental_price = (float) $daily_rental_price;
        }
    }

    /**
     * INT IN for $available_qty
     */
    public function setAvailableQty($available_qty)
    {
        if (is_integer($available_qty)) {
            $this->available_qty = (integer) $available_qty;
        }
    }

    /**
     * INT IN for $reserved_qty
     */
    public function setReservedQty($reserved_qty)
    {
        if (is_integer($reserved_qty)) {
            $this->reserved_qty = (integer) $reserved_qty;
        }
    }

    /**
     * INT IN for $total_qty
     */
    public function setTotalQty($total_qty)
    {
        if (is_integer($total_qty)) {
            $this->total_qty = (integer) $total_qty;
        }
    }

    /**
     * Initialize new record data
     */
    public function initWith($id, $accessory, $daily_rental_price,
        $available_qty, $reserved_qty, $total_qty,
        $created_at, $updated_at) {
        $this->id = $id;
        $this->accessory = $accessory;
        $this->daily_rental_price = $daily_rental_price;
        $this->available_qty = $available_qty;
        $this->reserved_qty = $reserved_qty;
        $this->total_qty = $total_qty;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    /**
     * Initialize with existing record data
     */
    public function initWithId($id)
    {
        $db = Database::getInstance();
        $data = $db->singleFetch('SELECT * FROM accessories WHERE id = ' . $id);
        $this->initWith($data->id, $data->accessory, $data->daily_rental_price,
            $data->available_qty, $data->reserved_qty, $data->total_qty,
            $data->created_at, $data->updated_at);
    }

    /**
     * Retrieve all accessories from database
     */
    public function listAll()
    {
        $db = Database::getInstance();
        $data = $db->multiFetch('SELECT * FROM accessories');
        return $data;
    }

    /**
     * Retrieve selected accessories info from database
     * @param   ARRAY   $accessories    Required. Array of int accessory ids.
     */
    public function accessories($accessories)
    {
        $db = Database::getInstance();
        $sql = 'SELECT id, accessory, daily_rental_price
            FROM accessories
            WHERE id = ' . $accessories[0];

        if (count($accessories) >= 1) {
            for ($i = 1; $i < count($accessories); $i++) {
                $sql .= ' OR id = ' . $accessories[$i];
            }
        }

        $sql .= ' GROUP BY id';
        $data = $db->multiFetch($sql);
        return $data;
    }

    /**
     * Retrieve total rental days & cost from db
     * @param   ARRAY   $id             Required. Rental accessories id array.
     * @param   DATE    $startDate      Required. Rental start date.
     * @param   DATE    $endDate        Required. Rental end date.
     */
    public function totalRental($id, $startDate, $endDate)
    {
        $db = Database::getInstance();
        $sql = "SELECT SUM(accessories.daily_rental_price * (DATEDIFF('$endDate', '$startDate')+1)) 'total_cost'
            FROM accessories
            WHERE accessories.id = " . $id[0] . "";

        if (count($id) > 1)
        {
            for ($i = 1; $i < count($id); $i++)
            {
                $sql .= ' OR accessories.id = '.$id[$i];
            }
        }
        $sql .= " GROUP BY 'total_cost'";
        $data = $db->singleFetch($sql);
        return $data;
    }

}
