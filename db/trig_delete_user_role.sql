CREATE TRIGGER `trig_delete_default_user_role` 
BEFORE DELETE ON `users`
 FOR EACH ROW
 DELETE FROM `user_roles`
 WHERE `user_roles`.`user_id` = OLD.id;