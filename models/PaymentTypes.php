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
 * Model class for payment_types database table.
 *
 * @category Model
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */
class PaymentTypes
{

    /**
     * Class variables
     *
     * Initialized with data types. Ensures no other types may be used.
     */
    private $id = 0;
    private $payment_type = 'Unknown payment type';
    private $created_at;
    private $updated_at;

    /**
     * Class constructor.
     */
    public function _construct()
    {
        $this->id = null;
        $this->payment_type = null;
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
     * STRING OUT for $payment_type
     */
    public function getPaymentType()
    {
        return $this->payment_type;
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
     * STRING IN for $payment_type
     */
    public function setPaymentType($payment_type)
    {
        if (is_string($payment_type)) {
            $this->payment_type = (string) $payment_type;
        }
    }

    /**
     * Initialize new record data
     */
    public function initWith($id, $payment_type,
        $created_at, $updated_at) {
        $this->id = $id;
        $this->payment_type = $payment_type;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    /**
     * Initialize with existing record data
     */
    public function initWithId($id)
    {
        $db = Database::getInstance();
        $data = $db->singleFetch('SELECT * FROM payment_types WHERE id = ' . $id);
        $this->initWith($data->id, $data->payment_type,
            $data->created_at, $data->updated_at);
    }

    /**
     * Retrieve all payment types from database
     */
    public function listAll()
    {
        $db = Database::getInstance();
        $data = $db->multiFetch('SELECT id, payment_type FROM payment_types GROUP BY id');
        return $data;
    }

}
