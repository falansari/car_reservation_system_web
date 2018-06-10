-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2018 at 08:51 PM
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
-- Database: `20900029`
--
USE `20900029`;

-- --------------------------------------------------------

--
-- Table structure for table `accessories`
--
-- Creation: Jun 08, 2018 at 10:18 AM
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
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `accessories`:
--

--
-- Dumping data for table `accessories`
--

INSERT INTO `accessories` (`id`, `accessory`, `daily_rental_price`, `available_qty`, `reserved_qty`, `total_qty`) VALUES
(1, 'Infant Car Seat', '1.500', 10, 0, 10),
(2, 'Child Car Seat', '1.500', 10, 0, 10),
(3, 'Booster Car Seat', '1.500', 10, 0, 10),
(4, 'Screen', '1.000', 10, 0, 10),
(5, 'Car GPS System', '3.500', 10, 0, 10),
(6, 'Ski Racks', '4.500', 10, 0, 10),
(7, 'Snow Tires', '4.000', 40, 0, 40),
(8, 'Winter Tires', '4.000', 40, 0, 40),
(9, 'Summer Tires', '2.500', 40, 0, 40),
(10, 'All-Terrain Tires', '3.000', 40, 0, 40),
(11, 'Car Insurance', '2.000', 100, 0, 100);

-- --------------------------------------------------------

--
-- Table structure for table `card_providers`
--
-- Creation: Jun 08, 2018 at 10:18 AM
--

DROP TABLE IF EXISTS `card_providers`;
CREATE TABLE `card_providers` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `card_provider` varchar(30) COLLATE latin1_general_ci NOT NULL COMMENT 'e.g. Visa, MasterCard',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `card_providers`:
--

--
-- Dumping data for table `card_providers`
--

INSERT INTO `card_providers` (`id`, `card_provider`) VALUES
(1, 'Visa'),
(2, 'MasterCard'),
(3, 'American Express');

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--
-- Creation: Jun 08, 2018 at 10:18 AM
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
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
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
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`id`, `manufacturer_id`, `model_id`, `make_year_id`, `category_id`, `daily_rental_price`) VALUES
(1, 6, 57, 29, 4, '10.000');
INSERT INTO `cars` (`id`, `manufacturer_id`, `model_id`, `make_year_id`, `category_id`, `daily_rental_price`) VALUES
(2, 13, 2, 29, 7, '6.000'),
(3, 2, 10, 24, 9, '30.000');

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
-- Creation: Jun 08, 2018 at 10:18 AM
--

DROP TABLE IF EXISTS `car_categories`;
CREATE TABLE `car_categories` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `category` char(20) COLLATE latin1_general_ci NOT NULL COMMENT 'e.g. SUV, Sedan, Hatchback',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `car_categories`:
--

--
-- Dumping data for table `car_categories`
--

