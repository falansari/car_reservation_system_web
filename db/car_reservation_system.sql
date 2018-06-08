-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2018 at 11:44 AM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `car_reservation_system`
--
CREATE DATABASE IF NOT EXISTS `car_reservation_system` DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci;
USE `car_reservation_system`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `proc_available_car_categories_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_available_car_categories_list` (IN `manufacturer` SMALLINT(5))  IF (manufacturer != 0)
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
END IF$$

DROP PROCEDURE IF EXISTS `proc_cars_list_search`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cars_list_search` (IN `manufacturer` SMALLINT, IN `model` MEDIUMINT, IN `year` SMALLINT, IN `category` TINYINT, IN `startDate` DATE, IN `endDate` DATE, IN `minPrice` DECIMAL(6,3), IN `maxPrice` DECIMAL(6,3))  SELECT c.id, r.manufacturer, m.model, y.year, t.category, c.daily_rental_price, image, SUM(DATEDIFF(endDate, startDate)+1) 'total_days', SUM(c.daily_rental_price * (DATEDIFF(endDate, startDate)+1)) 'total_cost'
FROM cars c, models m, make_years y, car_categories t, manufacturers r, 
	customer_reservations cr, reservation_cars rc
WHERE c.manufacturer_id = r.id
AND r.id = manufacturer OR r.id = r.id
AND c.model_id = m.id
AND m.id = model OR m.id = m.id
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
LIMIT 10$$

DROP PROCEDURE IF EXISTS `proc_manufacturers_list_with_available_cars`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_manufacturers_list_with_available_cars` ()  SELECT manufacturers.id, manufacturers.manufacturer 
    FROM manufacturers, cars
    WHERE manufacturers.id = cars.manufacturer_id
    GROUP BY manufacturers.id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `accessories`
--
-- Creation: Jun 08, 2018 at 09:40 AM
--

DROP TABLE IF EXISTS `accessories`;
CREATE TABLE `accessories` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `accessory` varchar(20) COLLATE latin1_general_ci NOT NULL COMMENT 'e.g. child seat, GPS',
  `daily_rental_price` decimal(6,3) NOT NULL,
  `available_qty` int(11) NOT NULL,
  `reserved_qty` int(11) NOT NULL COMMENT 'quantities used in ongoing reservations',
  `total_qty` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `accessories`:
--

--
-- Truncate table before insert `accessories`
--

TRUNCATE TABLE `accessories`;
--
-- Dumping data for table `accessories`
--

INSERT INTO `accessories` (`id`, `accessory`, `daily_rental_price`, `available_qty`, `reserved_qty`, `total_qty`, `created_at`, `updated_at`) VALUES
(1, 'Infant Car Seat', '1.500', 10, 0, 10, CURRENT_TIMESTAMP, '2018-06-08 09:41:30'),
(2, 'Child Car Seat', '1.500', 10, 0, 10, CURRENT_TIMESTAMP, '2018-06-08 09:41:39'),
(3, 'Booster Car Seat', '1.500', 10, 0, 10, CURRENT_TIMESTAMP, '2018-06-08 09:41:48'),
(4, 'Screen', '1.000', 10, 0, 10, CURRENT_TIMESTAMP, '2018-06-08 09:42:05'),
(5, 'Car GPS System', '3.500', 10, 0, 10, CURRENT_TIMESTAMP, '2018-06-08 09:42:19'),
(6, 'Ski Racks', '4.500', 10, 0, 10, CURRENT_TIMESTAMP, '2018-06-08 09:42:54'),
(7, 'Snow Tires', '4.000', 40, 0, 40, CURRENT_TIMESTAMP, '2018-06-08 09:42:39'),
(8, 'Winter Tires', '4.000', 40, 0, 40, CURRENT_TIMESTAMP, '2018-06-08 09:42:46'),
(9, 'Summer Tires', '2.500', 40, 0, 40, CURRENT_TIMESTAMP, '2018-06-08 09:43:05'),
(10, 'All-Terrain Tires', '3.000', 40, 0, 40, CURRENT_TIMESTAMP, '2018-06-08 09:43:15'),
(11, 'Car Insurance', '2.000', 100, 0, 100, CURRENT_TIMESTAMP, '2018-06-08 09:43:27');

-- --------------------------------------------------------

--
-- Table structure for table `card_providers`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `card_providers`;
CREATE TABLE `card_providers` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `card_provider` varchar(30) COLLATE latin1_general_ci NOT NULL COMMENT 'e.g. Visa, MasterCard',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `card_providers`:
--

--
-- Truncate table before insert `card_providers`
--

TRUNCATE TABLE `card_providers`;
--
-- Dumping data for table `card_providers`
--

