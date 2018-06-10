<?php

include_once 'Database.php';
$db = new Database();

class Dropdownfunctions {
    private $cid;
     function __construct() {
        $this->cid = null;
       
    }

    function setUid($uid) {
        $this->cid = $uid;
    }


    function category() {

            
      
        
        
        $q = "SELECT * FROM car_categories";
       
        $db = new Database();


        if ($data = $db->multiFetch($q)) {
            for ($i = 0; $i < count($data); $i++) {
                echo '<option value="' . $data[$i]->id . '"  >' . $data[$i]->category . '</option>';
                  
            }
        }
    }
    function accessory() {

        $q = "SELECT * FROM accessories";
        $db = new Database();

        if ($data = $db->multiFetch($q)) {
            for ($i = 0; $i < count($data); $i++) {
              
                echo '<input type="checkbox" value="' . $data[$i]->id . '">'. $data[$i]->accessory .'<br>';
            }
        }
    }

    function manufacture() {

        $q = "SELECT * FROM manufacturers";
        $db = new Database();

        if ($data = $db->multiFetch($q)) {
            for ($i = 0; $i < count($data); $i++) {
                echo '<option value="' . $data[$i]->id . '" >' . $data[$i]->manufacturer . '</option>';
            }
        }
    }
     function year() {

        $q = "SELECT * FROM make_years";
        $db = new Database();

        if ($data = $db->multiFetch($q)) {
            for ($i = 0; $i < count($data); $i++) {
                echo '<option value="' . $data[$i]->id . '" >' . $data[$i]->year . '</option>';
            }
        }
    }
     function model() {

        $q = "SELECT * FROM models";
        $db = new Database();

        if ($data = $db->multiFetch($q)) {
            for ($i = 0; $i < count($data); $i++) {
                echo '<option value="' . $data[$i]->id . '" >' . $data[$i]->model . '</option>';
            }
        }
    }

}
