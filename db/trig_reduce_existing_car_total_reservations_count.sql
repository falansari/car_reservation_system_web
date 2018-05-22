DELIMITER $$

DROP TRIGGER IF EXISTS `trig_reduce_existing_car_total_reservations_count`$$

CREATE TRIGGER `trig_reduce_existing_car_total_reservations_count` 
AFTER DELETE ON `reservation_cars`
 FOR EACH ROW 
 IF EXISTS (SELECT car_id FROM `most_popular_cars_report` WHERE `most_popular_cars_report`.`car_id` = OLD.car_id) THEN
 UPDATE `most_popular_cars_report`
 SET `most_popular_cars_report`.`reservations_count` = `most_popular_cars_report`.`reservations_count` - 1
 WHERE `most_popular_cars_report`.`car_id` = OLD.car_id;
END IF$$

DELIMITER ;