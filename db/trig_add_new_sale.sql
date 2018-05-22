CREATE TRIGGER IF NOT EXISTS `trig_add_new_sale` 
AFTER INSERT ON `customer_reservations`
FOR EACH ROW
 INSERT INTO `sales_revenue_report`(transaction_id, transaction_date, transaction_amount) VALUES
 (
     (SELECT id FROM `customer_reservations` WHERE id = NEW.id),
     (SELECT DATE(created_at) FROM `customer_reservations` WHERE id = NEW.id),
     (SELECT total_rental_cost FROM `customer_reservations` WHERE id = NEW.id)
 )