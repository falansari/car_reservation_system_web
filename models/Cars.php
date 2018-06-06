<?php
include_once $_SERVER['DOCUMENT_ROOT'] . '/Database.php';

/**
 * PHP version 5.6
 *
 * Model class for cars database table.
 *
 * @category Model
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */
class Cars
{

    /**
     * Class variables
     *
     * Initialized with data types. Ensures no other types may be used.
     */
    private $id = 0;
    private $manufacturer_id = 0;
    private $model_id = 0;
    private $make_year_id = 0;
    private $category_id = 0;
    private $daily_rental_price = 0.0;
    private $image = 'Unknown Image';
    private $created_at;
    private $updated_at;

    /**
     * Class constructor.
     */
    public function _construct()
    {
        $this->id = null;
        $this->manufacturer_id = null;
        $this->model_id = null;
        $this->make_year_id = null;
        $this->category_id = null;
        $this->daily_rental_price = null;
        $this->image = null;
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
     * INT OUT for $manufacturer_id
     */
    public function getManufacturerId()
    {
        return $this->manufacturer_id;
    }

    /**
     * INT OUT for $model_id
     */
    public function getModelId()
    {
        return $this->model_id;
    }

    /**
     * INT OUT for $make_year_id
     */
    public function getMakeYearId()
    {
        return $this->make_year_id;
    }

    /**
     * INT OUT for $category_id
     */
    public function getCategoryId()
    {
        return $this->category_id;
    }

    /**
     * FLOAT OUT for $daily_rental_price
     */
    public function getDailyRentalPrice()
    {
        return $this->daily_rental_price;
    }

    /**
     * STRING OUT for $image
     */
    public function getImage()
    {
        return $this->image;
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
     * INT IN for $manufacturer_id
     */
    public function setManufacturer($manufacturer_id)
    {
        if (is_integer($manufacturer_id)) {
            $this->manufacturer_id = (integer) $manufacturer_id;
        }
    }

    /**
     * INT IN for $model_id
     */
    public function setModel($model_id)
    {
        if (is_integer($model_id)) {
            $this->model_id = (integer) $model_id;
        }
    }

    /**
     * INT IN for $make_year_id
     */
    public function setMakeYear($make_year_id)
    {
        if (is_integer($make_year_id)) {
            $this->make_year_id = (integer) $make_year_id;
        }
    }

    /**
     * INT IN for $category_id
     */
    public function setCategory($category_id)
    {
        if (is_integer($category_id)) {
            $this->category_id = (integer) $category_id;
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
     * STRING IN for $image
     */
    public function setImage($image)
    {
        if (is_string($image)) {
            $this->image = (string) $image;
        }
    }

    /**
     * Initialize new record data
     */
    public function initWith($id, $manufacturer_id, $model_id,
        $make_year_id, $category_id, $daily_rental_price, $image,
        $created_at, $updated_at) {
        $this->id = $id;
        $this->manufacturer_id = $manufacturer_id;
        $this->model_id = $model_id;
        $this->make_year_id = $make_year_id;
        $this->category_id = $category_id;
        $this->daily_rental_price = $daily_rental_price;
        $this->image = $image;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    /**
     * Initialize with existing record data
     */
    public function initWithId($id)
    {
        $db = Database::getInstance();
        $data = $db->singleFetch('SELECT * FROM cars WHERE id = ' . $id);
        $this->initWith($data->id, $data->manufacturer_id,
            $data->model_id, $data->make_year_id,
            $data->category_id, $data->daily_rental_price,
            $data->image, $data->created_at, $data->updated_at);
    }

    /**
     * Retrieve all cars from database
     */
    function listAll() {
        $db = Database::getInstance();
        $data = $db->multiFetch('SELECT * FROM cars');
        return $data;
    }

    /**
     * Add new car to database
     */
    public function createCar()
    {
        try {
            $db = Database::getInstance();
            $data = $db->querySql("INSERT INTO `cars` (`id`, `manufacturer_id`, `model_id`, `make_year_id`, `category_id`, `daily_rental_price`, `image`)
                VALUES (NULL, \'$this->manufacturer_id\', \'$this->model_id\', \'$this->make_year_id\', \'$this->category_id\', \'$this->daily_rental_price\', \''$this->image'\')");
            return true;
        } catch (Exception $exception) {
            echo 'Exception: ' . $exception;
            return false;
        }
    }

    /**
     * Car search query builder. Changes search query based on user's search criteria.
     * @param DATE      $startDate      required
     * @param DATE      $endDate        required
     * @param ID        $manufacturer   optional
     * @param ID        $model          optional
     * @param ID        $year           optional
     * @param ID        $category       optional
     * @param NUMBER    $minPrice       optional
     * @param NUMBER    $maxPrice       optional
     */
    public function searchCarsQueryBuilder($startDate, $endDate, $manufacturer = null, $model = null, $year = null, $category = null,
        $minPrice = null, $maxPrice = null) {
        try {

            $db = Database::getInstance();
            $sql = "SELECT c.id, r.manufacturer, m.model, y.year, t.category, c.daily_rental_price,
                image, SUM(DATEDIFF('$endDate', '$startDate')+1) 'total_days',
                SUM(c.daily_rental_price * (DATEDIFF('$endDate', '$startDate')+1)) 'total_cost'
                FROM cars c, models m, make_years y, car_categories t, manufacturers r,
                    customer_reservations cr, reservation_cars rc
                WHERE c.manufacturer_id = r.id
                AND c.model_id = m.id
                AND c.make_year_id = y.id
                AND c.category_id = t.id
                AND cr.id = rc.reservation_id
                AND c.id = rc.car_id";

            if (!empty($manufacturer)) {
                $sql .= " AND r.`id` = '$manufacturer'";
            }

            if (!empty($model)) {
                $sql .= " AND m.id = '$model'";
            }

            if (!empty($year)) {
                $sql .= " AND y.id = '$year'";
            }

            if (!empty($category)) {
                $sql .= " AND t.id = '$category'";
            }

            if (!empty($minPrice) && !empty($maxPrice)) {
                $sql .= " AND c.daily_rental_price BETWEEN " . $minPrice . " AND " . $maxPrice . "";
            }

            $sql .= " AND '$startDate' NOT BETWEEN cr.start_date AND cr.end_date
                    AND '$endDate' NOT BETWEEN cr.start_date AND cr.end_date
                    GROUP BY c.id
                    LIMIT 10";

            $data = $db->multiFetch($sql);
            return $data;

            if ($data === null) {
                echo 'No available cars that meet search criteria.';
            }

        } catch (Exception $exception) {
            echo 'Exception: ' . $exception;
            return false;
        }
    }

    /**
     * Retrieve from db cheapest car daily price.
     */
    public function minPrice()
    {
        $db = Database::getInstance();
        $data = $db->singleFetch("SELECT MIN(cars.daily_rental_price) AS minPrice FROM cars");
        $data = (int) $data->minPrice;
        return $data;
    }

    /**
     * Retrieve from db highest car daily price.
     */
    public function maxPrice()
    {
        $db = Database::getInstance();
        $data = $db->singleFetch("SELECT MAX(cars.daily_rental_price) AS maxPrice FROM cars");
        $data = (int) $data->maxPrice;
        return $data;
    }

}
