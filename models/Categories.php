<?php
include_once $_SERVER['DOCUMENT_ROOT'] . '/Database.php';

/**
 * PHP version 5.6
 *
 * Model class for car_categories database table.
 *
 * @category Model
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */
class Categories
{
    /**
     * Class variables
     *
     * Initialized with data types. Ensures no other data types may be used.
     */
    private $id = 0;
    private $category = 'unknown cat';
    private $created_at;
    private $updated_at;

    /**
     * Class constructor.
     */
    public function _construct()
    {
        $this->id = null;
        $this->category = null;
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
     * STRING OUT for $category
     */
    public function getCategory()
    {
        return $this->category;
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
     * STRING IN for $category
     */
    public function setCategory($category)
    {
        if (is_string($category)) {
            $this->category = (string) $category;
        }
    }

    /**
     * Initialize new record data
     */
    public function initWith($id, $category, $created_at, $updated_at)
    {
        $this->id = $id;
        $this->category = $category;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    /**
     * Initialize with existing record data
     */
    public function initWithId($id)
    {
        $db = Database::getInstance();
        $data = $db->singleFetch('SELECT * FROM car_categories WHERE id = ' . $id);
        $this->initWith($data->id, $data->category, $data->created_at,
            $data->updated_at);
    }

    /**
     * Retrieve all car categories from database.
     */
    function listAll()
    {
        $db = Database::getInstance();
        $sql = "SELECT car_categories.id, car_categories.category
            FROM car_categories, cars
            WHERE car_categories.id = cars.category_id
            GROUP BY car_categories.id";
        $data = $db->multiFetch($sql);
        return $data;
    }

}