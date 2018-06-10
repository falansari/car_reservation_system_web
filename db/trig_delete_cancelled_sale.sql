DELIMITER $$

DROP TRIGGER IF EXISTS `trig_delete_cancelled_sale`$$

CREATE TRIGGER IF NOT EXISTS `trig_delete_cancelled_sale` 
BEFORE DELETE ON `reservations`
FOR EACH ROW
BEGIN
	DELETE FROM `reservation_cars` WHERE `reservation_cars`.`reservation_id` = OLD.id;
    DELETE FROM `sales_revenue_report` WHERE `sales_revenue_report`.`transaction_id` = OLD.id;
    DELETE FROM `reservation_accessories` WHERE `reservation_accessories`.`reservation_id` = OLD.id;
END$$

DELIMITER ;