INSERT INTO `car_categories` (`id`, `category`) VALUES
(1, 'Hatchback'),
(2, 'Sedan Subcompact'),
(3, 'Sedan Compact'),
(4, 'Sedan Mid-size'),
(5, 'Sedan Large'),
(6, 'MPV'),
(7, 'SUV'),
(8, 'Crossover'),
(9, 'Coupe'),
(10, 'Convertible'),
(11, 'Minivan'),
(12, 'Van'),
(13, 'Pickup Truck');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--
-- Creation: Jun 08, 2018 at 10:18 AM
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
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `countries`:
--

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `country_code`, `country_name_en`, `country_nationality_en`, `country_name_ar`, `country_nationality_ar`) VALUES
(1, 'AF', 'Afghanistan', 'Afghan', 'أفغانستان', 'أفغانستاني'),
(2, 'AL', 'Albania', 'Albanian', 'ألبانيا', 'ألباني'),
(3, 'AX', 'Aland Islands', 'Aland Islander', 'جزر آلاند', 'آلاندي'),
(4, 'DZ', 'Algeria', 'Algerian', 'الجزائر', 'جزائري'),
(5, 'AS', 'American Samoa', 'American Samoan', 'ساموا-الأمريكي', 'أمريكي سامواني'),
(6, 'AD', 'Andorra', 'Andorran', 'أندورا', 'أندوري'),
(7, 'AO', 'Angola', 'Angolan', 'أنغولا', 'أنقولي'),
(8, 'AI', 'Anguilla', 'Anguillan', 'أنغويلا', 'أنغويلي'),
(9, 'AQ', 'Antarctica', 'Antarctican', 'أنتاركتيكا', 'أنتاركتيكي'),
(10, 'AG', 'Antigua and Barbuda', 'Antiguan', 'أنتيغوا وبربودا', 'بربودي'),
(11, 'AR', 'Argentina', 'Argentinian', 'الأرجنتين', 'أرجنتيني'),
(12, 'AM', 'Armenia', 'Armenian', 'أرمينيا', 'أرميني'),
(13, 'AW', 'Aruba', 'Aruban', 'أروبه', 'أوروبهيني'),
(14, 'AU', 'Australia', 'Australian', 'أستراليا', 'أسترالي'),
(15, 'AT', 'Austria', 'Austrian', 'النمسا', 'نمساوي'),
(16, 'AZ', 'Azerbaijan', 'Azerbaijani', 'أذربيجان', 'أذربيجاني'),
(17, 'BS', 'Bahamas', 'Bahamian', 'الباهاماس', 'باهاميسي'),
(18, 'BH', 'Bahrain', 'Bahraini', 'البحرين', 'بحريني'),
(19, 'BD', 'Bangladesh', 'Bangladeshi', 'بنغلاديش', 'بنغلاديشي'),
(20, 'BB', 'Barbados', 'Barbadian', 'بربادوس', 'بربادوسي'),
(21, 'BY', 'Belarus', 'Belarusian', 'روسيا البيضاء', 'روسي'),
(22, 'BE', 'Belgium', 'Belgian', 'بلجيكا', 'بلجيكي'),
(23, 'BZ', 'Belize', 'Belizean', 'بيليز', 'بيليزي'),
(24, 'BJ', 'Benin', 'Beninese', 'بنين', 'بنيني'),
(25, 'BL', 'Saint Barthelemy', 'Saint Barthelmian', 'سان بارتيلمي', 'سان بارتيلمي'),
(26, 'BM', 'Bermuda', 'Bermudan', 'جزر برمودا', 'برمودي'),
(27, 'BT', 'Bhutan', 'Bhutanese', 'بوتان', 'بوتاني'),
(28, 'BO', 'Bolivia', 'Bolivian', 'بوليفيا', 'بوليفي'),
(29, 'BA', 'Bosnia and Herzegovina', 'Bosnian / Herzegovinian', 'البوسنة و الهرسك', 'بوسني/هرسكي'),
(30, 'BW', 'Botswana', 'Botswanan', 'بوتسوانا', 'بوتسواني'),
(31, 'BV', 'Bouvet Island', 'Bouvetian', 'جزيرة بوفيه', 'بوفيهي'),
(32, 'BR', 'Brazil', 'Brazilian', 'البرازيل', 'برازيلي'),
(33, 'IO', 'British Indian Ocean Territory', 'British Indian Ocean Territory', 'إقليم المحيط الهندي البريطاني', 'إقليم المحيط الهندي البريطاني'),
(34, 'BN', 'Brunei Darussalam', 'Bruneian', 'بروني', 'بروني'),
(35, 'BG', 'Bulgaria', 'Bulgarian', 'بلغاريا', 'بلغاري'),
(36, 'BF', 'Burkina Faso', 'Burkinabe', 'بوركينا فاسو', 'بوركيني'),
(37, 'BI', 'Burundi', 'Burundian', 'بوروندي', 'بورونيدي'),
(38, 'KH', 'Cambodia', 'Cambodian', 'كمبوديا', 'كمبودي'),
(39, 'CM', 'Cameroon', 'Cameroonian', 'كاميرون', 'كاميروني'),
(40, 'CA', 'Canada', 'Canadian', 'كندا', 'كندي'),
(41, 'CV', 'Cape Verde', 'Cape Verdean', 'الرأس الأخضر', 'الرأس الأخضر'),
(42, 'KY', 'Cayman Islands', 'Caymanian', 'جزر كايمان', 'كايماني'),
(43, 'CF', 'Central African Republic', 'Central African', 'جمهورية أفريقيا الوسطى', 'أفريقي'),
(44, 'TD', 'Chad', 'Chadian', 'تشاد', 'تشادي'),
(45, 'CL', 'Chile', 'Chilean', 'شيلي', 'شيلي'),
(46, 'CN', 'China', 'Chinese', 'الصين', 'صيني'),
(47, 'CX', 'Christmas Island', 'Christmas Islander', 'جزيرة عيد الميلاد', 'جزيرة عيد الميلاد'),
(48, 'CC', 'Cocos (Keeling) Islands', 'Cocos Islander', 'جزر كوكوس', 'جزر كوكوس'),
(49, 'CO', 'Colombia', 'Colombian', 'كولومبيا', 'كولومبي'),
(50, 'KM', 'Comoros', 'Comorian', 'جزر القمر', 'جزر القمر'),
(51, 'CG', 'Congo', 'Congolese', 'الكونغو', 'كونغي'),
(52, 'CK', 'Cook Islands', 'Cook Islander', 'جزر كوك', 'جزر كوك'),
(53, 'CR', 'Costa Rica', 'Costa Rican', 'كوستاريكا', 'كوستاريكي'),
(54, 'HR', 'Croatia', 'Croatian', 'كرواتيا', 'كوراتي'),
(55, 'CU', 'Cuba', 'Cuban', 'كوبا', 'كوبي'),
(56, 'CY', 'Cyprus', 'Cypriot', 'قبرص', 'قبرصي'),
(57, 'CW', 'Curaçao', 'Curacian', 'كوراساو', 'كوراساوي'),
(58, 'CZ', 'Czech Republic', 'Czech', 'الجمهورية التشيكية', 'تشيكي'),
(59, 'DK', 'Denmark', 'Danish', 'الدانمارك', 'دنماركي'),
(60, 'DJ', 'Djibouti', 'Djiboutian', 'جيبوتي', 'جيبوتي'),
(61, 'DM', 'Dominica', 'Dominican', 'دومينيكا', 'دومينيكي'),
(62, 'DO', 'Dominican Republic', 'Dominican', 'الجمهورية الدومينيكية', 'دومينيكي'),
(63, 'EC', 'Ecuador', 'Ecuadorian', 'إكوادور', 'إكوادوري'),
(64, 'EG', 'Egypt', 'Egyptian', 'مصر', 'مصري'),
(65, 'SV', 'El Salvador', 'Salvadoran', 'إلسلفادور', 'سلفادوري'),
(66, 'GQ', 'Equatorial Guinea', 'Equatorial Guinean', 'غينيا الاستوائي', 'غيني'),
(67, 'ER', 'Eritrea', 'Eritrean', 'إريتريا', 'إريتيري'),
(68, 'EE', 'Estonia', 'Estonian', 'استونيا', 'استوني'),
(69, 'ET', 'Ethiopia', 'Ethiopian', 'أثيوبيا', 'أثيوبي'),
(70, 'FK', 'Falkland Islands (Malvinas)', 'Falkland Islander', 'جزر فوكلاند', 'فوكلاندي'),
(71, 'FO', 'Faroe Islands', 'Faroese', 'جزر فارو', 'جزر فارو'),
(72, 'FJ', 'Fiji', 'Fijian', 'فيجي', 'فيجي'),
(73, 'FI', 'Finland', 'Finnish', 'فنلندا', 'فنلندي'),
(74, 'FR', 'France', 'French', 'فرنسا', 'فرنسي'),
(75, 'GF', 'French Guiana', 'French Guianese', 'غويانا الفرنسية', 'غويانا الفرنسية'),
(76, 'PF', 'French Polynesia', 'French Polynesian', 'بولينيزيا الفرنسية', 'بولينيزيي'),
(77, 'TF', 'French Southern and Antarctic Lands', 'French', 'أراض فرنسية جنوبية وأنتارتيكية', 'أراض فرنسية جنوبية وأنتارتيكية'),
(78, 'GA', 'Gabon', 'Gabonese', 'الغابون', 'غابوني'),
(79, 'GM', 'Gambia', 'Gambian', 'غامبيا', 'غامبي'),
(80, 'GE', 'Georgia', 'Georgian', 'جيورجيا', 'جيورجي'),
(81, 'DE', 'Germany', 'German', 'ألمانيا', 'ألماني'),
(82, 'GH', 'Ghana', 'Ghanaian', 'غانا', 'غاني'),
(83, 'GI', 'Gibraltar', 'Gibraltar', 'جبل طارق', 'جبل طارق'),
(84, 'GG', 'Guernsey', 'Guernsian', 'غيرنزي', 'غيرنزي'),
(85, 'GR', 'Greece', 'Greek', 'اليونان', 'يوناني'),
(86, 'GL', 'Greenland', 'Greenlandic', 'جرينلاند', 'جرينلاندي'),
(87, 'GD', 'Grenada', 'Grenadian', 'غرينادا', 'غرينادي'),
(88, 'GP', 'Guadeloupe', 'Guadeloupe', 'جزر جوادلوب', 'جزر جوادلوب'),
(89, 'GU', 'Guam', 'Guamanian', 'جوام', 'جوامي'),
(90, 'GT', 'Guatemala', 'Guatemalan', 'غواتيمال', 'غواتيمالي'),
(91, 'GN', 'Guinea', 'Guinean', 'غينيا', 'غيني'),
(92, 'GW', 'Guinea-Bissau', 'Guinea-Bissauan', 'غينيا-بيساو', 'غيني'),
(93, 'GY', 'Guyana', 'Guyanese', 'غيانا', 'غياني'),
(94, 'HT', 'Haiti', 'Haitian', 'هايتي', 'هايتي'),
(95, 'HM', 'Heard and Mc Donald Islands', 'Heard and Mc Donald Islanders', 'جزيرة هيرد وجزر ماكدونالد', 'جزيرة هيرد وجزر ماكدونالد'),
(96, 'HN', 'Honduras', 'Honduran', 'هندوراس', 'هندوراسي'),
(97, 'HK', 'Hong Kong', 'Hongkongese', 'هونغ كونغ', 'هونغ كونغي'),
(98, 'HU', 'Hungary', 'Hungarian', 'المجر', 'مجري'),
(99, 'IS', 'Iceland', 'Icelandic', 'آيسلندا', 'آيسلندي'),
(100, 'IN', 'India', 'Indian', 'الهند', 'هندي'),
(101, 'IM', 'Isle of Man', 'Manx', 'جزيرة مان', 'ماني'),
(102, 'ID', 'Indonesia', 'Indonesian', 'أندونيسيا', 'أندونيسيي'),
(103, 'IR', 'Iran', 'Iranian', 'إيران', 'إيراني'),
(104, 'IQ', 'Iraq', 'Iraqi', 'العراق', 'عراقي'),
(105, 'IE', 'Ireland', 'Irish', 'إيرلندا', 'إيرلندي'),
(106, 'IL', 'Israel', 'Israeli', 'إسرائيل', 'إسرائيلي'),
(107, 'IT', 'Italy', 'Italian', 'إيطاليا', 'إيطالي'),
(108, 'CI', 'Ivory Coast', 'Ivory Coastian', 'ساحل العاج', 'ساحل العاج'),
(109, 'JE', 'Jersey', 'Jersian', 'جيرزي', 'جيرزي'),
(110, 'JM', 'Jamaica', 'Jamaican', 'جمايكا', 'جمايكي'),
(111, 'JP', 'Japan', 'Japanese', 'اليابان', 'ياباني'),
(112, 'JO', 'Jordan', 'Jordanian', 'الأردن', 'أردني'),
(113, 'KZ', 'Kazakhstan', 'Kazakh', 'كازاخستان', 'كازاخستاني'),
(114, 'KE', 'Kenya', 'Kenyan', 'كينيا', 'كيني'),
(115, 'KI', 'Kiribati', 'I-Kiribati', 'كيريباتي', 'كيريباتي'),
(116, 'KP', 'Korea(North Korea)', 'North Korean', 'كوريا الشمالية', 'كوري'),
(117, 'KR', 'Korea(South Korea)', 'South Korean', 'كوريا الجنوبية', 'كوري'),
(118, 'XK', 'Kosovo', 'Kosovar', 'كوسوفو', 'كوسيفي'),
(119, 'KW', 'Kuwait', 'Kuwaiti', 'الكويت', 'كويتي'),
(120, 'KG', 'Kyrgyzstan', 'Kyrgyzstani', 'قيرغيزستان', 'قيرغيزستاني'),
(121, 'LA', 'Lao PDR', 'Laotian', 'لاوس', 'لاوسي'),
(122, 'LV', 'Latvia', 'Latvian', 'لاتفيا', 'لاتيفي'),
(123, 'LB', 'Lebanon', 'Lebanese', 'لبنان', 'لبناني'),
(124, 'LS', 'Lesotho', 'Basotho', 'ليسوتو', 'ليوسيتي'),
(125, 'LR', 'Liberia', 'Liberian', 'ليبيريا', 'ليبيري'),
(126, 'LY', 'Libya', 'Libyan', 'ليبيا', 'ليبي'),
(127, 'LI', 'Liechtenstein', 'Liechtenstein', 'ليختنشتين', 'ليختنشتيني'),
(128, 'LT', 'Lithuania', 'Lithuanian', 'لتوانيا', 'لتوانيي'),
(129, 'LU', 'Luxembourg', 'Luxembourger', 'لوكسمبورغ', 'لوكسمبورغي'),
(130, 'LK', 'Sri Lanka', 'Sri Lankian', 'سريلانكا', 'سريلانكي'),
(131, 'MO', 'Macau', 'Macanese', 'ماكاو', 'ماكاوي'),
(132, 'MK', 'Macedonia', 'Macedonian', 'مقدونيا', 'مقدوني'),
(133, 'MG', 'Madagascar', 'Malagasy', 'مدغشقر', 'مدغشقري'),
(134, 'MW', 'Malawi', 'Malawian', 'مالاوي', 'مالاوي'),
(135, 'MY', 'Malaysia', 'Malaysian', 'ماليزيا', 'ماليزي'),
(136, 'MV', 'Maldives', 'Maldivian', 'المالديف', 'مالديفي'),
(137, 'ML', 'Mali', 'Malian', 'مالي', 'مالي'),
(138, 'MT', 'Malta', 'Maltese', 'مالطا', 'مالطي'),
(139, 'MH', 'Marshall Islands', 'Marshallese', 'جزر مارشال', 'مارشالي'),
(140, 'MQ', 'Martinique', 'Martiniquais', 'مارتينيك', 'مارتينيكي'),
(141, 'MR', 'Mauritania', 'Mauritanian', 'موريتانيا', 'موريتانيي'),
(142, 'MU', 'Mauritius', 'Mauritian', 'موريشيوس', 'موريشيوسي'),
(143, 'YT', 'Mayotte', 'Mahoran', 'مايوت', 'مايوتي'),
(144, 'MX', 'Mexico', 'Mexican', 'المكسيك', 'مكسيكي'),
(145, 'FM', 'Micronesia', 'Micronesian', 'مايكرونيزيا', 'مايكرونيزيي'),
(146, 'MD', 'Moldova', 'Moldovan', 'مولدافيا', 'مولديفي'),
(147, 'MC', 'Monaco', 'Monacan', 'موناكو', 'مونيكي'),
(148, 'MN', 'Mongolia', 'Mongolian', 'منغوليا', 'منغولي'),
(149, 'ME', 'Montenegro', 'Montenegrin', 'الجبل الأسود', 'الجبل الأسود'),
(150, 'MS', 'Montserrat', 'Montserratian', 'مونتسيرات', 'مونتسيراتي'),
(151, 'MA', 'Morocco', 'Moroccan', 'المغرب', 'مغربي'),
(152, 'MZ', 'Mozambique', 'Mozambican', 'موزمبيق', 'موزمبيقي'),
(153, 'MM', 'Myanmar', 'Myanmarian', 'ميانمار', 'ميانماري'),
(154, 'NA', 'Namibia', 'Namibian', 'ناميبيا', 'ناميبي'),
(155, 'NR', 'Nauru', 'Nauruan', 'نورو', 'نوري'),
(156, 'NP', 'Nepal', 'Nepalese', 'نيبال', 'نيبالي'),
(157, 'NL', 'Netherlands', 'Dutch', 'هولندا', 'هولندي'),
(158, 'AN', 'Netherlands Antilles', 'Dutch Antilier', 'جزر الأنتيل الهولندي', 'هولندي'),
(159, 'NC', 'New Caledonia', 'New Caledonian', 'كاليدونيا الجديدة', 'كاليدوني'),
(160, 'NZ', 'New Zealand', 'New Zealander', 'نيوزيلندا', 'نيوزيلندي'),
(161, 'NI', 'Nicaragua', 'Nicaraguan', 'نيكاراجوا', 'نيكاراجوي'),
(162, 'NE', 'Niger', 'Nigerien', 'النيجر', 'نيجيري'),
(163, 'NG', 'Nigeria', 'Nigerian', 'نيجيريا', 'نيجيري'),
(164, 'NU', 'Niue', 'Niuean', 'ني', 'ني'),
(165, 'NF', 'Norfolk Island', 'Norfolk Islander', 'جزيرة نورفولك', 'نورفوليكي'),
(166, 'MP', 'Northern Mariana Islands', 'Northern Marianan', 'جزر ماريانا الشمالية', 'ماريني'),
(167, 'NO', 'Norway', 'Norwegian', 'النرويج', 'نرويجي'),
(168, 'OM', 'Oman', 'Omani', 'عمان', 'عماني'),
(169, 'PK', 'Pakistan', 'Pakistani', 'باكستان', 'باكستاني'),
(170, 'PW', 'Palau', 'Palauan', 'بالاو', 'بالاوي'),
(171, 'PS', 'Palestine', 'Palestinian', 'فلسطين', 'فلسطيني'),
(172, 'PA', 'Panama', 'Panamanian', 'بنما', 'بنمي'),
(173, 'PG', 'Papua New Guinea', 'Papua New Guinean', 'بابوا غينيا الجديدة', 'بابوي'),
(174, 'PY', 'Paraguay', 'Paraguayan', 'باراغواي', 'بارغاوي'),
(175, 'PE', 'Peru', 'Peruvian', 'بيرو', 'بيري'),
(176, 'PH', 'Philippines', 'Filipino', 'الفليبين', 'فلبيني'),
(177, 'PN', 'Pitcairn', 'Pitcairn Islander', 'بيتكيرن', 'بيتكيرني'),
(178, 'PL', 'Poland', 'Polish', 'بولونيا', 'بوليني'),
(179, 'PT', 'Portugal', 'Portuguese', 'البرتغال', 'برتغالي'),
(180, 'PR', 'Puerto Rico', 'Puerto Rican', 'بورتو ريكو', 'بورتي'),
(181, 'QA', 'Qatar', 'Qatari', 'قطر', 'قطري'),
(182, 'RE', 'Reunion Island', 'Reunionese', 'ريونيون', 'ريونيوني'),
(183, 'RO', 'Romania', 'Romanian', 'رومانيا', 'روماني'),
(184, 'RU', 'Russian', 'Russian', 'روسيا', 'روسي'),
(185, 'RW', 'Rwanda', 'Rwandan', 'رواندا', 'رواندا'),
(186, 'KN', 'Saint Kitts and Nevis', 'Kittitian/Nevisian', 'سانت كيتس ونيفس,', 'سانت كيتس ونيفس'),
(187, 'MF', 'Saint Martin (French part)', 'St. Martian(French)', 'ساينت مارتن فرنسي', 'ساينت مارتني فرنسي'),
(188, 'SX', 'Sint Maarten (Dutch part)', 'St. Martian(Dutch)', 'ساينت مارتن هولندي', 'ساينت مارتني هولندي'),
(189, 'LC', 'Saint Pierre and Miquelon', 'St. Pierre and Miquelon', 'سان بيير وميكلون', 'سان بيير وميكلوني'),
(190, 'VC', 'Saint Vincent and the Grenadines', 'Saint Vincent and the Grenadines', 'سانت فنسنت وجزر غرينادين', 'سانت فنسنت وجزر غرينادين'),
(191, 'WS', 'Samoa', 'Samoan', 'ساموا', 'ساموي'),
(192, 'SM', 'San Marino', 'Sammarinese', 'سان مارينو', 'ماريني'),
(193, 'ST', 'Sao Tome and Principe', 'Sao Tomean', 'ساو تومي وبرينسيبي', 'ساو تومي وبرينسيبي'),
(194, 'SA', 'Saudi Arabia', 'Saudi Arabian', 'المملكة العربية السعودية', 'سعودي'),
(195, 'SN', 'Senegal', 'Senegalese', 'السنغال', 'سنغالي'),
(196, 'RS', 'Serbia', 'Serbian', 'صربيا', 'صربي'),
(197, 'SC', 'Seychelles', 'Seychellois', 'سيشيل', 'سيشيلي'),
(198, 'SL', 'Sierra Leone', 'Sierra Leonean', 'سيراليون', 'سيراليوني'),
(199, 'SG', 'Singapore', 'Singaporean', 'سنغافورة', 'سنغافوري'),
(200, 'SK', 'Slovakia', 'Slovak', 'سلوفاكيا', 'سولفاكي'),
(201, 'SI', 'Slovenia', 'Slovenian', 'سلوفينيا', 'سولفيني'),
(202, 'SB', 'Solomon Islands', 'Solomon Island', 'جزر سليمان', 'جزر سليمان'),
(203, 'SO', 'Somalia', 'Somali', 'الصومال', 'صومالي'),
(204, 'ZA', 'South Africa', 'South African', 'جنوب أفريقيا', 'أفريقي'),
(205, 'GS', 'South Georgia and the South Sandwich', 'South Georgia and the South Sandwich', 'المنطقة القطبية الجنوبية', 'لمنطقة القطبية الجنوبية'),
(206, 'SS', 'South Sudan', 'South Sudanese', 'السودان الجنوبي', 'سوادني جنوبي'),
(207, 'ES', 'Spain', 'Spanish', 'إسبانيا', 'إسباني'),
(208, 'SH', 'Saint Helena', 'St. Helenian', 'سانت هيلانة', 'هيلاني'),
(209, 'SD', 'Sudan', 'Sudanese', 'السودان', 'سوداني'),
(210, 'SR', 'Suriname', 'Surinamese', 'سورينام', 'سورينامي'),
(211, 'SJ', 'Svalbard and Jan Mayen', 'Svalbardian/Jan Mayenian', 'سفالبارد ويان ماين', 'سفالبارد ويان ماين'),
(212, 'SZ', 'Swaziland', 'Swazi', 'سوازيلند', 'سوازيلندي'),
(213, 'SE', 'Sweden', 'Swedish', 'السويد', 'سويدي'),
(214, 'CH', 'Switzerland', 'Swiss', 'سويسرا', 'سويسري'),
(215, 'SY', 'Syria', 'Syrian', 'سوريا', 'سوري'),
(216, 'TW', 'Taiwan', 'Taiwanese', 'تايوان', 'تايواني'),
(217, 'TJ', 'Tajikistan', 'Tajikistani', 'طاجيكستان', 'طاجيكستاني'),
(218, 'TZ', 'Tanzania', 'Tanzanian', 'تنزانيا', 'تنزانيي'),
(219, 'TH', 'Thailand', 'Thai', 'تايلندا', 'تايلندي'),
(220, 'TL', 'Timor-Leste', 'Timor-Lestian', 'تيمور الشرقية', 'تيموري'),
(221, 'TG', 'Togo', 'Togolese', 'توغو', 'توغي'),
(222, 'TK', 'Tokelau', 'Tokelaian', 'توكيلاو', 'توكيلاوي'),
(223, 'TO', 'Tonga', 'Tongan', 'تونغا', 'تونغي'),
(224, 'TT', 'Trinidad and Tobago', 'Trinidadian/Tobagonian', 'ترينيداد وتوباغو', 'ترينيداد وتوباغو'),
(225, 'TN', 'Tunisia', 'Tunisian', 'تونس', 'تونسي'),
(226, 'TR', 'Turkey', 'Turkish', 'تركيا', 'تركي'),
(227, 'TM', 'Turkmenistan', 'Turkmen', 'تركمانستان', 'تركمانستاني'),
(228, 'TC', 'Turks and Caicos Islands', 'Turks and Caicos Islands', 'جزر توركس وكايكوس', 'جزر توركس وكايكوس'),
(229, 'TV', 'Tuvalu', 'Tuvaluan', 'توفالو', 'توفالي'),
(230, 'UG', 'Uganda', 'Ugandan', 'أوغندا', 'أوغندي'),
(231, 'UA', 'Ukraine', 'Ukrainian', 'أوكرانيا', 'أوكراني'),
(232, 'AE', 'United Arab Emirates', 'Emirati', 'الإمارات العربية المتحدة', 'إماراتي'),
(233, 'GB', 'United Kingdom', 'British', 'المملكة المتحدة', 'بريطاني'),
(234, 'US', 'United States', 'American', 'الولايات المتحدة', 'أمريكي'),
(235, 'UM', 'US Minor Outlying Islands', 'US Minor Outlying Islander', 'قائمة الولايات والمناطق الأمريكية', 'أمريكي'),
(236, 'UY', 'Uruguay', 'Uruguayan', 'أورغواي', 'أورغواي'),
(237, 'UZ', 'Uzbekistan', 'Uzbek', 'أوزباكستان', 'أوزباكستاني'),
(238, 'VU', 'Vanuatu', 'Vanuatuan', 'فانواتو', 'فانواتي'),
(239, 'VE', 'Venezuela', 'Venezuelan', 'فنزويلا', 'فنزويلي'),
(240, 'VN', 'Vietnam', 'Vietnamese', 'فيتنام', 'فيتنامي'),
(241, 'VI', 'Virgin Islands (U.S.)', 'American Virgin Islander', 'الجزر العذراء الأمريكي', 'أمريكي'),
(242, 'VA', 'Vatican City', 'Vatican', 'فنزويلا', 'فاتيكاني'),
(243, 'WF', 'Wallis and Futuna Islands', 'Wallisian/Futunan', 'والس وفوتونا', 'فوتوني'),
(244, 'EH', 'Western Sahara', 'Sahrawian', 'الصحراء الغربية', 'صحراوي'),
(245, 'YE', 'Yemen', 'Yemeni', 'اليمن', 'يمني'),
(246, 'ZM', 'Zambia', 'Zambian', 'زامبيا', 'زامبياني'),
(247, 'ZW', 'Zimbabwe', 'Zimbabwean', 'زمبابوي', 'زمبابوي');

