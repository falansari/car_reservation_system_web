CREATE TRIGGER IF NOT EXISTS `trig_add_new_sale` 
AFTER INSERT ON `reservations`
FOR EACH ROW
 INSERT INTO `sales_revenue_report`(transaction_id, transaction_date, transaction_amount) VALUES
 (
     (SELECT id FROM `reservations` WHERE id = NEW.id),
     (SELECT DATE(created_at) FROM `reservations` WHERE id = NEW.id),
     (SELECT total_rental_cost FROM `reservations` WHERE id = NEW.id)
 )