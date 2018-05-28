<?php
include_once 'Database.php';

/**
 * PHP version 5.6
 *
 * Model class for users database table.
 *
 * @category Model
 * @package  Database
 * @author   Nada Alkooheji (nadakooheji) <nada-kooheji@hotmail.com>
 * @author   (debugger) Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/39
 */
class Users
{

    private $uid;
    private $firstName;
    private $middleName;
    private $lastName;
    private $email;
    private $password;

    public function __construct()
    {
        $this->uid = null;
        $this->firstName = null;
        $this->middleName = null;
        $this->lastName = null;
        $this->password = null;
        $this->email = null;
    }

    /*** SETTERS ***/
    public function setUid($uid)
    {
        $this->uid = $uid;
    }

    public function setfirstName($firstName)
    {
        $this->firstName = $firstName;
    }
    public function setMiddleName($middleName)
    {
        $this->middleName = $middleName;
    }

    public function setlastName($lastName)
    {
        $this->lastName = $lastName;
    }

    public function setPassword($password)
    {
        $this->password = $password;
    }

    public function setEmail($email)
    {
        $this->email = $email;
    }

    /*** GETTERS ***/
    public function getUid()
    {
        return $this->uid;
    }

    public function getfirstName()
    {
        return $this->firstName;
    }

    public function getMiddleName()
    {
        return $this->middlename;
    }

    public function getlastName()
    {
        return $this->lastName;
    }

    public function getPassword()
    {
        return $this->password;
    }

    public function getEmail()
    {
        return $this->email;
    }

    /**
     * Delete user record from database.
     */
    public function deleteUser()
    {
        try {
            $db = new Database();
            $data = $db->querySql('Delete from users where id=' . $this->uid);
            return true;
        } catch (Exception $e) {
            echo 'Exception: ' . $e;
            return false;
        }
    }

    /**
     * Initialize user record by user id.
     *
     * @param INT $uid user record id
     */
    public function initWithUid($uid)
    {

        $db = new Database();
        $data = $db->singleFetch('SELECT * FROM users WHERE id = ' . $uid);
        $this->initWith($data->uid, $data->email, $data->password, $data->firstName, $data->middlename, $data->lastName);
    }

    /**
     * Check user's entered email & password match database record.
     *
     * @param EMAIL     $email user email address
     * @param PASSWORD  $password user password
     */
    public function checkUser($email, $password)
    {
        $db = new Database();

        $data = $db->singleFetch('SELECT * FROM users WHERE email = \'' . $email . '\' AND password = \'' . $password . '\'');
        echo "$db->singleFetch('SELECT * FROM users WHERE email = \''.$email.'\' AND password = \''.$password.'\'') ooooooooooo";
        $this->initWith($data->uid, $data->email, $data->password, $data->firstName, $data->middlename, $data->lastName);
    }

    /**
     * Initialize user record by user email address.
     *
     * @param EMAIL $email  user email address
     */
    public function initWithEmail()
    {
        $db = new Database();

        $data = $db->singleFetch('SELECT * FROM users WHERE email = \'' . $this->email . '\'');
        if ($data != null) {
            return false;
        }
        return true;
    }

    /**
     * Create new user record.
     */
    public function registerUser()
    {

        try {
            $db = new Database();
            $data = $db->querySql('INSERT INTO users(id, first_name, middle_name, last_name, email, password)
                values (NULL,
                    \'' . $this->firstName . '\',
                    \'' . $this->middleName . '\',
                    \'' . $this->lastName . '\',
                    \'' . $this->email . '\',
                    \'' . $this->password . '\')');
            return true;
        } catch (Exception $e) {
            echo 'Exception: ' . $e;
            return false;
        }
    }

    private function initWith($uid, $password, $email)
    {
        $this->uid = $uid;

        $this->password = $password;
        $this->email = $email;
    }

    /**
     * Update user record data.
     */
    public function updateUser()
    {
        $db = new Database();

        $data = 'UPDATE users set
			email = \'' . $this->email . '\' ,
			first_name = \'' . $this->firstName . '\' ,
            last_name = \'' . $this->lastName . '\' ,
            middle_name = \'' . $this->middleName . '\' ,
			password = \'' . $this->password . '\'
			WHERE uid = ' . $this->uid;
        $db->querySql($data);
    }

    /**
     * Retrieve list of all registered users.
     */
    public function getAllusers()
    {
        $db = Database::getInstance();

        $data = $db->multiFetch('Select * from users');
        return $data;
    }

    public function checkExist()
    {

    }

    public function isUserEntryValid()
    {
        $errors = array();

        if (empty($this->username)) {
            $errors[] = 'You must enter first name';
        } else {
            if (!$this->initWithUsername()) {
                $errors[] = 'This Username address is already registered';
            }

        }

        if (empty($this->email)) {
            $errors[] = 'You must enter email';
        }

        if (empty($this->password)) {
            $errors[] = 'You must enter password';
        }

        return $errors;
    }

}
