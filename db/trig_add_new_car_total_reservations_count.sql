DELIMITER $$

DROP TRIGGER IF EXISTS `trig_add_new_car_total_reservations_count`$$

CREATE TRIGGER `trig_add_new_car_total_reservations_count` 
AFTER INSERT ON `reservation_cars`
 FOR EACH ROW 
 IF NOT EXISTS (SELECT car_id FROM `most_popular_cars_report` WHERE `most_popular_cars_report`.`car_id` = NEW.car_id) THEN
 INSERT INTO `most_popular_cars_report`(car_id, reservations_count) VALUES
(
    (NEW.car_id),
    (SELECT count(car_id) 
     FROM `reservation_cars`
     WHERE car_id = NEW.car_id)
);
END IF$$

DELIMITER ;