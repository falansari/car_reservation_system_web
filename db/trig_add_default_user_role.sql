CREATE TRIGGER `trig_add_default_user_role` 
AFTER INSERT ON `users`
 FOR EACH ROW 
 INSERT INTO user_roles(user_id, role_id) VALUES
    (
        (NEW.id),
        (
            SELECT id 
            FROM roles
            WHERE role = 'user'
        )
    )