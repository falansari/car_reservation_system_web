<?php
include_once $_SERVER['DOCUMENT_ROOT'] . '/Database.php';

/**
 * PHP version 5.6
 *
 * Model class for models database table.
 *
 * @category Model
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */
class Models
{
    /**
     * Class variables
     *
     * Initialized with data types. Ensures no other data types may be used.
     */
    private $id = 0;
    private $model = 'unknown model';
    private $created_at;
    private $updated_at;

    /**
     * Class constructor.
     */
    public function _construct()
    {
        $this->id = null;
        $this->model = null;
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
     * STRING OUT for $model
     */
    public function getCategory()
    {
        return $this->model;
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
     * STRING IN for $model
     */
    public function setCategory($model)
    {
        if (is_string($model)) {
            $this->model = (string) $model;
        }
    }

    /**
     * Initialize new record data
     */
    public function initWith($id, $model, $created_at, $updated_at)
    {
        $this->id = $id;
        $this->model = $model;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    /**
     * Initialize with existing record data
     */
    public function initWithId($id)
    {
        $db = Database::getInstance();
        $data = $db->singleFetch('SELECT * FROM models WHERE id = ' . $id);
        $this->initWith($data->id, $data->model, $data->created_at,
            $data->updated_at);
    }

    /**
     * Retrieve all car categories from database.
     */
    function list()
    {
        $db = Database::getInstance();
        $sql = "SELECT models.id, models.model
            FROM models, cars
            WHERE models.id = cars.model_id
            GROUP BY models.id";
        $data = $db->multiFetch($sql);
        return $data;
    }

}