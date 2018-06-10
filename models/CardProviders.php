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
 * Model class for card_providers database table.
 *
 * @category Model
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */
class CardProviders
{

    /**
     * Class variables
     *
     * Initialized with data types. Ensures no other types may be used.
     */
    private $id = 0;
    private $card_provider = 'Unknown card provider';
    private $created_at;
    private $updated_at;

    /**
     * Class constructor.
     */
    public function _construct()
    {
        $this->id = null;
        $this->card_provider = null;
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
     * STRING OUT for $card_provider
     */
    public function getCardProvider()
    {
        return $this->card_provider;
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
     * STRING IN for $card_provider
     */
    public function setCardProvider($card_provider)
    {
        if (is_string($card_provider)) {
            $this->card_provider = (string) $card_provider;
        }
    }

    /**
     * Initialize new record data
     */
    public function initWith($id, $card_provider,
        $created_at, $updated_at) {
        $this->id = $id;
        $this->card_provider = $card_provider;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    /**
     * Initialize with existing record data
     */
    public function initWithId($id)
    {
        $db = Database::getInstance();
        $data = $db->singleFetch('SELECT * FROM card_providers WHERE id = ' . $id);
        $this->initWith($data->id, $data->card_provider,
            $data->created_at, $data->updated_at);
    }

    /**
     * Retrieve all payment types from database
     */
    public function listAll()
    {
        $db = Database::getInstance();
        $data = $db->multiFetch('SELECT id, card_provider FROM card_providers GROUP BY id');
        return $data;
    }

}
