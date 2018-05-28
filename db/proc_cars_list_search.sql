/**
TODO: Turn procedure into PHP function that builds query based on how much filtering is needed.
*/

##CALL proc_cars_list_search(10, 87, 28, 13, '2018-06-18', '2018-06-25', 10, 30)

DELIMITER $$

DROP PROCEDURE IF EXISTS proc_cars_list_search$$

CREATE PROCEDURE IF NOT EXISTS proc_cars_list_search(IN manufacturer SMALLINT, IN model MEDIUMINT, IN year SMALLINT, IN category TINYINT, IN startDate DATE, IN endDate DATE, IN minPrice DECIMAL(6,3), IN maxPrice DECIMAL(6,3))
SELECT c.id, r.manufacturer, m.model, y.year, t.category, c.daily_rental_price, image, SUM(DATEDIFF(endDate, startDate)+1) 'total_days', SUM(c.daily_rental_price * (DATEDIFF(endDate, startDate)+1)) 'total_cost'
FROM cars c, models m, make_years y, car_categories t, manufacturers r, 
	customer_reservations cr, reservation_cars rc
WHERE c.manufacturer_id = r.id
AND r.id = manufacturer
AND c.model_id = m.id
AND m.id = model
AND c.make_year_id = y.id
AND y.id = year
AND c.category_id = t.id
AND t.id = category
AND cr.id = rc.reservation_id
AND c.id = rc.car_id
AND startDate NOT BETWEEN cr.start_date AND cr.end_date
AND endDate NOT BETWEEN cr.start_date AND cr.end_date
AND c.daily_rental_price BETWEEN minPrice AND maxPrice
GROUP BY c.id
LIMIT 10