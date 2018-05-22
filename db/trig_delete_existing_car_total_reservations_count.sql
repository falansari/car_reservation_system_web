DELIMITER $$

DROP TRIGGER IF EXISTS `trig_delete_existing_car_total_reservations_count`$$

CREATE TRIGGER `trig_delete_existing_car_total_reservations_count` 
BEFORE DELETE ON `cars`
 FOR EACH ROW
 IF EXISTS (SELECT car_id FROM `most_popular_cars_report` WHERE `most_popular_cars_report`.`car_id` = OLD.id) THEN
 DELETE FROM `most_popular_cars_report` WHERE `most_popular_cars_report`.`car_id` = OLD.id;
 END IF$$

DELIMITER ;