-- --------------------------------------------------------

--
-- Table structure for table `make_years`
--
-- Creation: Jun 08, 2018 at 10:18 AM
--

DROP TABLE IF EXISTS `make_years`;
CREATE TABLE `make_years` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `year` year(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `make_years`:
--

--
-- Dumping data for table `make_years`
--

INSERT INTO `make_years` (`id`, `year`) VALUES
(1, 1990),
(2, 1991),
(3, 1992),
(4, 1993),
(5, 1994),
(6, 1995),
(7, 1996),
(8, 1997),
(9, 1998),
(10, 1999),
(11, 2000),
(12, 2001),
(13, 2002),
(14, 2003),
(15, 2004),
(16, 2005),
(17, 2006),
(18, 2007),
(19, 2008),
(20, 2009),
(21, 2010),
(22, 2011),
(23, 2012),
(24, 2013),
(25, 2014),
(26, 2015),
(27, 2016),
(28, 2017),
(29, 2018),
(30, 2019);

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers`
--
-- Creation: Jun 08, 2018 at 10:18 AM
--

DROP TABLE IF EXISTS `manufacturers`;
CREATE TABLE `manufacturers` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `manufacturer` varchar(30) COLLATE latin1_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `manufacturers`:
--

--
-- Dumping data for table `manufacturers`
--

INSERT INTO `manufacturers` (`id`, `manufacturer`) VALUES
(1, 'Acura'),
(2, 'Alfa Romeo'),
(3, 'Aston Martin'),
(4, 'Audi'),
(5, 'Bentley'),
(6, 'BMW'),
(7, 'Bugatti'),
(8, 'Buick'),
(9, 'Cadillac'),
(10, 'Chevrolet'),
(11, 'Chrysler'),
(12, 'Dodge'),
(13, 'Ford'),
(14, 'GMC'),
(15, 'Honda'),
(16, 'Hyundai'),
(17, 'Infiniti'),
(18, 'Jeep'),
(19, 'Kia'),
(20, 'Lexus'),
(21, 'Mazda'),
(22, 'Mercedes-Benz'),
(23, 'Mitsubishi'),
(24, 'Porsche'),
(25, 'Nissan'),
(26, 'Subaru'),
(27, 'Tesla'),
(28, 'Toyota'),
(29, 'Volkswagen');

-- --------------------------------------------------------

--
-- Table structure for table `models`
--
-- Creation: Jun 08, 2018 at 10:18 AM
--

DROP TABLE IF EXISTS `models`;
CREATE TABLE `models` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `model` varchar(30) COLLATE latin1_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `models`:
--

--
-- Dumping data for table `models`
--

INSERT INTO `models` (`id`, `model`) VALUES
(1, 'Chevy Sonic'),
(2, 'Ford Fiesta'),
(3, 'Honda Fit'),
(4, 'Hyundai Accent'),
(5, 'Kia Rio'),
(6, 'Mazda2'),
(7, 'Mitsubishi Mirage'),
(8, 'Nissan Versa'),
(9, 'Toyota Yaris'),
(10, 'Alpha Romeo C4'),
(11, 'Ford Focus'),
(12, 'Honda Civic'),
(13, 'Hyundai Elantra'),
(14, 'Mazda3'),
(15, 'Mitsubishi Lancer'),
(16, 'Subaru Impreza'),
(17, 'Volkswagen Golf'),
(18, 'Volkswagen Beetle'),
(19, 'Chevy Malibu'),
(20, 'Ford Fusion'),
(21, 'Honda Accord'),
(22, 'Hyundai Sonata'),
(23, 'Kia Optima'),
(24, 'Mazda6'),
(25, 'Nissan Altima'),
(26, 'Toyota Camry'),
(27, 'Ford Taurus'),
(28, 'Chevy Impala'),
(29, 'Nissan Maxima'),
(30, 'Toyota Avalon'),
(31, 'Nissan Juke'),
(32, 'Honda HR-V'),
(33, 'Honda CR-V'),
(34, 'Hyundai Tucson'),
(35, 'Mazda CX-3'),
(36, 'Jeep Patriot'),
(37, 'Subaru Forester'),
(38, 'Toyota RAV4'),
(39, 'GMC Acadia'),
(40, 'Dodge Tourney'),
(41, 'Honda Pilot'),
(42, 'Hyundai Santa Fe'),
(43, 'Jeep Cherokee'),
(44, 'Nissan Pathfinder'),
(45, 'Dodge Grand Caravan'),
(46, 'Honda Odyssey'),
(47, 'Mazda5'),
(48, 'Nissan Quest'),
(49, 'Jeep Wrangler'),
(50, 'Kia Sportage'),
(51, 'Kia Sorento'),
(52, 'Toyota Land Cruiser'),
(53, 'Nissan Armada'),
(54, 'Audi A4'),
(55, 'Acura ILX'),
(56, 'BMW 2 Series'),
(57, 'BMW 3 Series'),
(58, 'BMW 4 Series'),
(59, 'Cadillac ATS'),
(60, 'Infiniti Q50'),
(61, 'Lexus IS'),
(62, 'Mercedes-Benz C-Class'),
(63, 'Audi A6'),
(64, 'BMW 5 Series'),
(65, 'Chrysler 200'),
(66, 'Lexus GS'),
(67, 'Audi A8'),
(68, 'Lexus LS'),
(69, 'Audi Q-Series'),
(70, 'BMW X Series'),
(71, 'Chevy Spark'),
(72, 'Toyota Prius'),
(73, 'Nissan Leaf'),
(74, 'BMW i3'),
(75, 'Audi R8'),
(76, 'BMW M Series'),
(77, 'Chevy Camaro'),
(78, 'Chevy Corvette'),
(79, 'Dodge Challenger'),
(80, 'Dodge Charger'),
(81, 'Ford Mustang'),
(82, 'Nissan Z'),
(83, 'Porsche 911'),
(84, 'Chevy Colorado'),
(85, 'Nissan Frontier'),
(86, 'Toyota Tacoma'),
(87, 'Chevy Silverado'),
(88, 'GMC Sierra'),
(89, 'Nissan Titan'),
(90, 'Ford Transit'),
(91, 'Aston Martin DB11'),
(92, 'Bentley Mulsane'),
(93, 'Bugatti Veyron'),
(94, 'Tesla Model 3');

-- --------------------------------------------------------

--
-- Table structure for table `most_popular_cars_report`
--
-- Creation: Jun 08, 2018 at 10:18 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `payment_types`
--
-- Creation: Jun 08, 2018 at 10:18 AM
--

DROP TABLE IF EXISTS `payment_types`;
CREATE TABLE `payment_types` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `payment_type` char(4) COLLATE latin1_general_ci NOT NULL COMMENT 'Types:Cash, card',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `payment_types`:
--

--
-- Dumping data for table `payment_types`
--

INSERT INTO `payment_types` (`id`, `payment_type`) VALUES
(1, 'Cash'),
(2, 'Card');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--
-- Creation: Jun 09, 2018 at 06:50 PM
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
  `first_name` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `middle_name` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `last_name` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `address` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `CPR` int(10) UNSIGNED NOT NULL,
  `phone_no` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `card_number` char(60) COLLATE latin1_general_ci DEFAULT NULL,
  `card_expiry_date` date DEFAULT NULL,
  `card_security_digits` char(60) COLLATE latin1_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
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
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`id`, `payment_type_id`, `country_id`, `card_provider_id`, `start_date`, `end_date`, `total_rental_cost`, `first_name`, `middle_name`, `last_name`, `address`, `CPR`, `phone_no`, `card_number`, `card_expiry_date`, `card_security_digits`) VALUES
(0000000004, 1, 18, NULL, '2018-06-20', '2018-06-25', '50.000', '', '', '', 'road 6846 block 654 bld 6799 manama', 93579217, '6135468', NULL, NULL, NULL),
(0000000005, 1, 9, NULL, '2018-05-08', '2018-05-16', '200.000', '', '', '', '54251321rg 52', 3216546, '3213564684', NULL, NULL, NULL);

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
-- Creation: Jun 08, 2018 at 10:18 AM
--

DROP TABLE IF EXISTS `reservation_accessories`;
CREATE TABLE `reservation_accessories` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `accessory_id` smallint(5) UNSIGNED NOT NULL,
  `reservation_id` int(10) UNSIGNED NOT NULL,
  `reserve_qty` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `reservation_accessories`:
--   `accessory_id`
--       `accessories` -> `id`
--   `reservation_id`
--       `reservations` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `reservation_cars`
--
-- Creation: Jun 08, 2018 at 10:18 AM
--

DROP TABLE IF EXISTS `reservation_cars`;
CREATE TABLE `reservation_cars` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `reservation_id` int(10) UNSIGNED NOT NULL,
  `car_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `reservation_cars`:
--   `reservation_id`
--       `reservations` -> `id`
--   `car_id`
--       `cars` -> `id`
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
-- Creation: Jun 08, 2018 at 10:18 AM
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `role` char(5) COLLATE latin1_general_ci NOT NULL COMMENT 'default roles: admin, user',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `roles`:
--

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `sales_revenue_report`
--
-- Creation: Jun 08, 2018 at 10:18 AM
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
-- Dumping data for table `sales_revenue_report`
--

INSERT INTO `sales_revenue_report` (`id`, `transaction_id`, `transaction_date`, `transaction_amount`) VALUES
(4, 4, '2018-06-08', '50.000'),
(5, 5, '2018-06-09', '200.000');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--
-- Creation: Jun 08, 2018 at 10:18 AM
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
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `users`:
--

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `first_name`, `middle_name`, `last_name`) VALUES
(1, 'admin@rental.test', 'admin', 'Fatima', 'A.', 'Alansari');

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
-- Creation: Jun 08, 2018 at 10:18 AM
--

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONSHIPS FOR TABLE `user_roles`:
--   `user_id`
--       `users` -> `id`
--   `role_id`
--       `roles` -> `id`
--

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`) VALUES
(1, 1, 1);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payment_types`
--
ALTER TABLE `payment_types`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reservation_accessories`
--
ALTER TABLE `reservation_accessories`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservation_cars`
--
ALTER TABLE `reservation_cars`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sales_revenue_report`
--
ALTER TABLE `sales_revenue_report`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
