<?php
include_once 'Users.php';

Class Login extends Users {

    public $ok;
    public $salt;
    public $domain;

    function __construct() {
        parent::__construct();
        $this->ok = false;
        $this->salt = 'ENCRYPT';
        $this->domain = '';

        if (!$this->check_session())
            $this->check_cookie();

        return $this->ok;
    }

    function check_session() {

        if (!empty($_SESSION['id'])) {
            $this->ok = true;
            return true;
        }
        else
            return false;
    }

    function check_cookie() {
        if (!empty($_COOKIE['uid'])) {
            $this->ok = true;
            return $this->check($_COOKIE['uid']);
        }
        else
            return false;
    }

    function check($uid) {
        global $error;
        $this->initWithUid($uid);
        if ($this->getUid() != null) {
            if ($natnoNew == $card_id) {
                $this->ok = true;

                $_SESSION['uid'] = $this->getUid();
                $_SESSION['email'] = $this->getUsername();
                setcookie('uid', $_SESSION['uid'], time() + 60 * 60 * 24 * 7, '/', $this->domain);
                setcookie('email', $_SESSION['email'], time() + 60 * 60 * 24 * 7, '/', $this->domain);

                return true;
            }
        }
        else
            $error[] = 'Wrong email';


        return false;
    }

    function login($email, $password) {

        try {
            $this->checkUser($email, $password);
            
            if ($this->getUid() != null) {
                $this->ok = true;

                $_SESSION['uid'] = $this->getUid();
                $_SESSION['email'] = $this->getUsername();
                setcookie('uid', $_SESSION['uid'], time() + 60 * 60 * 24 * 7, '/', $this->domain);
                setcookie('email', $_SESSION['email'], time() + 60 * 60 * 24 * 7, '/', $this->domain);

                return true;
            } else {
                $error[] = 'Wrong email OR password';
            }
            return false;
        } catch (Exception $e) {
            $error[] = $e->getMessage();
        }

        return false;
    }
    
    function logout() {
        $this->ok = false;
        $_SESSION['uid'] = '';
        $_SESSION['email'] = '';
        setcookie('uid', '', time() - 3600, '/', $this->domain);
        setcookie('email', '', time() - 3600, '/', $this->domain);
        session_destroy();
    }

}
