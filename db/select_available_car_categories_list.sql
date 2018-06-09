/**
 * MySQL v5.6+
 *
 * SELECT query for cars search. Used in models/Categories.php list function.
 * Select all car categories with available cars based on selected manufacturer.
 *
 * @category Query
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */

SELECT car_categories.id, car_categories.category
FROM car_categories, cars
WHERE car_categories.id = cars.category_id
GROUP BY car_categories.id