INSERT INTO `card_providers` (`id`, `card_provider`, `created_at`, `updated_at`) VALUES
(1, 'Visa', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(2, 'MasterCard', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(3, 'American Express', CURRENT_TIMESTAMP, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--
-- Creation: Jun 07, 2018 at 02:25 PM
--

DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `id` int(10) UNSIGNED NOT NULL,
  `manufacturer_id` smallint(5) UNSIGNED NOT NULL,
  `model_id` mediumint(8) UNSIGNED NOT NULL,
  `make_year_id` smallint(5) UNSIGNED NOT NULL,
  `category_id` tinyint(3) UNSIGNED NOT NULL,
  `daily_rental_price` decimal(6,3) NOT NULL,
  `image` blob,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `cars`:
--   `manufacturer_id`
--       `manufacturers` -> `id`
--   `model_id`
--       `models` -> `id`
--   `make_year_id`
--       `make_years` -> `id`
--   `category_id`
--       `car_categories` -> `id`
--

--
-- Truncate table before insert `cars`
--

TRUNCATE TABLE `cars`;
--
-- Dumping data for table `cars`
--

--
-- Triggers `cars`
--
DROP TRIGGER IF EXISTS `trig_delete_existing_car_total_reservations_count`;
DELIMITER $$
CREATE TRIGGER `trig_delete_existing_car_total_reservations_count` BEFORE DELETE ON `cars` FOR EACH ROW IF EXISTS (SELECT car_id FROM `most_popular_cars_report` WHERE `most_popular_cars_report`.`car_id` = OLD.id) THEN
 DELETE FROM `most_popular_cars_report` WHERE `most_popular_cars_report`.`car_id` = OLD.id;
 END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `car_categories`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `car_categories`;
CREATE TABLE `car_categories` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `category` char(20) COLLATE latin1_general_ci NOT NULL COMMENT 'e.g. SUV, Sedan, Hatchback',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `car_categories`:
--

--
-- Truncate table before insert `car_categories`
--

TRUNCATE TABLE `car_categories`;
--
-- Dumping data for table `car_categories`
--

INSERT INTO `car_categories` (`id`, `category`, `created_at`, `updated_at`) VALUES
(1, 'Hatchback', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(2, 'Sedan Subcompact', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(3, 'Sedan Compact', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(4, 'Sedan Mid-size', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(5, 'Sedan Large', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(6, 'MPV', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(7, 'SUV', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(8, 'Crossover', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(9, 'Coupe', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(10, 'Convertible', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(11, 'Minivan', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(12, 'Van', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(13, 'Pickup Truck', CURRENT_TIMESTAMP, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `country_code` char(2) COLLATE latin1_general_ci NOT NULL,
  `country_name_en` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `country_nationality_en` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `country_name_ar` varchar(50) CHARACTER SET utf8 NOT NULL,
  `country_nationality_ar` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `countries`:
--

--
-- Truncate table before insert `countries`
--

TRUNCATE TABLE `countries`;
--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `country_code`, `country_name_en`, `country_nationality_en`, `country_name_ar`, `country_nationality_ar`, `created_at`, `updated_at`) VALUES
(1, 'AF', 'Afghanistan', 'Afghan', 'أفغانستان', 'أفغانستاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(2, 'AL', 'Albania', 'Albanian', 'ألبانيا', 'ألباني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(3, 'AX', 'Aland Islands', 'Aland Islander', 'جزر آلاند', 'آلاندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(4, 'DZ', 'Algeria', 'Algerian', 'الجزائر', 'جزائري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(5, 'AS', 'American Samoa', 'American Samoan', 'ساموا-الأمريكي', 'أمريكي سامواني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(6, 'AD', 'Andorra', 'Andorran', 'أندورا', 'أندوري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(7, 'AO', 'Angola', 'Angolan', 'أنغولا', 'أنقولي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(8, 'AI', 'Anguilla', 'Anguillan', 'أنغويلا', 'أنغويلي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(9, 'AQ', 'Antarctica', 'Antarctican', 'أنتاركتيكا', 'أنتاركتيكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(10, 'AG', 'Antigua and Barbuda', 'Antiguan', 'أنتيغوا وبربودا', 'بربودي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(11, 'AR', 'Argentina', 'Argentinian', 'الأرجنتين', 'أرجنتيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(12, 'AM', 'Armenia', 'Armenian', 'أرمينيا', 'أرميني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(13, 'AW', 'Aruba', 'Aruban', 'أروبه', 'أوروبهيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(14, 'AU', 'Australia', 'Australian', 'أستراليا', 'أسترالي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(15, 'AT', 'Austria', 'Austrian', 'النمسا', 'نمساوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(16, 'AZ', 'Azerbaijan', 'Azerbaijani', 'أذربيجان', 'أذربيجاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(17, 'BS', 'Bahamas', 'Bahamian', 'الباهاماس', 'باهاميسي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(18, 'BH', 'Bahrain', 'Bahraini', 'البحرين', 'بحريني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(19, 'BD', 'Bangladesh', 'Bangladeshi', 'بنغلاديش', 'بنغلاديشي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(20, 'BB', 'Barbados', 'Barbadian', 'بربادوس', 'بربادوسي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(21, 'BY', 'Belarus', 'Belarusian', 'روسيا البيضاء', 'روسي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(22, 'BE', 'Belgium', 'Belgian', 'بلجيكا', 'بلجيكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(23, 'BZ', 'Belize', 'Belizean', 'بيليز', 'بيليزي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(24, 'BJ', 'Benin', 'Beninese', 'بنين', 'بنيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(25, 'BL', 'Saint Barthelemy', 'Saint Barthelmian', 'سان بارتيلمي', 'سان بارتيلمي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(26, 'BM', 'Bermuda', 'Bermudan', 'جزر برمودا', 'برمودي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(27, 'BT', 'Bhutan', 'Bhutanese', 'بوتان', 'بوتاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(28, 'BO', 'Bolivia', 'Bolivian', 'بوليفيا', 'بوليفي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(29, 'BA', 'Bosnia and Herzegovina', 'Bosnian / Herzegovinian', 'البوسنة و الهرسك', 'بوسني/هرسكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(30, 'BW', 'Botswana', 'Botswanan', 'بوتسوانا', 'بوتسواني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(31, 'BV', 'Bouvet Island', 'Bouvetian', 'جزيرة بوفيه', 'بوفيهي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(32, 'BR', 'Brazil', 'Brazilian', 'البرازيل', 'برازيلي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(33, 'IO', 'British Indian Ocean Territory', 'British Indian Ocean Territory', 'إقليم المحيط الهندي البريطاني', 'إقليم المحيط الهندي البريطاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(34, 'BN', 'Brunei Darussalam', 'Bruneian', 'بروني', 'بروني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(35, 'BG', 'Bulgaria', 'Bulgarian', 'بلغاريا', 'بلغاري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(36, 'BF', 'Burkina Faso', 'Burkinabe', 'بوركينا فاسو', 'بوركيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(37, 'BI', 'Burundi', 'Burundian', 'بوروندي', 'بورونيدي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(38, 'KH', 'Cambodia', 'Cambodian', 'كمبوديا', 'كمبودي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(39, 'CM', 'Cameroon', 'Cameroonian', 'كاميرون', 'كاميروني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(40, 'CA', 'Canada', 'Canadian', 'كندا', 'كندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(41, 'CV', 'Cape Verde', 'Cape Verdean', 'الرأس الأخضر', 'الرأس الأخضر', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(42, 'KY', 'Cayman Islands', 'Caymanian', 'جزر كايمان', 'كايماني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(43, 'CF', 'Central African Republic', 'Central African', 'جمهورية أفريقيا الوسطى', 'أفريقي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(44, 'TD', 'Chad', 'Chadian', 'تشاد', 'تشادي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(45, 'CL', 'Chile', 'Chilean', 'شيلي', 'شيلي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(46, 'CN', 'China', 'Chinese', 'الصين', 'صيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(47, 'CX', 'Christmas Island', 'Christmas Islander', 'جزيرة عيد الميلاد', 'جزيرة عيد الميلاد', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(48, 'CC', 'Cocos (Keeling) Islands', 'Cocos Islander', 'جزر كوكوس', 'جزر كوكوس', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(49, 'CO', 'Colombia', 'Colombian', 'كولومبيا', 'كولومبي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(50, 'KM', 'Comoros', 'Comorian', 'جزر القمر', 'جزر القمر', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(51, 'CG', 'Congo', 'Congolese', 'الكونغو', 'كونغي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(52, 'CK', 'Cook Islands', 'Cook Islander', 'جزر كوك', 'جزر كوك', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(53, 'CR', 'Costa Rica', 'Costa Rican', 'كوستاريكا', 'كوستاريكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(54, 'HR', 'Croatia', 'Croatian', 'كرواتيا', 'كوراتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(55, 'CU', 'Cuba', 'Cuban', 'كوبا', 'كوبي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(56, 'CY', 'Cyprus', 'Cypriot', 'قبرص', 'قبرصي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(57, 'CW', 'Curaçao', 'Curacian', 'كوراساو', 'كوراساوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(58, 'CZ', 'Czech Republic', 'Czech', 'الجمهورية التشيكية', 'تشيكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(59, 'DK', 'Denmark', 'Danish', 'الدانمارك', 'دنماركي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(60, 'DJ', 'Djibouti', 'Djiboutian', 'جيبوتي', 'جيبوتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(61, 'DM', 'Dominica', 'Dominican', 'دومينيكا', 'دومينيكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(62, 'DO', 'Dominican Republic', 'Dominican', 'الجمهورية الدومينيكية', 'دومينيكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(63, 'EC', 'Ecuador', 'Ecuadorian', 'إكوادور', 'إكوادوري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(64, 'EG', 'Egypt', 'Egyptian', 'مصر', 'مصري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(65, 'SV', 'El Salvador', 'Salvadoran', 'إلسلفادور', 'سلفادوري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(66, 'GQ', 'Equatorial Guinea', 'Equatorial Guinean', 'غينيا الاستوائي', 'غيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(67, 'ER', 'Eritrea', 'Eritrean', 'إريتريا', 'إريتيري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(68, 'EE', 'Estonia', 'Estonian', 'استونيا', 'استوني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(69, 'ET', 'Ethiopia', 'Ethiopian', 'أثيوبيا', 'أثيوبي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(70, 'FK', 'Falkland Islands (Malvinas)', 'Falkland Islander', 'جزر فوكلاند', 'فوكلاندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(71, 'FO', 'Faroe Islands', 'Faroese', 'جزر فارو', 'جزر فارو', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(72, 'FJ', 'Fiji', 'Fijian', 'فيجي', 'فيجي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(73, 'FI', 'Finland', 'Finnish', 'فنلندا', 'فنلندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(74, 'FR', 'France', 'French', 'فرنسا', 'فرنسي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(75, 'GF', 'French Guiana', 'French Guianese', 'غويانا الفرنسية', 'غويانا الفرنسية', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(76, 'PF', 'French Polynesia', 'French Polynesian', 'بولينيزيا الفرنسية', 'بولينيزيي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(77, 'TF', 'French Southern and Antarctic Lands', 'French', 'أراض فرنسية جنوبية وأنتارتيكية', 'أراض فرنسية جنوبية وأنتارتيكية', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(78, 'GA', 'Gabon', 'Gabonese', 'الغابون', 'غابوني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(79, 'GM', 'Gambia', 'Gambian', 'غامبيا', 'غامبي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(80, 'GE', 'Georgia', 'Georgian', 'جيورجيا', 'جيورجي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(81, 'DE', 'Germany', 'German', 'ألمانيا', 'ألماني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(82, 'GH', 'Ghana', 'Ghanaian', 'غانا', 'غاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(83, 'GI', 'Gibraltar', 'Gibraltar', 'جبل طارق', 'جبل طارق', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(84, 'GG', 'Guernsey', 'Guernsian', 'غيرنزي', 'غيرنزي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(85, 'GR', 'Greece', 'Greek', 'اليونان', 'يوناني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(86, 'GL', 'Greenland', 'Greenlandic', 'جرينلاند', 'جرينلاندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(87, 'GD', 'Grenada', 'Grenadian', 'غرينادا', 'غرينادي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(88, 'GP', 'Guadeloupe', 'Guadeloupe', 'جزر جوادلوب', 'جزر جوادلوب', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(89, 'GU', 'Guam', 'Guamanian', 'جوام', 'جوامي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(90, 'GT', 'Guatemala', 'Guatemalan', 'غواتيمال', 'غواتيمالي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(91, 'GN', 'Guinea', 'Guinean', 'غينيا', 'غيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(92, 'GW', 'Guinea-Bissau', 'Guinea-Bissauan', 'غينيا-بيساو', 'غيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(93, 'GY', 'Guyana', 'Guyanese', 'غيانا', 'غياني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(94, 'HT', 'Haiti', 'Haitian', 'هايتي', 'هايتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(95, 'HM', 'Heard and Mc Donald Islands', 'Heard and Mc Donald Islanders', 'جزيرة هيرد وجزر ماكدونالد', 'جزيرة هيرد وجزر ماكدونالد', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(96, 'HN', 'Honduras', 'Honduran', 'هندوراس', 'هندوراسي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(97, 'HK', 'Hong Kong', 'Hongkongese', 'هونغ كونغ', 'هونغ كونغي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(98, 'HU', 'Hungary', 'Hungarian', 'المجر', 'مجري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(99, 'IS', 'Iceland', 'Icelandic', 'آيسلندا', 'آيسلندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(100, 'IN', 'India', 'Indian', 'الهند', 'هندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(101, 'IM', 'Isle of Man', 'Manx', 'جزيرة مان', 'ماني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(102, 'ID', 'Indonesia', 'Indonesian', 'أندونيسيا', 'أندونيسيي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(103, 'IR', 'Iran', 'Iranian', 'إيران', 'إيراني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(104, 'IQ', 'Iraq', 'Iraqi', 'العراق', 'عراقي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(105, 'IE', 'Ireland', 'Irish', 'إيرلندا', 'إيرلندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(106, 'IL', 'Israel', 'Israeli', 'إسرائيل', 'إسرائيلي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(107, 'IT', 'Italy', 'Italian', 'إيطاليا', 'إيطالي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(108, 'CI', 'Ivory Coast', 'Ivory Coastian', 'ساحل العاج', 'ساحل العاج', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(109, 'JE', 'Jersey', 'Jersian', 'جيرزي', 'جيرزي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(110, 'JM', 'Jamaica', 'Jamaican', 'جمايكا', 'جمايكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(111, 'JP', 'Japan', 'Japanese', 'اليابان', 'ياباني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(112, 'JO', 'Jordan', 'Jordanian', 'الأردن', 'أردني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(113, 'KZ', 'Kazakhstan', 'Kazakh', 'كازاخستان', 'كازاخستاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(114, 'KE', 'Kenya', 'Kenyan', 'كينيا', 'كيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(115, 'KI', 'Kiribati', 'I-Kiribati', 'كيريباتي', 'كيريباتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(116, 'KP', 'Korea(North Korea)', 'North Korean', 'كوريا الشمالية', 'كوري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(117, 'KR', 'Korea(South Korea)', 'South Korean', 'كوريا الجنوبية', 'كوري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(118, 'XK', 'Kosovo', 'Kosovar', 'كوسوفو', 'كوسيفي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(119, 'KW', 'Kuwait', 'Kuwaiti', 'الكويت', 'كويتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(120, 'KG', 'Kyrgyzstan', 'Kyrgyzstani', 'قيرغيزستان', 'قيرغيزستاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(121, 'LA', 'Lao PDR', 'Laotian', 'لاوس', 'لاوسي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(122, 'LV', 'Latvia', 'Latvian', 'لاتفيا', 'لاتيفي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(123, 'LB', 'Lebanon', 'Lebanese', 'لبنان', 'لبناني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(124, 'LS', 'Lesotho', 'Basotho', 'ليسوتو', 'ليوسيتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(125, 'LR', 'Liberia', 'Liberian', 'ليبيريا', 'ليبيري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(126, 'LY', 'Libya', 'Libyan', 'ليبيا', 'ليبي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(127, 'LI', 'Liechtenstein', 'Liechtenstein', 'ليختنشتين', 'ليختنشتيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(128, 'LT', 'Lithuania', 'Lithuanian', 'لتوانيا', 'لتوانيي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(129, 'LU', 'Luxembourg', 'Luxembourger', 'لوكسمبورغ', 'لوكسمبورغي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(130, 'LK', 'Sri Lanka', 'Sri Lankian', 'سريلانكا', 'سريلانكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(131, 'MO', 'Macau', 'Macanese', 'ماكاو', 'ماكاوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(132, 'MK', 'Macedonia', 'Macedonian', 'مقدونيا', 'مقدوني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(133, 'MG', 'Madagascar', 'Malagasy', 'مدغشقر', 'مدغشقري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(134, 'MW', 'Malawi', 'Malawian', 'مالاوي', 'مالاوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(135, 'MY', 'Malaysia', 'Malaysian', 'ماليزيا', 'ماليزي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(136, 'MV', 'Maldives', 'Maldivian', 'المالديف', 'مالديفي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(137, 'ML', 'Mali', 'Malian', 'مالي', 'مالي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(138, 'MT', 'Malta', 'Maltese', 'مالطا', 'مالطي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(139, 'MH', 'Marshall Islands', 'Marshallese', 'جزر مارشال', 'مارشالي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(140, 'MQ', 'Martinique', 'Martiniquais', 'مارتينيك', 'مارتينيكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(141, 'MR', 'Mauritania', 'Mauritanian', 'موريتانيا', 'موريتانيي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(142, 'MU', 'Mauritius', 'Mauritian', 'موريشيوس', 'موريشيوسي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(143, 'YT', 'Mayotte', 'Mahoran', 'مايوت', 'مايوتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(144, 'MX', 'Mexico', 'Mexican', 'المكسيك', 'مكسيكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(145, 'FM', 'Micronesia', 'Micronesian', 'مايكرونيزيا', 'مايكرونيزيي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(146, 'MD', 'Moldova', 'Moldovan', 'مولدافيا', 'مولديفي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(147, 'MC', 'Monaco', 'Monacan', 'موناكو', 'مونيكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(148, 'MN', 'Mongolia', 'Mongolian', 'منغوليا', 'منغولي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(149, 'ME', 'Montenegro', 'Montenegrin', 'الجبل الأسود', 'الجبل الأسود', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(150, 'MS', 'Montserrat', 'Montserratian', 'مونتسيرات', 'مونتسيراتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(151, 'MA', 'Morocco', 'Moroccan', 'المغرب', 'مغربي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(152, 'MZ', 'Mozambique', 'Mozambican', 'موزمبيق', 'موزمبيقي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(153, 'MM', 'Myanmar', 'Myanmarian', 'ميانمار', 'ميانماري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(154, 'NA', 'Namibia', 'Namibian', 'ناميبيا', 'ناميبي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(155, 'NR', 'Nauru', 'Nauruan', 'نورو', 'نوري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(156, 'NP', 'Nepal', 'Nepalese', 'نيبال', 'نيبالي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(157, 'NL', 'Netherlands', 'Dutch', 'هولندا', 'هولندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(158, 'AN', 'Netherlands Antilles', 'Dutch Antilier', 'جزر الأنتيل الهولندي', 'هولندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(159, 'NC', 'New Caledonia', 'New Caledonian', 'كاليدونيا الجديدة', 'كاليدوني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(160, 'NZ', 'New Zealand', 'New Zealander', 'نيوزيلندا', 'نيوزيلندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(161, 'NI', 'Nicaragua', 'Nicaraguan', 'نيكاراجوا', 'نيكاراجوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(162, 'NE', 'Niger', 'Nigerien', 'النيجر', 'نيجيري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(163, 'NG', 'Nigeria', 'Nigerian', 'نيجيريا', 'نيجيري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(164, 'NU', 'Niue', 'Niuean', 'ني', 'ني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(165, 'NF', 'Norfolk Island', 'Norfolk Islander', 'جزيرة نورفولك', 'نورفوليكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(166, 'MP', 'Northern Mariana Islands', 'Northern Marianan', 'جزر ماريانا الشمالية', 'ماريني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(167, 'NO', 'Norway', 'Norwegian', 'النرويج', 'نرويجي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(168, 'OM', 'Oman', 'Omani', 'عمان', 'عماني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(169, 'PK', 'Pakistan', 'Pakistani', 'باكستان', 'باكستاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(170, 'PW', 'Palau', 'Palauan', 'بالاو', 'بالاوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(171, 'PS', 'Palestine', 'Palestinian', 'فلسطين', 'فلسطيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(172, 'PA', 'Panama', 'Panamanian', 'بنما', 'بنمي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(173, 'PG', 'Papua New Guinea', 'Papua New Guinean', 'بابوا غينيا الجديدة', 'بابوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(174, 'PY', 'Paraguay', 'Paraguayan', 'باراغواي', 'بارغاوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(175, 'PE', 'Peru', 'Peruvian', 'بيرو', 'بيري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(176, 'PH', 'Philippines', 'Filipino', 'الفليبين', 'فلبيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(177, 'PN', 'Pitcairn', 'Pitcairn Islander', 'بيتكيرن', 'بيتكيرني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(178, 'PL', 'Poland', 'Polish', 'بولونيا', 'بوليني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(179, 'PT', 'Portugal', 'Portuguese', 'البرتغال', 'برتغالي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(180, 'PR', 'Puerto Rico', 'Puerto Rican', 'بورتو ريكو', 'بورتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(181, 'QA', 'Qatar', 'Qatari', 'قطر', 'قطري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(182, 'RE', 'Reunion Island', 'Reunionese', 'ريونيون', 'ريونيوني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(183, 'RO', 'Romania', 'Romanian', 'رومانيا', 'روماني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(184, 'RU', 'Russian', 'Russian', 'روسيا', 'روسي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(185, 'RW', 'Rwanda', 'Rwandan', 'رواندا', 'رواندا', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(186, 'KN', 'Saint Kitts and Nevis', 'Kittitian/Nevisian', 'سانت كيتس ونيفس,', 'سانت كيتس ونيفس', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(187, 'MF', 'Saint Martin (French part)', 'St. Martian(French)', 'ساينت مارتن فرنسي', 'ساينت مارتني فرنسي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(188, 'SX', 'Sint Maarten (Dutch part)', 'St. Martian(Dutch)', 'ساينت مارتن هولندي', 'ساينت مارتني هولندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(189, 'LC', 'Saint Pierre and Miquelon', 'St. Pierre and Miquelon', 'سان بيير وميكلون', 'سان بيير وميكلوني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(190, 'VC', 'Saint Vincent and the Grenadines', 'Saint Vincent and the Grenadines', 'سانت فنسنت وجزر غرينادين', 'سانت فنسنت وجزر غرينادين', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(191, 'WS', 'Samoa', 'Samoan', 'ساموا', 'ساموي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(192, 'SM', 'San Marino', 'Sammarinese', 'سان مارينو', 'ماريني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(193, 'ST', 'Sao Tome and Principe', 'Sao Tomean', 'ساو تومي وبرينسيبي', 'ساو تومي وبرينسيبي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(194, 'SA', 'Saudi Arabia', 'Saudi Arabian', 'المملكة العربية السعودية', 'سعودي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(195, 'SN', 'Senegal', 'Senegalese', 'السنغال', 'سنغالي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(196, 'RS', 'Serbia', 'Serbian', 'صربيا', 'صربي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(197, 'SC', 'Seychelles', 'Seychellois', 'سيشيل', 'سيشيلي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(198, 'SL', 'Sierra Leone', 'Sierra Leonean', 'سيراليون', 'سيراليوني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(199, 'SG', 'Singapore', 'Singaporean', 'سنغافورة', 'سنغافوري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(200, 'SK', 'Slovakia', 'Slovak', 'سلوفاكيا', 'سولفاكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(201, 'SI', 'Slovenia', 'Slovenian', 'سلوفينيا', 'سولفيني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(202, 'SB', 'Solomon Islands', 'Solomon Island', 'جزر سليمان', 'جزر سليمان', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(203, 'SO', 'Somalia', 'Somali', 'الصومال', 'صومالي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(204, 'ZA', 'South Africa', 'South African', 'جنوب أفريقيا', 'أفريقي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(205, 'GS', 'South Georgia and the South Sandwich', 'South Georgia and the South Sandwich', 'المنطقة القطبية الجنوبية', 'لمنطقة القطبية الجنوبية', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(206, 'SS', 'South Sudan', 'South Sudanese', 'السودان الجنوبي', 'سوادني جنوبي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(207, 'ES', 'Spain', 'Spanish', 'إسبانيا', 'إسباني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(208, 'SH', 'Saint Helena', 'St. Helenian', 'سانت هيلانة', 'هيلاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(209, 'SD', 'Sudan', 'Sudanese', 'السودان', 'سوداني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(210, 'SR', 'Suriname', 'Surinamese', 'سورينام', 'سورينامي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(211, 'SJ', 'Svalbard and Jan Mayen', 'Svalbardian/Jan Mayenian', 'سفالبارد ويان ماين', 'سفالبارد ويان ماين', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(212, 'SZ', 'Swaziland', 'Swazi', 'سوازيلند', 'سوازيلندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(213, 'SE', 'Sweden', 'Swedish', 'السويد', 'سويدي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(214, 'CH', 'Switzerland', 'Swiss', 'سويسرا', 'سويسري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(215, 'SY', 'Syria', 'Syrian', 'سوريا', 'سوري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(216, 'TW', 'Taiwan', 'Taiwanese', 'تايوان', 'تايواني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(217, 'TJ', 'Tajikistan', 'Tajikistani', 'طاجيكستان', 'طاجيكستاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(218, 'TZ', 'Tanzania', 'Tanzanian', 'تنزانيا', 'تنزانيي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(219, 'TH', 'Thailand', 'Thai', 'تايلندا', 'تايلندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(220, 'TL', 'Timor-Leste', 'Timor-Lestian', 'تيمور الشرقية', 'تيموري', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(221, 'TG', 'Togo', 'Togolese', 'توغو', 'توغي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(222, 'TK', 'Tokelau', 'Tokelaian', 'توكيلاو', 'توكيلاوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(223, 'TO', 'Tonga', 'Tongan', 'تونغا', 'تونغي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(224, 'TT', 'Trinidad and Tobago', 'Trinidadian/Tobagonian', 'ترينيداد وتوباغو', 'ترينيداد وتوباغو', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(225, 'TN', 'Tunisia', 'Tunisian', 'تونس', 'تونسي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(226, 'TR', 'Turkey', 'Turkish', 'تركيا', 'تركي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(227, 'TM', 'Turkmenistan', 'Turkmen', 'تركمانستان', 'تركمانستاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(228, 'TC', 'Turks and Caicos Islands', 'Turks and Caicos Islands', 'جزر توركس وكايكوس', 'جزر توركس وكايكوس', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(229, 'TV', 'Tuvalu', 'Tuvaluan', 'توفالو', 'توفالي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(230, 'UG', 'Uganda', 'Ugandan', 'أوغندا', 'أوغندي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(231, 'UA', 'Ukraine', 'Ukrainian', 'أوكرانيا', 'أوكراني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(232, 'AE', 'United Arab Emirates', 'Emirati', 'الإمارات العربية المتحدة', 'إماراتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(233, 'GB', 'United Kingdom', 'British', 'المملكة المتحدة', 'بريطاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(234, 'US', 'United States', 'American', 'الولايات المتحدة', 'أمريكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(235, 'UM', 'US Minor Outlying Islands', 'US Minor Outlying Islander', 'قائمة الولايات والمناطق الأمريكية', 'أمريكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(236, 'UY', 'Uruguay', 'Uruguayan', 'أورغواي', 'أورغواي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(237, 'UZ', 'Uzbekistan', 'Uzbek', 'أوزباكستان', 'أوزباكستاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(238, 'VU', 'Vanuatu', 'Vanuatuan', 'فانواتو', 'فانواتي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(239, 'VE', 'Venezuela', 'Venezuelan', 'فنزويلا', 'فنزويلي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(240, 'VN', 'Vietnam', 'Vietnamese', 'فيتنام', 'فيتنامي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(241, 'VI', 'Virgin Islands (U.S.)', 'American Virgin Islander', 'الجزر العذراء الأمريكي', 'أمريكي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(242, 'VA', 'Vatican City', 'Vatican', 'فنزويلا', 'فاتيكاني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(243, 'WF', 'Wallis and Futuna Islands', 'Wallisian/Futunan', 'والس وفوتونا', 'فوتوني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(244, 'EH', 'Western Sahara', 'Sahrawian', 'الصحراء الغربية', 'صحراوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(245, 'YE', 'Yemen', 'Yemeni', 'اليمن', 'يمني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(246, 'ZM', 'Zambia', 'Zambian', 'زامبيا', 'زامبياني', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(247, 'ZW', 'Zimbabwe', 'Zimbabwean', 'زمبابوي', 'زمبابوي', CURRENT_TIMESTAMP, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `make_years`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `make_years`;
CREATE TABLE `make_years` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `year` year(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `make_years`:
--

--
-- Truncate table before insert `make_years`
--

TRUNCATE TABLE `make_years`;
--
-- Dumping data for table `make_years`
--

INSERT INTO `make_years` (`id`, `year`, `created_at`, `updated_at`) VALUES
(1, 1990, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(2, 1991, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(3, 1992, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(4, 1993, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(5, 1994, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(6, 1995, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(7, 1996, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(8, 1997, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(9, 1998, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(10, 1999, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(11, 2000, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(12, 2001, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(13, 2002, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(14, 2003, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(15, 2004, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(16, 2005, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(17, 2006, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(18, 2007, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(19, 2008, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(20, 2009, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(21, 2010, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(22, 2011, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(23, 2012, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(24, 2013, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(25, 2014, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(26, 2015, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(27, 2016, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(28, 2017, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(29, 2018, CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(30, 2019, CURRENT_TIMESTAMP, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `manufacturers`;
CREATE TABLE `manufacturers` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `manufacturer` varchar(30) COLLATE latin1_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `manufacturers`:
--

--
-- Truncate table before insert `manufacturers`
--

TRUNCATE TABLE `manufacturers`;
--
-- Dumping data for table `manufacturers`
--

INSERT INTO `manufacturers` (`id`, `manufacturer`, `created_at`, `updated_at`) VALUES
(1, 'Acura', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(2, 'Alfa Romeo', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(3, 'Aston Martin', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(4, 'Audi', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(5, 'Bentley', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(6, 'BMW', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(7, 'Bugatti', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(8, 'Buick', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(9, 'Cadillac', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(10, 'Chevrolet', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(11, 'Chrysler', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(12, 'Dodge', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(13, 'Ford', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(14, 'GMC', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(15, 'Honda', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(16, 'Hyundai', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(17, 'Infiniti', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(18, 'Jeep', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(19, 'Kia', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(20, 'Lexus', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(21, 'Mazda', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(22, 'Mercedes-Benz', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(23, 'Mitsubishi', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(24, 'Porsche', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(25, 'Nissan', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(26, 'Subaru', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(27, 'Tesla', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(28, 'Toyota', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(29, 'Volkswagen', CURRENT_TIMESTAMP, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `models`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `models`;
CREATE TABLE `models` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `model` varchar(30) COLLATE latin1_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `models`:
--

--
-- Truncate table before insert `models`
--

TRUNCATE TABLE `models`;
--
-- Dumping data for table `models`
--

INSERT INTO `models` (`id`, `model`, `created_at`, `updated_at`) VALUES
(1, 'Chevy Sonic', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(2, 'Ford Fiesta', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(3, 'Honda Fit', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(4, 'Hyundai Accent', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(5, 'Kia Rio', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(6, 'Mazda2', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(7, 'Mitsubishi Mirage', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(8, 'Nissan Versa', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(9, 'Toyota Yaris', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(10, 'Alpha Romeo C4', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(11, 'Ford Focus', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(12, 'Honda Civic', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(13, 'Hyundai Elantra', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(14, 'Mazda3', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(15, 'Mitsubishi Lancer', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(16, 'Subaru Impreza', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(17, 'Volkswagen Golf', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(18, 'Volkswagen Beetle', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(19, 'Chevy Malibu', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(20, 'Ford Fusion', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(21, 'Honda Accord', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(22, 'Hyundai Sonata', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(23, 'Kia Optima', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(24, 'Mazda6', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(25, 'Nissan Altima', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(26, 'Toyota Camry', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(27, 'Ford Taurus', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(28, 'Chevy Impala', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(29, 'Nissan Maxima', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(30, 'Toyota Avalon', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(31, 'Nissan Juke', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(32, 'Honda HR-V', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(33, 'Honda CR-V', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(34, 'Hyundai Tucson', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(35, 'Mazda CX-3', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(36, 'Jeep Patriot', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(37, 'Subaru Forester', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(38, 'Toyota RAV4', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(39, 'GMC Acadia', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(40, 'Dodge Tourney', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(41, 'Honda Pilot', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(42, 'Hyundai Santa Fe', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(43, 'Jeep Cherokee', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(44, 'Nissan Pathfinder', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(45, 'Dodge Grand Caravan', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(46, 'Honda Odyssey', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(47, 'Mazda5', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(48, 'Nissan Quest', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(49, 'Jeep Wrangler', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(50, 'Kia Sportage', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(51, 'Kia Sorento', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(52, 'Toyota Land Cruiser', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(53, 'Nissan Armada', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(54, 'Audi A4', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(55, 'Acura ILX', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(56, 'BMW 2 Series', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(57, 'BMW 3 Series', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(58, 'BMW 4 Series', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(59, 'Cadillac ATS', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(60, 'Infiniti Q50', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(61, 'Lexus IS', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(62, 'Mercedes-Benz C-Class', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(63, 'Audi A6', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(64, 'BMW 5 Series', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(65, 'Chrysler 200', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(66, 'Lexus GS', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(67, 'Audi A8', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(68, 'Lexus LS', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(69, 'Audi Q-Series', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(70, 'BMW X Series', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(71, 'Chevy Spark', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(72, 'Toyota Prius', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(73, 'Nissan Leaf', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(74, 'BMW i3', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(75, 'Audi R8', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(76, 'BMW M Series', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(77, 'Chevy Camaro', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(78, 'Chevy Corvette', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(79, 'Dodge Challenger', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(80, 'Dodge Charger', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(81, 'Ford Mustang', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(82, 'Nissan Z', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(83, 'Porsche 911', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(84, 'Chevy Colorado', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(85, 'Nissan Frontier', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(86, 'Toyota Tacoma', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(87, 'Chevy Silverado', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(88, 'GMC Sierra', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(89, 'Nissan Titan', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(90, 'Ford Transit', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(91, 'Aston Martin DB11', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(92, 'Bentley Mulsane', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(93, 'Bugatti Veyron', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(94, 'Tesla Model 3', CURRENT_TIMESTAMP, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `most_popular_cars_report`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `most_popular_cars_report`;
CREATE TABLE `most_popular_cars_report` (
  `id` int(10) UNSIGNED NOT NULL,
  `car_id` int(10) UNSIGNED NOT NULL,
  `reservations_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `most_popular_cars_report`:
--   `car_id`
--       `cars` -> `id`
--

--
-- Truncate table before insert `most_popular_cars_report`
--

TRUNCATE TABLE `most_popular_cars_report`;
--
-- Dumping data for table `most_popular_cars_report`
--


-- --------------------------------------------------------

--
-- Table structure for table `payment_types`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `payment_types`;
CREATE TABLE `payment_types` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `payment_type` char(4) COLLATE latin1_general_ci NOT NULL COMMENT 'Types:Cash, card',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `payment_types`:
--

--
-- Truncate table before insert `payment_types`
--

TRUNCATE TABLE `payment_types`;
--
-- Dumping data for table `payment_types`
--

INSERT INTO `payment_types` (`id`, `payment_type`, `created_at`, `updated_at`) VALUES
(1, 'Cash', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(2, 'Card', CURRENT_TIMESTAMP, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE `reservations` (
  `id` int(10) UNSIGNED ZEROFILL NOT NULL,
  `payment_type_id` tinyint(3) UNSIGNED NOT NULL,
  `country_id` smallint(5) UNSIGNED NOT NULL,
  `card_provider_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_rental_cost` decimal(8,3) NOT NULL,
  `address` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `CPR` int(10) UNSIGNED NOT NULL,
  `phone_no` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `card_number` char(60) COLLATE latin1_general_ci DEFAULT NULL,
  `card_expiry_date` date DEFAULT NULL,
  `card_security_digits` char(60) COLLATE latin1_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `reservations`:
--   `card_provider_id`
--       `card_providers` -> `id`
--   `country_id`
--       `countries` -> `id`
--   `payment_type_id`
--       `payment_types` -> `id`
--

--
-- Truncate table before insert `reservations`
--

TRUNCATE TABLE `reservations`;
--
-- Dumping data for table `reservations`
--

--
-- Triggers `reservations`
--
DROP TRIGGER IF EXISTS `trig_add_new_sale`;
DELIMITER $$
CREATE TRIGGER `trig_add_new_sale` AFTER INSERT ON `reservations` FOR EACH ROW INSERT INTO `sales_revenue_report`(transaction_id, transaction_date, transaction_amount) VALUES
 (
     (SELECT id FROM `reservations` WHERE id = NEW.id),
     (SELECT DATE(created_at) FROM `reservations` WHERE id = NEW.id),
     (SELECT total_rental_cost FROM `reservations` WHERE id = NEW.id)
 )
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trig_delete_cancelled_sale`;
DELIMITER $$
CREATE TRIGGER `trig_delete_cancelled_sale` BEFORE DELETE ON `reservations` FOR EACH ROW BEGIN
	DELETE FROM `reservation_cars` WHERE `reservation_cars`.`reservation_id` = OLD.id;
    DELETE FROM `sales_revenue_report` WHERE `sales_revenue_report`.`transaction_id` = OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reservation_accessories`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `reservation_accessories`;
CREATE TABLE `reservation_accessories` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `accessory_id` smallint(5) UNSIGNED NOT NULL,
  `reservation_id` int(10) UNSIGNED NOT NULL,
  `reserve_qty` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `reservation_accessories`:
--   `accessory_id`
--       `accessories` -> `id`
--   `reservation_id`
--       `reservations` -> `id`
--

--
-- Truncate table before insert `reservation_accessories`
--

TRUNCATE TABLE `reservation_accessories`;
-- --------------------------------------------------------

--
-- Table structure for table `reservation_cars`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `reservation_cars`;
CREATE TABLE `reservation_cars` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `reservation_id` int(10) UNSIGNED NOT NULL,
  `car_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `reservation_cars`:
--   `reservation_id`
--       `reservations` -> `id`
--   `car_id`
--       `cars` -> `id`
--

--
-- Truncate table before insert `reservation_cars`
--

TRUNCATE TABLE `reservation_cars`;
--
-- Dumping data for table `reservation_cars`
--

--
-- Triggers `reservation_cars`
--
DROP TRIGGER IF EXISTS `trig_add_new_car_total_reservations_count`;
DELIMITER $$
CREATE TRIGGER `trig_add_new_car_total_reservations_count` AFTER INSERT ON `reservation_cars` FOR EACH ROW IF NOT EXISTS (SELECT car_id FROM `most_popular_cars_report` WHERE `most_popular_cars_report`.`car_id` = NEW.car_id) THEN
 INSERT INTO `most_popular_cars_report`(car_id, reservations_count) VALUES
(
    (NEW.car_id),
    (SELECT count(car_id) 
     FROM `reservation_cars`
     WHERE car_id = NEW.car_id)
);
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trig_reduce_existing_car_total_reservations_count`;
DELIMITER $$
CREATE TRIGGER `trig_reduce_existing_car_total_reservations_count` AFTER DELETE ON `reservation_cars` FOR EACH ROW IF EXISTS (SELECT car_id FROM `most_popular_cars_report` WHERE `most_popular_cars_report`.`car_id` = OLD.car_id) THEN
 UPDATE `most_popular_cars_report`
 SET `most_popular_cars_report`.`reservations_count` = `most_popular_cars_report`.`reservations_count` - 1
 WHERE `most_popular_cars_report`.`car_id` = OLD.car_id;
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trig_update_existing_car_total_reservations_count`;
DELIMITER $$
CREATE TRIGGER `trig_update_existing_car_total_reservations_count` BEFORE INSERT ON `reservation_cars` FOR EACH ROW IF EXISTS (SELECT car_id FROM `most_popular_cars_report` WHERE `most_popular_cars_report`.`car_id` = NEW.car_id) THEN
 UPDATE `most_popular_cars_report`
 SET `most_popular_cars_report`.`reservations_count` = `most_popular_cars_report`.`reservations_count` + 1
 WHERE `most_popular_cars_report`.`car_id` = NEW.car_id;
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `role` char(5) COLLATE latin1_general_ci NOT NULL COMMENT 'default roles: admin, user',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `roles`:
--

--
-- Truncate table before insert `roles`
--

TRUNCATE TABLE `roles`;
--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role`, `created_at`, `updated_at`) VALUES
(1, 'admin', CURRENT_TIMESTAMP, '0000-00-00 00:00:00'),
(2, 'user', CURRENT_TIMESTAMP, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `sales_revenue_report`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `sales_revenue_report`;
CREATE TABLE `sales_revenue_report` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `transaction_date` date NOT NULL,
  `transaction_amount` decimal(8,3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `sales_revenue_report`:
--   `transaction_id`
--       `reservations` -> `id`
--

--
-- Truncate table before insert `sales_revenue_report`
--

TRUNCATE TABLE `sales_revenue_report`;
--
-- Dumping data for table `sales_revenue_report`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` char(50) COLLATE latin1_general_ci NOT NULL,
  `password` char(60) COLLATE latin1_general_ci NOT NULL COMMENT 'encrypted value',
  `first_name` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `middle_name` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `last_name` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `users`:
--

--
-- Truncate table before insert `users`
--

TRUNCATE TABLE `users`;
--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `first_name`, `middle_name`, `last_name`, `created_at`, `updated_at`) VALUES
(1, 'admin@rental.test', 'admin', 'Fatima', 'A.', 'Alansari', CURRENT_TIMESTAMP, '0000-00-00 00:00:00');

--
-- Triggers `users`
--
DROP TRIGGER IF EXISTS `trig_add_default_user_role`;
DELIMITER $$
CREATE TRIGGER `trig_add_default_user_role` AFTER INSERT ON `users` FOR EACH ROW INSERT INTO user_roles(user_id, role_id) VALUES
    (
        (NEW.id),
        (
            SELECT id 
            FROM roles
            WHERE role = 'user'
        )
    )
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trig_delete_default_user_role`;
DELIMITER $$
CREATE TRIGGER `trig_delete_default_user_role` BEFORE DELETE ON `users` FOR EACH ROW DELETE FROM `user_roles`
 WHERE `user_roles`.`user_id` = OLD.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--
-- Creation: Jun 07, 2018 at 01:37 PM
--

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `user_roles`:
--   `user_id`
--       `users` -> `id`
--   `role_id`
--       `roles` -> `id`
--

--
-- Truncate table before insert `user_roles`
--

TRUNCATE TABLE `user_roles`;
--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accessories`
--
ALTER TABLE `accessories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accessory` (`accessory`);

--
-- Indexes for table `card_providers`
--
ALTER TABLE `card_providers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `card_provider` (`card_provider`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `manufacturer_id` (`manufacturer_id`),
  ADD KEY `model_id` (`model_id`),
  ADD KEY `make_year_id` (`make_year_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `car_categories`
--
ALTER TABLE `car_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category` (`category`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `country_code` (`country_code`);

--
-- Indexes for table `make_years`
--
ALTER TABLE `make_years`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `year` (`year`);

--
-- Indexes for table `manufacturers`
--
ALTER TABLE `manufacturers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `manufacturer` (`manufacturer`);

--
-- Indexes for table `models`
--
ALTER TABLE `models`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `model` (`model`);

--
-- Indexes for table `most_popular_cars_report`
--
ALTER TABLE `most_popular_cars_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `car_id` (`car_id`);

--
-- Indexes for table `payment_types`
--
ALTER TABLE `payment_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_type` (`payment_type`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_type_id` (`payment_type_id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `fk_card_provider_id` (`card_provider_id`);

--
-- Indexes for table `reservation_accessories`
--
ALTER TABLE `reservation_accessories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accessory_id` (`accessory_id`),
  ADD KEY `reservation_id` (`reservation_id`);

--
-- Indexes for table `reservation_cars`
--
ALTER TABLE `reservation_cars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservation_id` (`reservation_id`),
  ADD KEY `car_id` (`car_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role` (`role`);

--
-- Indexes for table `sales_revenue_report`
--
ALTER TABLE `sales_revenue_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accessories`
--
ALTER TABLE `accessories`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `card_providers`
--
ALTER TABLE `card_providers`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `car_categories`
--
ALTER TABLE `car_categories`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=248;

--
-- AUTO_INCREMENT for table `make_years`
--
ALTER TABLE `make_years`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `manufacturers`
--
ALTER TABLE `manufacturers`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `models`
--
ALTER TABLE `models`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `most_popular_cars_report`
--
ALTER TABLE `most_popular_cars_report`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment_types`
--
ALTER TABLE `payment_types`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reservation_accessories`
--
ALTER TABLE `reservation_accessories`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservation_cars`
--
ALTER TABLE `reservation_cars`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sales_revenue_report`
--
ALTER TABLE `sales_revenue_report`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`),
  ADD CONSTRAINT `cars_ibfk_2` FOREIGN KEY (`model_id`) REFERENCES `models` (`id`),
  ADD CONSTRAINT `cars_ibfk_3` FOREIGN KEY (`make_year_id`) REFERENCES `make_years` (`id`),
  ADD CONSTRAINT `cars_ibfk_4` FOREIGN KEY (`category_id`) REFERENCES `car_categories` (`id`);

--
-- Constraints for table `most_popular_cars_report`
--
ALTER TABLE `most_popular_cars_report`
  ADD CONSTRAINT `most_popular_cars_report_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `cars` (`id`);

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `fk_card_provider_id` FOREIGN KEY (`card_provider_id`) REFERENCES `card_providers` (`id`),
  ADD CONSTRAINT `fk_country_id` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_types` (`id`);

--
-- Constraints for table `reservation_accessories`
--
ALTER TABLE `reservation_accessories`
  ADD CONSTRAINT `reservation_accessories_ibfk_1` FOREIGN KEY (`accessory_id`) REFERENCES `accessories` (`id`),
  ADD CONSTRAINT `reservation_accessories_ibfk_2` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`);

--
-- Constraints for table `reservation_cars`
--
ALTER TABLE `reservation_cars`
  ADD CONSTRAINT `reservation_cars_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`),
  ADD CONSTRAINT `reservation_cars_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `cars` (`id`);

--
-- Constraints for table `sales_revenue_report`
--
ALTER TABLE `sales_revenue_report`
  ADD CONSTRAINT `sales_revenue_report_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `reservations` (`id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
