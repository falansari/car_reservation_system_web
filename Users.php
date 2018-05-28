<?php
include_once 'Database.php';
$db = new Database();
class Users {
    private $uid;
private $firstName;
    private $lastName;
    private $middleName;
    private $email;
    private $password;

    function __construct() {
        $this->uid = null;
        $this->firstName = null;
        $this->middleName = null;
        $this->lastName = null;
        $this->password = null;
        $this->email = null;
    }

    function setUid($uid) {
        $this->uid = $uid;
    }

    function setFirstname($firstname) {
        $this->firstName = $firstname;
    }
    function setMiddlename($middlename) {
        $this->middleName = $middlename;
    }
    
   function setLastname($lastname) {
        $this->middleName = $lastname;
    }

    function setPassword($password) {
        $this->password = $password;
    }

    function setEmail($email) {
        $this->email = $email;
    }

    function getUid() {
        return $this->uid;
    }
function getFirstName() {
        return $this-firstname;
    }
    function getMiddleName() {
        return $this->middlename;
    }
    function getlastName() {
        return $this->lastname;
    }

    function getPassword() {
        return $this->password;
    }

    function getEmail() {
        return $this->email;
    }

    function deleteuser() {
        try {
            $db = new Database();
            $data = $db->querySql('Delete from users where id=' . $this->uid);
            return true;
        } catch (Exception $e) {
            echo 'Exception: ' . $e;
            return false;
        }
    }

    function initWithUid($uid) {

        
        $db = new Database();
        $data = $db->singleFetch('SELECT * FROM users WHERE id = ' . $uid);
        $this->initWith($data->uid, $data->email, $data->password,$data->firstname,$data->middlename,$data->lastname);
    }
    
    function checkUser($email, $password){
       $db = new Database();
        
       $data = $db->singleFetch('SELECT * FROM users WHERE email = \''.$email.'\' AND password = \''.$password.'\'');
       echo "$db->singleFetch('SELECT * FROM users WHERE email = \''.$email.'\' AND password = \''.$password.'\'') ooooooooooo";
       $this->initWith($data->uid, $data->email, $data->password,$data->firstname,$data->middlename,$data->lastname);
    }

    function initWithemail() {

        $db = new Database();
        $data = $db->singleFetch('SELECT * FROM users WHERE email = \'' . $this->email.'\'');
        if ($data != null) {
            return false;
        }
        return true;
    }

    function registerUser() {

        try {
           $db = new Database();
            $data = $db->querySql('INSERT INTO users(id,first_name, last_name,middle_name, email, password, created_at) values (NULL, \'' . $this->firstName . '\', \'' . $this->lastName . '\',\'' . $this->middleName . '\',\'' . $this->email . '\',\'' . $this->password . '\', CURRENT_TIMESTAMP)');
            return true;
        } catch (Exception $e) {
            echo 'Exception: ' . $e;
            return false;
        }
    }

    private function initWith($uid, $password, $email) {
        $this->uid = $uid;
       
        $this->password = $password;
        $this->email = $email;
    }

    function updateDB() {

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

    function getAllusers() {
        $db = Database::getInstance();
        $data = $db->multiFetch('Select * from users');
        return $data;
    }
    
    function checkExist(){
        
    }

    public function isValid() {
        $errors = array();

        if (empty($this->username))
            $errors[] = 'You must enter first name';
        else {
            if (!$this->initWithUsername())
                $errors[] = 'This Username address is already registered';
        }

        if (empty($this->email))
            $errors[] = 'You must enter email';


        if (empty($this->password))
            $errors[] = 'You must enter password';

        return $errors;
    }

}