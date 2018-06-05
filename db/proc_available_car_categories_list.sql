/**
 * MySQL v5.6+
 *
 * PROCEDURE select query for cars search. Used in models/Manufacturers.php list function.
 * Select all car categories with available cars based on selected manufacturer.
 *
 * @category Procedure
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */

DELIMITER $$
CREATE PROCEDURE proc_available_car_categories_list(IN manufacturer SMALLINT(5))
IF (manufacturer != 0)
THEN
    SELECT cc.id, cc.category
    FROM car_categories AS cc, manufacturers AS m, cars AS c
    WHERE cc.id = c.category_id
    AND m.id = c.manufacturer_id
    AND m.id = manufacturer;
ELSE
	SELECT cc.id, cc.category
    FROM car_categories AS cc, cars AS c
    WHERE cc.id = c.category_id;
END IF;
$$