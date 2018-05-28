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

SELECT c.id, r.manufacturer, m.model, y.year, t.category, c.daily_rental_price, 
    image, SUM(DATEDIFF('2018-05-03', '2018-05-02')+1) 'total_days', 
    SUM(c.daily_rental_price * (DATEDIFF('2018-05-03', '2018-05-02')+1)) 'total_cost'
FROM cars c, models m, make_years y, car_categories t, manufacturers r, 
	customer_reservations cr, reservation_cars rc
WHERE c.manufacturer_id = r.id
AND c.model_id = m.id
AND c.make_year_id = y.id
AND c.category_id = t.id
AND cr.id = rc.reservation_id
AND c.id = rc.car_id
AND '2018-05-01' NOT BETWEEN cr.start_date AND cr.end_date
AND '2018-05-06' NOT BETWEEN cr.start_date AND cr.end_date
#AND c.daily_rental_price BETWEEN minPrice AND maxPrice
#AND r.id = manufacturer id
#AND m.id = model id
#AND y.id = year id
#AND t.id = category id
GROUP BY c.id
LIMIT 10