/**
 * MySQL
 *
 * SELECT query for cars search. Used in models/Cars.php searchCarsQueryBuilder function. 
 *
 * @category Query
 * @package  Database
 * @author   Fatima A. Alansari (falansari) <fatima.a.alansari@outlook.com>
 * @link     https://github.com/falansari/car_reservation_system_web/issues/7
 */

SELECT cars.id, manufacturers.manufacturer, models.model, make_years.year, car_categories.category, cars.daily_rental_price,
cars.image, SUM(DATEDIFF(CURRENT_DATE, CURRENT_DATE)+1) 'total_days',
SUM(cars.daily_rental_price * (DATEDIFF(CURRENT_DATE, CURRENT_DATE)+1)) 'total_cost'
FROM cars, models, make_years, car_categories, manufacturers,
	reservations, reservation_cars
WHERE cars.manufacturer_id = manufacturers.id
AND cars.model_id = models.id
AND cars.make_year_id = make_years.id
AND cars.category_id = car_categories.id
AND reservations.id = reservation_cars.reservation_id OR reservation_cars.reservation_id = NULL
AND cars.id = reservation_cars.car_id OR reservation_cars.car_id = NULL
#AND cars.daily_rental_price BETWEEN minPrice AND maxPrice
#AND manufacturers.id = manufacturer id
#AND models.id = model id
#AND make_years.id = year id
#AND car_categories.id = category id
AND CURRENT_DATE NOT BETWEEN reservations.start_date AND reservations.end_date OR reservations.start_date = NULL
AND CURRENT_DATE NOT BETWEEN reservations.start_date AND reservations.end_date OR reservations.end_date = NULL
GROUP BY cars.id
#LIMIT start, display