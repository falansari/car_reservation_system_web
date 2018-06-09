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
    public function listAll()
    {
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
     * @param INT       $start          optional. For pagination. Retrieve records that start at this row number.
     * @param INT       $display        optional. For pagination. Retrieve this number of records.
     * @param DATE      $startDate      required. Booking start date.
     * @param DATE      $endDate        required. Booking end date.
     * @param ID        $manufacturer   optional. Car manufacturer's database id.
     * @param ID        $model          optional. Car model's database id.
     * @param ID        $year           optional. Car make year's database id.
     * @param ID        $category       optional. Car category's database id.
     * @param NUMBER    $minPrice       optional. Cars' daily price minimum allowed.
     * @param NUMBER    $maxPrice       optional. Cars' daily price maximum allowed.
     */
    public function searchCarsQueryBuilder($start = null, $display = null, $startDate, $endDate, $manufacturer = null,
        $model = null, $year = null, $category = null, $minPrice = null, $maxPrice = null) {
        try {

            $db = Database::getInstance();
            $sql = "SELECT cars.id, manufacturers.manufacturer, models.model, make_years.year, car_categories.category, cars.daily_rental_price,
            cars.image, SUM(DATEDIFF('$endDate', '$startDate')+1) 'total_days',
            SUM(cars.daily_rental_price * (DATEDIFF('$endDate', '$startDate')+1)) 'total_cost'
            FROM cars, models, make_years, car_categories, manufacturers,
                reservations, reservation_cars
            WHERE cars.manufacturer_id = manufacturers.id
            AND cars.model_id = models.id
            AND cars.make_year_id = make_years.id
            AND cars.category_id = car_categories.id
            AND reservations.id = reservation_cars.reservation_id OR reservation_cars.reservation_id = NULL
            AND cars.id = reservation_cars.car_id OR reservation_cars.car_id = NULL";

            if (!empty($manufacturer)) {
                $sql .= " AND manufacturers.`id` = '$manufacturer'";
            }

            if (!empty($model)) {
                $sql .= " AND models.id = '$model'";
            }

            if (!empty($year)) {
                $sql .= " AND make_years.id = '$year'";
            }

            if (!empty($category)) {
                $sql .= " AND car_categories.id = '$category'";
            }

            if (!empty($minPrice) && !empty($maxPrice)) {
                $sql .= " AND cars.daily_rental_price BETWEEN " . $minPrice . " AND " . $maxPrice . "";
            }

            $sql .= " AND '$startDate' NOT BETWEEN reservations.start_date AND reservations.end_date
                    AND '$endDate' NOT BETWEEN reservations.start_date AND reservations.end_date
                    GROUP BY cars.id";

            if (!empty($start) && !empty($display)) {
                $sql .= " LIMIT $start, $display";
            }

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

    /**
     * Retrieve from db car object by car id.
     * @param INT   $id     Required. Car id.
     */
    public function getCar($id)
    {
        if ($id) {
            $db = Database::getInstance();
            $data = $db->singleFetch('SELECT cars.id, cars.image, cars.daily_rental_price,
                manufacturers.manufacturer, models.model, car_categories.category, make_years.year
                FROM cars, manufacturers, models, car_categories, make_years
                WHERE cars.id = ' . $id . '
                AND cars.manufacturer_id = manufacturers.id
                AND cars.model_id = models.id
                AND cars.category_id = car_categories.id
                AND cars.make_year_id = make_years.id
                GROUP BY cars.id');
            return $data;
        } else {
            echo "No car id provided or car doesn't exist.";
        }
    }

    /**
     * Returns true if car is being double booked. Returns false if not.
     * @param   INT     $id             Required. Car id.
     * @param   DATE    $startDate      Required. Booking start date.
     * @param   DATE    $endDate        Required. Booking end date.
     */
    public function checkDoubleBooking($id, $startDate, $endDate)
    {
        if ($id && $startDate && $endDate) {
            $db = Database::getInstance();
            $sql = "SELECT cars.id, reservations.start_date, reservations.end_date
                FROM cars, reservations, reservation_cars
                WHERE cars.id = " . $id . "
                AND reservation_cars.car_id = cars.id
                AND reservation_cars.reservation_id = reservations.id
                AND reservations.start_date BETWEEN '" . $startDate . "' AND '" . $endDate . "'
                OR reservations.end_date BETWEEN '" . $startDate . "' AND '" . $endDate . "'
                GROUP BY reservations.id";
            $data = $db->multiFetch($sql);
            
            if ($data != NULL)
            {
                return true;
            } else {
                return false;
            }
        }
        return false;
    }

}
