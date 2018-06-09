/**
 * MySQL v5.6+
 *
 * SELECT query for cars search. Used in models/Manufacturers.php list function.
 * Retrieves all manufacturers that have an associated car available.
 *
 * @category Query
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */

SELECT manufacturers.id, manufacturers.manufacturer
FROM manufacturers, cars
WHERE manufacturers.id = cars.manufacturer_id
GROUP BY manufacturers.id