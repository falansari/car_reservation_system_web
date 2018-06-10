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
 * Model class for reservations database table.
 *
 * @category Model
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/20
 */
class Reservations
{

    /**
     * Class variables
     *
     * Initialized with data types. Ensures no other types may be used.
     */
    private $id = 0;
    private $payment_type_id = 0;
    private $country_id = 0;
    private $card_provider_id = 0;
    private $start_date = '';
    private $end_date = '';
    private $total_rental_cost = 0.0;
    private $first_name = '';
    private $middle_name = '';
    private $last_name = '';
    private $address = '';
    private $cpr = 0;
    private $phone_no = '';
    private $card_number = '';
    private $card_expiry_date = '';
    private $card_security_digits = '';
    private $created_at;
    private $updated_at;

    /**
     * Class constructor.
     */
    public function _construct()
    {
        $this->id = null;
        $this->payment_type_id = null;
        $this->country_id = null;
        $this->card_provider_id = null;
        $this->start_date = null;
        $this->end_date = null;
        $this->total_rental_cost = null;
        $this->first_name = null;
        $this->middle_name = null;
        $this->last_name = null;
        $this->address = null;
        $this->cpr = null;
        $this->phone_no = null;
        $this->card_number = null;
        $this->card_expiry_date = null;
        $this->card_security_digits = null;
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
     * INT OUT for $payment_type_id
     */
    public function getPaymentTypeId()
    {
        return $this->payment_type_id;
    }

    /**
     * INT OUT for $country_id
     */
    public function getCountryId()
    {
        return $this->country_id;
    }

    /**
     * INT OUT for $card_provider_id
     */
    public function getCardProviderId()
    {
        return $this->card_provider_id;
    }

    /**
     * DATE OUT for $start_date
     */
    public function getStartDate()
    {
        return $this->start_date;
    }

    /**
     * DATE OUT for $end_date
     */
    public function getEndDate()
    {
        return $this->end_date;
    }

    /**
     * NUMBER OUT for $total_rental_cost
     */
    public function getTotalRentalCost()
    {
        return $this->total_rental_cost;
    }

    /**
     * STRING OUT for $first_name
     */
    public function getFirstName()
    {
        return $this->first_name;
    }

    /**
     * STRING OUT for $middle_name
     */
    public function getMiddleName()
    {
        return $this->middle_name;
    }

    /**
     * STRING OUT for $last_name
     */
    public function getLastName()
    {
        return $this->last_name;
    }

    /**
     * STRING OUT for $address
     */
    public function getAddress()
    {
        return $this->address;
    }

    /**
     * INT OUT for $cpr
     */
    public function getCPR()
    {
        return $this->cpr;
    }

    /**
     * STRING OUT for $phone_no
     */
    public function getPhoneNo()
    {
        return $this->phone_no;
    }

    /**
     * STRING OUT for $card_number
     */
    public function getCardNumber()
    {
        return $this->card_number;
    }

    /**
     * STRING OUT for $card_expiry_date
     */
    public function getCardExpiryDate()
    {
        return $this->card_expiry_date;
    }

    /**
     * STRING OUT for $card_security_digits
     */
    public function getCardSecurityDigits()
    {
        return $this->card_security_digits;
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
     * INT IN for $payment_type_id
     */
    public function setPaymentTypeId()
    {
        if (is_integer($payment_type_id)) {
            $this->payment_type_id = (integer) $payment_type_id;
        }
    }

    /**
     * INT IN for $country_id
     */
    public function setCountryId()
    {
        if (is_integer($country_id)) {
            $this->country_id = (integer) $country_id;
        }
    }

    /**
     * INT IN for $card_provider_id
     */
    public function setCardProviderId()
    {
        if (is_integer($card_provider_id)) {
            $this->card_provider_id = (integer) $card_provider_id;
        }
    }

    /**
     * DATE IN for $start_date
     */
    public function setStartDate()
    {
        $this->start_date = date('Y-m-d', $start_date);
    }

    /**
     * DATE IN for $end_date
     */
    public function setEndDate()
    {
        $this->end_date = date('Y-m-d', $end_date);
    }

    /**
     * NUMBER IN for $total_rental_cost
     */
    public function setTotalRentalCost()
    {
        if (is_numeric($total_rental_cost)) {
            $this->total_rental_cost = (float) $total_rental_cost;
        }
    }

    /**
     * STRING IN for $first_name
     */
    public function setFirstName()
    {
        if (is_string($first_name)) {
            $this->first_name = (string) $first_name;
        }
    }

    /**
     * STRING IN for $middle_name
     */
    public function setMiddleName()
    {
        if (is_string($middle_name)) {
            $this->middle_name = (string) $middle_name;
        }
    }

    /**
     * STRING IN for $last_name
     */
    public function setLastName()
    {
        if (is_string($last_name)) {
            $this->last_name = (string) $last_name;
        }
    }

    /**
     * STRING IN for $address
     */
    public function setAddress()
    {
        if (is_string($address)) {
            $this->address = (string) $address;
        }
    }

    /**
     * INT IN for $cpr
     */
    public function setCPR()
    {
        if (is_integer($cpr)) {
            $this->cpr = (integer) $cpr;
        }
    }

    /**
     * STRING IN for $phone_no
     */
    public function setPhoneNo()
    {
        if (is_string($phone_no)) {
            $this->phone_no = (string) $phone_no;
        }
    }

    /**
     * STRING IN for $card_number
     */
    public function setCardNumber()
    {
        if (is_string($card_number)) {
            $this->card_number = (string) $card_number;
        }
    }

    /**
     * STRING IN for $card_expiry_date
     */
    public function setCardExpiryDate()
    {
        if (is_string($card_expiry_date)) {
            $this->card_expiry_date = (string) $card_expiry_date;
        }
    }

    /**
     * STRING IN for $card_security_digits
     */
    public function setCardSecurityDigits()
    {
        if (is_string($card_security_digits)) {
            $this->card_security_digits = (string) $card_security_digits;
        }
    }

    /**
     * Initialize new record data
     */
    public function initWith($id, $payment_type_id, $country_id, $card_provider_id,
        $start_date, $end_date, $total_rental_cost, $first_name, $middle_name,
        $last_name, $address, $cpr, $phone_no, $card_number, $card_expiry_date,
        $card_security_digits, $created_at, $updated_at) {
        $this->id = $id;
        $this->payment_type_id = $payment_type_id;
        $this->country_id = $country_id;
        $this->card_provider_id = $card_provider_id;
        $this->start_date = $start_date;
        $this->end_date = $end_date;
        $this->total_rental_cost = $total_rental_cost;
        $this->first_name = $first_name;
        $this->middle_name = $middle_name;
        $this->last_name = $last_name;
        $this->address = $address;
        $this->cpr = $cpr;
        $this->phone_no = $phone_no;
        $this->card_number = $card_number;
        $this->card_expiry_date = $card_expiry_date;
        $this->card_security_digits = $card_security_digits;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    /**
     * Initialize with existing record data
     */
    public function initWithId($id)
    {
        $db = Database::getInstance();
        $data = $db->singleFetch('SELECT * FROM reservations WHERE id = ' . $id);
        $this->initWith($data->id, $data->payment_type_id, $data->country_id, $data->card_provider_id,
            $data->start_date, $data->end_date, $data->total_rental_cost, $data->first_name, $data->middle_name,
            $data->last_name, $data->address, $data->cpr, $data->phone_no, $data->card_number, $data->card_expiry_date,
            $data->card_security_digits, $data->created_at, $data->updated_at);
    }

    /**
     * Retrieve all reservations from database
     */
    public function listAll()
    {
        $db = Database::getInstance();
        $data = $db->multiFetch('SELECT * FROM reservations GROUP BY id');
        return $data;
    }

    /**
     * Save new reservation to database
     * @param   INT     $car                    Required. Car id.
     * @param   ARRAY   $accessories            Required. Array of INT accessory ids.
     * @param   INT     $paymentType            Required. payment type id.
     * @param   INT     $country                Required. Country id.
     * @param   DATE    $startDate              Required. Reservation start date.
     * @param   DATE    $endDate                Required. Reservation end date.
     * @param   FLOAT   $totalRentalCost        Required. Total rental cost.
     * @param   STRING  $firstName              Required. Customer first name.
     * @param   STRING  $middleName             Required. Customer middle name.
     * @param   STRING  $lastName               Required. Customer last name.
     * @param   STRING  $billingAddress         Required. Customer billing address.
     * @param   INT     $cprNo                  Required. Customer CPR number.
     * @param   STRING  $phoneNo                Required. Customer phone number.
     * @param   INT     $cardProvider           Optional. Customer Credit Card Provider. Mandatory for Card payment type.
     * @param   STRING  $cardNumber             Optional. Customer Credit Card Number. Mandatory for Card payment type.
     * @param   DATE    $cardExpiry             Optional. Customer Credit Card Expiry Date. Mandatory for Card payment type.
     * @param   STRING  $cardSecurityDigits     Optional. Customer Credit Card Security Digits. Mandatory for Card payment type.
     */
    public function save($car, $accessories, $paymentType, $country, $startDate, $endDate, $totalRentalCost,
        $firstName, $middleName, $lastName, $billingAddress, $cprNo, $phoneNo,
        $cardProvider = null, $cardNumber = null, $cardExpiry = null, $cardSecurityDigits = null) {

        if ($cardExpiry != null) {
            $cardExpiry = DateTime::createFromFormat('m-Y', $cardExpiry)->format('m-Y');
        }

        $mysqli = new mysqli('10.31.40.60', '20900029', '20900029', '20900029');
        //$mysqli = new mysqli('localhost','root','', 'car_reservation_system');

        if ($cardProvider == null || $cardProvider == 0) {
            $reservationSql = "INSERT INTO `reservations` (`id`, `payment_type_id`, `country_id`,
            `start_date`, `end_date`, `total_rental_cost`, `first_name`, `middle_name`, `last_name`, `address`,
            `CPR`, `phone_no`)
            VALUES (NULL, $paymentType, $country, '$startDate', '$endDate', '$totalRentalCost', '$firstName', '$middleName', '$lastName',
            '$billingAddress', '$cprNo', '$phoneNo')";
        } else {
            $reservationSql = "INSERT INTO `reservations` (`id`, `payment_type_id`, `country_id`, `card_provider_id`,
            `start_date`, `end_date`, `total_rental_cost`, `first_name`, `middle_name`, `last_name`, `address`,
            `CPR`, `phone_no`, `card_number`, `card_expiry_date`, `card_security_digits`)
            VALUES (NULL, $paymentType, $country, $cardProvider, '$startDate', '$endDate', '$totalRentalCost', '$firstName', '$middleName', '$lastName',
            '$billingAddress', '$cprNo', '$phoneNo', '$cardNumber', '$cardExpiry', '$cardSecurityDigits')";
        }

        $reservationCarSql = $mysqli->query($reservationSql);

        $reservationId = $mysqli->insert_id;

        $reservationCarSql = "INSERT INTO `reservation_cars` (`id`, `reservation_id`, `car_id`) VALUES (NULL, $reservationId, $car)";

        $reservationCarSql = $mysqli->query($reservationCarSql);

        // must run multiple times for ea accessory
        $reservationAccessoriesSql = "INSERT INTO `reservation_accessories` (`id`, `accessory_id`, `reservation_id`, `reserve_qty`) VALUES ";

        $accessories = (array) $accessories;

        if (count($accessories) == 1) {
            $reservationAccessoriesSql .= "(NULL, " . $accessories[0] . ", $reservationId, '1') ";
        } else {
            $lastElement = end($accessories);
            for ($i = 0; $i < count($accessories); $i++) {
                if ($accessories[$i] == $lastElement) {
                    $reservationAccessoriesSql .= "(NULL, " . $accessories[$i] . ", $reservationId, '1')";
                } else {
                    $reservationAccessoriesSql .= "(NULL, " . $accessories[$i] . ", $reservationId, '1'), ";
                }
            }
        }
        $reservationAccessoriesSql = $mysqli->query($reservationAccessoriesSql);
        return $reservationId;
    }

    public function reservationDetails($id)
    {
        $db = Database::getInstance();
        $sql = "SELECT reservations.id, reservations.start_date, reservations.end_date, reservations.total_rental_cost,
        reservations.first_name, reservations.middle_name, reservations.last_name, reservations.address,
        reservations.CPR, reservations.phone_no, reservations.card_number, cars.daily_rental_price, cars.image,
        manufacturers.manufacturer, models.model, make_years.year, car_categories.category,
        countries.country_name_en, countries.country_nationality_en
        FROM reservations, cars, reservation_cars, manufacturers, models, make_years, car_categories, countries
        WHERE reservations.id = $id
        AND reservation_cars.reservation_id = reservations.id
        AND reservation_cars.car_id = cars.id
        AND cars.manufacturer_id = manufacturers.id
        AND cars.model_id = models.id
        AND cars.make_year_id = make_years.id
        AND cars.category_id = car_categories.id
        AND reservations.country_id = countries.id
        GROUP BY reservations.id";
        $data = $db->singleFetch($sql);
        return $data;
    }

    public function reservationAccessories($reservationId)
    {
        $db = Database::getInstance();
        $sql = "SELECT accessories.accessory, accessories.daily_rental_price
        FROM reservations, accessories, reservation_accessories
        WHERE reservations.id = $reservationId
        AND reservations.id = reservation_accessories.reservation_id
        AND reservation_accessories.accessory_id = accessories.id
        GROUP BY accessories.id";
        $data = $db->multiFetch($sql);
        return $data;
    }

    /**
     * Delete cancelled reservation from db
     * @param   INT     $id     Required. Reservation id.
     */
    public function delete($id)
    {
        $db = Database::getInstance();
        $sql = "DELETE FROM reservations WHERE reservations.id = $id";
        $sql = $db->querySql($sql);
    }

}
