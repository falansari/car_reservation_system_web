<?php
include_once $_SERVER['DOCUMENT_ROOT'] . '/Database.php';

/**
 * PHP version 5.6
 *
 * Model class for countries database table.
 *
 * @category Model
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */
class Countries
{

    /**
     * Class variables
     *
     * Initialized with data types. Ensures no other types may be used.
     */
    private $id = 0;
    private $country_code = 'UN';
    private $country_name_en = 'English Name';
    private $country_nationality_en = 'English Nationality';
    private $country_name_ar = 'أسم عربي';
    private $country_nationality_ar = 'جنسية عربي';
    private $created_at;
    private $updated_at;

    /**
     * Class constructor.
     */
    public function _construct()
    {
        $this->id = null;
        $this->country_code = null;
        $this->country_name_en = null;
        $this->country_nationality_en = null;
        $this->country_name_ar = null;
        $this->country_nationality_ar = null;
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
     * STRING OUT for $country_code
     */
    public function getCountryCode()
    {
        return $this->country_code;
    }

    /**
     * STRING OUT for $country_name_en
     */
    public function getCountryNameEn()
    {
        return $this->country_name_en;
    }

    /**
     * STRING OUT for $country_nationality_en
     */
    public function getCountryNationalityEn()
    {
        return $this->country_nationality_en;
    }

    /**
     * STRING OUT for $country_name_ar
     */
    public function getCountryNameAr()
    {
        return $this->country_name_ar;
    }

    /**
     * STRING OUT for $country_nationality_ar
     */
    public function getCountryNationalityAr()
    {
        return $this->country_nationality_ar;
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
     * STRING IN for $country_code
     */
    public function setCountryCode()
    {
        if (is_string($country_code)) {
            $this->country_code = (string) $country_code;
        }
    }

    /**
     * STRING IN for $country_name_en
     */
    public function setCountryNameEn()
    {
        if (is_string($country_name_en)) {
            $this->country_name_en = (string) $country_name_en;
        }
    }

    /**
     * STRING IN for $country_nationality_en
     */
    public function setCountryNationalityEn()
    {
        if (is_string($country_nationality_en)) {
            $this->country_nationality_en = (string) $country_nationality_en;
        }
    }

    /**
     * STRING IN for $country_name_ar
     */
    public function setCountryNameAr()
    {
        if (is_string($country_name_ar)) {
            $this->country_name_ar = (string) $country_name_ar;
        }
    }

    /**
     * STRING IN for $country_nationality_ar
     */
    public function setCountryNationalityAr()
    {
        if (is_string($country_nationality_ar))
        {
            $this->country_nationality_ar = (string) $country_nationality_ar;
        }
    }

    /**
     * Initialize new record data
     */
    public function initWith($id, $country_code, $country_name_en, 
        $country_nationality_en, $country_name_ar, $country_nationality_ar,
        $created_at, $updated_at) {
        $this->id = $id;
        $this->country_code = $country_code;
        $this->country_name_en = $country_name_en;
        $this->country_nationality_en = $country_nationality_en;
        $this->country_name_ar = $country_name_ar;
        $this->country_nationality_ar = $country_nationality_ar;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    /**
     * Initialize with existing record data
     */
    public function initWithId($id)
    {
        $db = Database::getInstance();
        $data = $db->singleFetch('SELECT * FROM countries WHERE id = ' . $id);
        $this->initWith($data->id, $data->country_code, $data->country_name_en, 
            $data->country_nationality_en, $data->country_name_ar, 
            $data->country_nationality_ar, $data->created_at, $data->updated_at);
    }

    /**
     * Retrieve all countries from database
     */
    public function listAll()
    {
        $db = Database::getInstance();
        $data = $db->multiFetch('SELECT * FROM countries');
        return $data;
    }

    /**
     * Retrieve all nationalities (English) from database
     */
    public function listNationalitiesEn()
    {
        $db = Database::getInstance();
        $data = $db->multiFetch('SELECT id, country_nationality_en FROM countries GROUP BY id');
        return $data;
    }

}
