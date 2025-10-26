-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 25, 2025 at 11:57 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `exploresaudi`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_acc` ()   SELECT
a.id AS 'acc_id',
c.city_name,
a.type,
a.location,
a.accommodation_image AS 'acc_img',
a.services,
a.status,
a.phone
FROM accommodation a
INNER JOIN cities c ON a.city_id=c.id
WHERE a.status = '1'
ORDER BY a.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_acc_admin` ()   SELECT
a.id AS 'acc_id',
c.city_name,
a.type,
a.location,
a.accommodation_image,
a.services,
a.status,
a.phone
FROM accommodation a
INNER JOIN cities c ON a.city_id=c.id
ORDER BY a.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_acc_by_id` (IN `acc_id` INT)   SELECT
a.id AS 'acc_id',
c.id AS 'city_id',
c.city_name,
a.type,
a.location,
a.services,
a.phone
FROM accommodation a
INNER JOIN cities c ON a.city_id=c.id
WHERE a.id=acc_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_acc_types` ()   SELECT
*
FROM accommodation_types$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_acc_user` (IN `user_id` INT)   SELECT
a.id AS 'acc_id',
c.city_name,
a.type,
a.location,
a.accommodation_image,
a.services,
a.status,
a.phone
FROM accommodation a
INNER JOIN cities c ON a.city_id=c.id
WHERE a.u_id=user_id
ORDER BY a.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_users` ()   SELECT
*
FROM users
WHERE role!='admin'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_apps` ()   SELECT
app.id AS 'app_id',
app.title,
app.link,
app.image
FROM applications app$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cities` ()   SELECT
*
FROM cities c 
ORDER BY c.city_name ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_comments_by_place` (IN `place_id` INT)   SELECT
c.id AS 'comment_id',
c.comment,
c.rating,
c.comment_date,
u.username
FROM comments c
INNER JOIN places p ON c.place_id=p.id
INNER JOIN users u ON c.tourist_id=u.id
WHERE c.place_id=place_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_comments_by_user_id` (IN `user_id` INT)   SELECT
c.id AS 'comment_id',
c.comment,
c.rating,
c.comment_date
FROM comments c
WHERE c.tourist_id=user_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_events` ()   SELECT
e.id AS 'event_id',
c.city_name,
e.event_name,
e.date,
e.booking_link,
e.event_img,
e.status,
e.phone
FROM events e
INNER JOIN cities c ON e.city_id=c.id
WHERE e.status = '1'
ORDER BY e.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_events_admin` ()   SELECT
e.id AS 'event_id',
c.city_name,
e.event_name,
e.date,
e.booking_link,
e.event_img,
e.status,
e.phone
FROM events e
INNER JOIN cities c ON e.city_id=c.id
ORDER BY e.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_events_user` (IN `user_id` INT)   SELECT
e.id AS 'event_id',
c.city_name,
e.event_name,
e.date,
e.booking_link,
e.event_img,
e.status,
e.phone
FROM events e
INNER JOIN cities c ON e.city_id=c.id
WHERE e.u_id=user_id
ORDER BY e.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_event_by_id` (IN `event_id` INT)   SELECT
e.id AS 'event_id',
c.id AS 'city_id',
c.city_name,
e.event_name,
e.date,
e.booking_link,
e.phone
FROM events e
INNER JOIN cities c ON e.city_id=c.id
WHERE e.id=event_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fav_acc_by_user_id` (IN `user_id` INT)   SELECT
fa.id AS 'fav_acc_id',
c.city_name,
a.id AS 'acc_id',
a.type,
a.location,
a.accommodation_image AS 'acc_img',
a.services,
a.phone
FROM fav_accommodation fa
INNER JOIN accommodation a ON fa.acc_id=a.id
INNER JOIN cities c ON a.city_id=c.id
WHERE fa.user_id=user_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fav_event_by_user_id` (IN `user_id` INT)   SELECT
fe.id 'fe_id',
c.city_name,
e.event_name,
e.event_img,
e.date,
e.booking_link,
e.phone
FROM fav_events fe
INNER JOIN events e ON fe.event_id=e.id
INNER JOIN cities c ON e.city_id=c.id
WHERE fe.user_id=user_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fav_places_by_user_id` (IN `user_id` INT)   SELECT
fp.id AS 'fp_id',
p.id AS 'place_id',
c.city_name,
p.type,
p.location,
p.place_img,
p.description,
p.phone
FROM fav_places fp
INNER JOIN places p ON fp.place_id=p.id
INNER JOIN cities c ON p.city_id=c.id
WHERE fp.user_id=user_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_places` ()   SELECT
p.id AS 'place_id',
c.city_name,
p.type,
p.location,
p.place_img,
p.description,
p.status,
p.phone
FROM places p
INNER JOIN cities c ON p.city_id=c.id
WHERE p.status = '1'
ORDER BY p.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_places_admin` ()   SELECT
p.id AS 'place_id',
c.city_name,
p.type,
p.location,
p.place_img,
p.description,
p.status,
p.phone
FROM places p
INNER JOIN cities c ON p.city_id=c.id
ORDER BY p.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_places_by_id` (IN `place_id` INT)   SELECT
p.id AS 'place_id',
c.id AS 'city_id',
c.city_name,
p.type,
p.location,
p.description,
p.phone
FROM places p
INNER JOIN cities c ON p.city_id=c.id
WHERE p.id=place_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_places_user` (IN `user_id` INT)   SELECT
p.id AS 'place_id',
c.city_name,
p.type,
p.location,
p.place_img,
p.description,
p.status,
p.phone
FROM places p
INNER JOIN cities c ON p.city_id=c.id
WHERE p.u_id=user_id ORDER BY p.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_place_types` ()   SELECT
*
FROM place_types$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `accommodation`
--

CREATE TABLE `accommodation` (
  `id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'hotel',
  `location` varchar(255) NOT NULL,
  `accommodation_image` text DEFAULT NULL,
  `services` text NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `u_id` int(11) NOT NULL,
  `status` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accommodation`
--

INSERT INTO `accommodation` (`id`, `city_id`, `type`, `location`, `accommodation_image`, `services`, `phone`, `u_id`, `status`) VALUES
(1, 7, 'فندق', 'https://maps.app.goo.gl/bPDHbgidZwUAmUtt6?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 10.17.55 AM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(2, 7, 'فندق', 'https://maps.app.goo.gl/w9JQdWwLn8UmkYgDA?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 10.18.50 AM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(3, 7, 'فندق', 'https://maps.app.goo.gl/w9JQdWwLn8UmkYgDA?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 10.21.31 AM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(4, 7, 'شقة', 'https://maps.app.goo.gl/BjM8auqyZ4AvxrDw8?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 10.34.45 AM.jpeg', 'Rooms , suites , wifi , parking ', '057696787898', 3, '1'),
(5, 7, 'شقة', 'https://maps.app.goo.gl/vLTwCniDFmBjXNTNA?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 10.38.43 AM.jpeg', 'Rooms , suites , wifi , parking ', '057696787898', 3, '1'),
(6, 2, 'شقة', 'https://maps.app.goo.gl/Tv1SA66p4JLtdc6A8?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 10.51.32 AM.jpeg', 'Rooms , suites , wifi , parking ', '057696787898', 3, '1'),
(7, 2, 'شقة', 'https://maps.app.goo.gl/vEVRoGhCsVqjkKu97?g_st=ic', './img/accommodation/WhatsApp Image 2025-04-09 at 10.53.04 AM.jpeg', 'Rooms , suites , wifi , parking ', '057696787898', 3, '1'),
(8, 2, 'فندق', 'https://maps.app.goo.gl/D71JqbwAxRWoic268?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 10.53.19 AM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(9, 2, 'فندق', 'https://maps.app.goo.gl/w49zefoZahUbKcwx6?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 10.54.36 AM (1).jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(10, 2, 'فندق', 'https://maps.app.goo.gl/DARkzzSMVyEfmGX89?g_st=ic', './img/accommodation/WhatsApp Image 2025-04-09 at 10.58.24 AM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(11, 10, 'فندق', 'https://maps.app.goo.gl/ixnAxdWvXpddqNpY9?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 11.22.50 AM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(12, 10, 'فندق', 'https://maps.app.goo.gl/GN1E4Bw16wYS8UYa7?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 11.24.22 AM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(13, 10, 'فندق', 'https://maps.app.goo.gl/qBs5ejPAG493tzP29?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 11.25.32 AM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(14, 10, 'شقة', 'https://maps.app.goo.gl/1JV9z8VwRCCCSozD8?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 11.25.52 AM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(15, 10, 'شقة', 'https://maps.app.goo.gl/TwXeC5NsvAisDP4f6?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-09 at 11.27.02 AM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(16, 9, 'فندق', 'https://maps.app.goo.gl/oBEPRbL7myyePTEa7?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-13 at 2.19.44 PM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(17, 9, 'فندق', 'https://maps.app.goo.gl/86LkNep4r5nyRAfs5?g_st=ic', './img/accommodation/WhatsApp Image 2025-04-13 at 2.21.00 PM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(18, 9, 'فندق', 'https://maps.app.goo.gl/dQC5HiWiBTme6VU26?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-13 at 2.23.41 PM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(19, 9, 'شقة', 'https://maps.app.goo.gl/s1ANgw6aChb1qvEm7?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-13 at 2.41.38 PM.jpeg', 'Rooms , suites , wifi , parking ', '057696787898', 3, '1'),
(20, 9, 'شقة', 'https://maps.app.goo.gl/qNTyF9mPJt43yuYKA?g_st=ic', './img/accommodation/WhatsApp Image 2025-04-13 at 2.47.40 PM.jpeg', 'Rooms , suites , wifi , parking ', '057696787898', 3, '1'),
(21, 5, 'فندق', 'https://maps.app.goo.gl/kaTv65acs24xkV9V9?g_st=ic', './img/accommodation/WhatsApp Image 2025-04-13 at 3.08.21 PM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(22, 5, 'فندق', 'https://maps.app.goo.gl/6tHRVbaXTAGh8Uzm9?g_st=iw', './img/accommodation/WhatsApp Image 2025-04-13 at 3.09.29 PM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(23, 5, 'فندق', 'https://maps.app.goo.gl/9bPcb5HSA3hW7RHs7?g_st=ic', './img/accommodation/WhatsApp Image 2025-04-13 at 3.10.34 PM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(24, 5, 'شقة', 'https://maps.app.goo.gl/vLFNFC5supjWsjV46?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-13 at 3.11.45 PM.jpeg', 'Rooms , suites , wifi , parking ', '057696787898', 3, '1'),
(25, 5, 'شقة', 'https://maps.app.goo.gl/fVLoFCTiLmK8PAXE6?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-13 at 3.12.32 PM.jpeg', 'Rooms , suites , wifi , parking ', '057696787898', 3, '1'),
(26, 8, 'فندق', 'https://maps.app.goo.gl/bmv5KCjSTFwTAcZ69?g_st=ic', './img/accommodation/WhatsApp Image 2025-04-13 at 7.43.28 PM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(27, 8, 'فندق', 'https://maps.app.goo.gl/Az5PQJqdefJfrXwf9?g_st=ic', './img/accommodation/WhatsApp Image 2025-04-13 at 7.47.10 PM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(28, 8, 'فندق', 'https://maps.app.goo.gl/8X1XnDLYESexriXw9?g_st=ic', './img/accommodation/WhatsApp Image 2025-04-13 at 7.49.58 PM.jpeg', 'Rooms , suites , wifi , parking , food , laundry', '057696787898', 3, '1'),
(29, 8, 'شقة', 'https://maps.app.goo.gl/mufpP8Sag3EiYKvt9?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-13 at 7.48.51 PM.jpeg', 'Rooms , suites , wifi , parking ', '057696787898', 3, '1'),
(30, 8, 'شقة', 'https://maps.app.goo.gl/yW1UsFZFmbo1szdP9?g_st=com.google.maps.preview.copy', './img/accommodation/WhatsApp Image 2025-04-13 at 7.47.29 PM.jpeg', 'Rooms , suites , wifi , parking ', '057696787898', 3, '1');

-- --------------------------------------------------------

--
-- Table structure for table `accommodation_types`
--

CREATE TABLE `accommodation_types` (
  `id` int(11) NOT NULL,
  `types` varchar(255) NOT NULL DEFAULT 'hotel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accommodation_types`
--

INSERT INTO `accommodation_types` (`id`, `types`) VALUES
(1, 'شقة'),
(3, 'فندق');

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `link` varbinary(255) NOT NULL,
  `image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`id`, `title`, `link`, `image`) VALUES
(10, 'وصليني', 0x68747470733a2f2f7777772e77396c696e692e636f6d2f, './img/app/WhatsApp Image 2025-04-13 at 8.10.47 PM.jpeg'),
(11, 'تويو', 0x68747470733a2f2f746f796f752e696f2f61722f7269796164682f, './img/app/WhatsApp Image 2025-04-13 at 8.11.31 PM.jpeg'),
(12, 'جيني', 0x68747470733a2f2f7777772e6a65656e792e6d652f61722f, './img/app/WhatsApp Image 2025-04-13 at 8.13.23 PM.jpeg'),
(13, 'كريم', 0x68747470733a2f2f7777772e63617265656d2e636f6d2f, './img/app/WhatsApp Image 2025-04-13 at 8.14.20 PM.jpeg'),
(14, 'كيتا', 0x68747470733a2f2f7777772e6b656574612d676c6f62616c2e636f6d2f, './img/app/WhatsApp Image 2025-04-13 at 8.15.50 PM.jpeg'),
(15, 'كيان', 0x68747470733a2f2f6b616969616e2e636f6d2f, './img/app/WhatsApp Image 2025-04-13 at 8.15.11 PM.jpeg'),
(16, 'ذا شفز', 0x68747470733a2f2f746865636865667a2e636f2f, './img/app/WhatsApp Image 2025-04-13 at 8.17.41 PM.jpeg'),
(17, 'نعناع', 0x68747470733a2f2f73746f72652e6e616e612e636f2f, './img/app/WhatsApp Image 2025-04-13 at 8.17.10 PM.jpeg'),
(18, 'نينجا', 0x68747470733a2f2f7777772e616e616e696e6a612e636f6d2f, './img/app/WhatsApp Image 2025-04-13 at 8.07.15 PM (1).jpeg'),
(19, 'جاهز', 0x68747470733a2f2f7777772e6a6168657a2e6e65742f, './img/app/WhatsApp Image 2025-04-13 at 8.08.44 PM.jpeg'),
(20, 'هنقرستيشن', 0x68747470733a2f2f68756e67657273746174696f6e2e636f6d2f, './img/app/WhatsApp Image 2025-04-13 at 8.10.14 PM (1).jpeg'),
(21, 'مرسول', 0x68747470733a2f2f6d72736f6f6c2e636f2f, './img/app/WhatsApp Image 2025-04-13 at 8.10.13 PM (1).jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `city_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `city_name`) VALUES
(2, 'الرياض'),
(5, 'مكه'),
(7, 'ابها'),
(8, 'المنطقة الشرقية'),
(9, 'العلا'),
(10, 'جدة');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `rating` int(11) NOT NULL,
  `tourist_id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `comment_date` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `comment`, `rating`, `tourist_id`, `place_id`, `comment_date`) VALUES
(10, 'رائعع', 5, 2, 52, '2025-04-17'),
(11, 'جميللل', 0, 2, 51, '2025-04-17'),
(12, 'جميلللل', 0, 2, 50, '2025-04-17'),
(13, 'افضل مطعم ايطالي', 5, 2, 49, '2025-04-17'),
(14, 'طعمه لذيذ', 5, 2, 48, '2025-04-17'),
(15, 'المطعم رااااائع، الأكل نظيف ولذيييذ بشكل!', 5, 2, 39, '2025-04-17'),
(16, 'الاكل يشهي يستاهل كل ريال', 4, 2, 47, '2025-04-17'),
(17, 'من اجمل الفروع ', 4, 2, 44, '2025-04-17'),
(18, 'قهوتهم لذيذه', 0, 2, 43, '2025-04-17'),
(19, 'مطعمي المفضل في مكه', 5, 2, 40, '2025-04-17'),
(20, 'لذيذذذ انصحكم فيه', 4, 2, 37, '2025-04-17'),
(21, 'طبعا مايحتاج كلام ، كافيه مميز جدا', 5, 2, 42, '2025-04-17'),
(22, 'ما شاء الله تبارك الله كل شي جميل من مكان ولا قهوة ولا اسلوب و تعامل الموظفين الله يعطيكم العافية ويزيدكم ولا ينقصكم شغل نظيف و جبار\r\nسعدت بتجربتي لقهوة جزء كل شي لذيذ واعجبني شكرا لكم', 5, 2, 38, '2025-04-17'),
(23, 'مقهى جميل و مرتب و هادى\r\nو قهوه اليوم حلوه\r\nو خدمة ممتازه', 0, 2, 30, '2025-04-17'),
(24, 'v60 الي أقدر أقول انه فوق التقييم', 4, 2, 36, '2025-04-17'),
(25, 'المطعم جميل ومميز جلساته فخمه أجوائه حلوه وهادئه وجباته جيد جدا الطاقم مميزين وودودين', 4, 2, 35, '2025-04-17'),
(26, 'مطعم رائع وجميل ويستحق الزيارة لأكثر من مررررة الطعم خيااال يفوز بكل شي في المنيو والعاملين خدمته رائعه جدا.', 4, 2, 33, '2025-04-17'),
(27, 'فعلااااا رائع انصحكم فيه', 3, 2, 34, '2025-04-17'),
(28, 'من اروع كافيهات جده', 4, 2, 32, '2025-04-17'),
(29, 'ماشاء الله تبارك الله القهوه ولا غلطة تستحق الزياره', 4, 2, 31, '2025-04-17'),
(30, 'طلبت برقر فرايد تشيكن وكيرلي فرايز لذيذ لذيذ بشكل غير طبيعي واخلاق العماله الموجودين ممتازه جداً وجودة الأكل والأسعار كمان شيء خرافي مطعم متكامل بمعنى الكلمه اتمنى مايتغير ويقعد على هذا المستوى الفوق رااائع وجاري تجربة بقيه الأصناف الموجوده❤‍🔥❤‍🔥❤‍🔥', 5, 2, 29, '2025-04-17'),
(31, 'تجربه ممتازة ولا اروع لحم طازج ومشويات ممتازه', 0, 2, 28, '2025-04-17'),
(32, 'ماشاء الله مطعم مميز ومتخصص في المأكولات البحريه . والسمك عندهم فريش واسعار معقوله ', 3, 2, 27, '2025-04-17'),
(33, 'انا مو من عشاق القهوه بس قهوتهم مررره حلوه السقنتشر درينك حقهم مره لذذذيذ مع الكريمه والمشروب حالي ومر بنفس الوقت!! مره حبيت ان شاءالله لي زيارة تانية والسويت حقهم  اظن تشوكلت كيك مع كذا صوص من التشوكلت لذذذيذ مغرق تشوكلت،،', 5, 2, 24, '2025-04-17'),
(34, 'اللي يفكر يروح له\r\nيروح بدون تردد من احلى الكوفيهات اللي فتحت رهيبن بشكل لامن خدمه ولا قهوة خييييالي كلمة حق\r\nواللاين خفيف وسريييع لاحد يفوته وبس', 5, 2, 25, '2025-04-17'),
(35, 'اخذت قهوة اليوم بارده حلوه و فلات وايت ممتاز و كوكيز ميني و كيكة عسل بايتس لذييييييذه وطعمها جميل', 4, 2, 26, '2025-04-17'),
(36, 'مطعم لوسين من المطاعم اللي أرجع لها مره ومرتين وعشر المكان بشكل عام مميز الإطلالة جميلة الأجواء هادية ورايقة تعامل الموظفين رائع وممتاز الأكل لذيذ وسرعة تجهيز الطلب رائعة 👍🏻👍🏻👍🏻👍🏻', 5, 2, 23, '2025-04-17'),
(37, 'أول مره أزورهم ..طلبت ستيك بصوص الليمون لذيذ جداً بس ياليت يزيدون الكمية ..وطلبنا باستا 🍝 بالبشاميل رهيبه ..', 4, 2, 22, '2025-04-17'),
(38, 'وجهتي الأولى لما أحتاج جرعة سوشي. العادة أطلب توصيل من المطعم لكن الأكل في الفرع أحلى بالنسبة لي. الفرع هادي و الخدمة جيدة.', 4, 2, 21, '2025-04-18'),
(39, 'لافش من اجمل مقاهي في ابها متجدد ومكان مريحه للعائلات والشباب، قهوتهم لذيذة سواء بالحليب او قهوة اليوم او مقطره رحت لهم اكثر الاوقات الجوده نفسها موظفين مميزين ، فرنش توست رهيب وكيكه تشوكلت وجديد تشيز بيكان ، تقديم الشوكلت الساخنه جميل ولذيذ', 5, 2, 19, '2025-04-18'),
(40, 'دايم ازوره جميل جدا ورايق  قهوتهم حلوه  v60\r\nوالحلى اغلبه جدا لذيذ ..\r\nوالخدمه سريعه ومحترمين.. يعطيهم العافيه', 4, 2, 18, '2025-04-18'),
(41, 'من الكوفيهات المميزة، الأجواء شتوية جميلة، المخبوزات والحلا متنوعة ولذيذة، والخدمة سريعة،', 4, 2, 17, '2025-04-18'),
(42, 'بنسبه لي تجربتي جميله جداً واكررها طبعاً الاطباق لذيذه وجمال المكان وهادئ انصحكم في الباستا والبيتزا لذيذيييين مره من الذ المطاعم الايطاليه 😋', 5, 2, 16, '2025-04-18'),
(43, 'مطعم جميل وراقي قمة في التعامل واكل لذيذ وأسعار مناسبة نسبياً ونظيف جدا  انا جيت بعد الظهر قمة في الهدوء\r\nانصح الجميع بتجربتة', 3, 2, 15, '2025-04-18'),
(44, 'مطعم الشوكة التركية ، طلبنا مشاوي مشكل وسط\r\nورز بالشعيريه و صحن شاورما دجاج وريش غنم وحمص\r\nوالمشروبات بيبسي وسفن اب وعصير ليمون\r\nوالسلطه الحاره مجانيه\r\nالاكل كان لذيذ والمكان جميل ومرتب\r\n', 0, 2, 14, '2025-04-18'),
(45, 'رائع', 5, 4, 52, '2025-04-26');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `event_name` varchar(255) NOT NULL,
  `date` date DEFAULT NULL,
  `booking_link` varchar(255) DEFAULT NULL,
  `event_img` text DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `u_id` int(11) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `city_id`, `event_name`, `date`, `booking_link`, `event_img`, `phone`, `u_id`, `status`) VALUES
(1, 7, '\"رمضانا \"المفتاحة', '2025-03-01', 'https://abha.platinumlist.net/ar/event-tickets/98220/muftaha-village', './img/event_/WhatsApp Image 2025-04-09 at 10.26.26 AM.jpeg', '057696787898', 3, '1'),
(2, 7, 'بسطة القابل', '2025-03-01', 'https://abha.platinumlist.net/ar/event-tickets/bstah', './img/event_/WhatsApp Image 2025-04-09 at 10.28.12 AM.jpeg', '057696787898', 3, '1'),
(3, 7, 'أرياش', '2025-02-01', 'https://abha.platinumlist.net/ar/event-tickets/97488/aryash-in-abha', './img/event_/WhatsApp Image 2025-04-09 at 10.27.15 AM.jpeg', '057696787898', 3, '1'),
(4, 2, 'موسم الرياض \"بوليفارد وورلد\" ', '2024-10-13', 'https://webook.com/ar/zones/boulevard-world', './img/event_/WhatsApp Image 2025-04-09 at 11.00.34 AM.jpeg', '057696787898', 3, '1'),
(6, 2, 'معرض الكتاب', '2025-09-26', 'https://webook.com/ar/events/riyadh-international-book-fair-tickets', './img/event_/WhatsApp Image 2025-04-09 at 11.05.43 AM.jpeg', '057696787898', 3, '1'),
(7, 2, 'موسم الدرعية', '2025-02-11', 'https://www.diriyah.sa/ar', './img/event_/WhatsApp Image 2025-04-09 at 11.03.44 AM (1).jpeg', '057696787898', 3, '1'),
(8, 10, 'الفورميلا', '2025-04-18', 'https://jeddah.platinumlist.net/ar/?gad_source=1&gbraid=0AAAAA-zqIovPKwXo6bhLKMEgpGS4dbJnC&gclid=EAIaIQobChMI3M2SwcPKjAMVWWhBAh3WCyUuEAAYAiAAEgLQ0PD_BwE', './img/event_/WhatsApp Image 2025-04-09 at 11.28.20 AM.jpeg', '057696787898', 3, '0'),
(9, 10, 'جدة التاريخية', '2024-01-01', 'https://www.visitsaudi.com/ar/jeddah/attractions/summer-night-adventures-in-al-balad', './img/event_/WhatsApp Image 2025-04-09 at 11.29.31 AM.jpeg', '057696787898', 3, '1'),
(10, 10, 'بينالي الفنون الاسلامية', '2025-01-25', 'https://biennale.org.sa/en', './img/event_/WhatsApp Image 2025-04-09 at 11.35.15 AM.jpeg', '057696787898', 3, '1'),
(11, 9, 'مهرجان سماء العلا', '2025-04-18', 'https://experiencealula.app.link/QuoCLpE2wSb', './img/event_/WhatsApp Image 2025-04-13 at 2.24.24 PM.jpeg', '057696787898', 3, '1'),
(12, 9, 'جولة دادان وجبل عكمة', '2024-04-01', 'https://experiencealula.app.link/8eWghqZ1wSb', './img/event_/WhatsApp Image 2025-04-13 at 2.15.07 PM.jpeg', '057696787898', 3, '1'),
(13, 9, 'جولة الحجر', '2024-04-01', 'https://experiencealula.app.link/Xw692GX1wSb', './img/event_/WhatsApp Image 2025-04-13 at 2.12.31 PM.jpeg', '057696787898', 3, '1'),
(14, 5, 'متحف برج الساعة', '2025-01-13', 'https://maps.app.goo.gl/ysQZLWk7EPsSV8oX9?g_st=com.google.maps.preview.copy', './img/event_/WhatsApp Image 2025-04-13 at 7.10.45 PM.jpeg', '057696787898', 3, '1'),
(15, 5, 'المتحف الدولي للسيرة النبوية', '2025-01-13', 'https://maps.app.goo.gl/VXYCYwWCY1jZXWhi6?g_st=com.google.maps.preview.copy', './img/event_/WhatsApp Image 2025-04-13 at 7.08.35 PM.jpeg', '057696787898', 3, '1'),
(16, 5, 'معرض عمارة الحرمين الشريفين', '2025-01-13', 'https://maps.app.goo.gl/x7iLMTMyijTYE2dA7?g_st=com.google.maps.preview.copy', './img/event_/WhatsApp Image 2025-04-13 at 7.05.07 PM.jpeg', '057696787898', 3, '1'),
(17, 8, 'اثراء(الظهران)', '2025-01-01', 'http://ithra.cc/3KtnBap', './img/event_/WhatsApp Image 2025-04-13 at 6.25.50 PM (1).jpeg', '057696787898', 3, '1'),
(18, 8, 'تكية بحر(الدمام)', '2025-01-01', 'https://dammam.platinumlist.net/ar/event-tickets/takyt-bahar', './img/event_/WhatsApp Image 2025-04-13 at 6.33.18 PM.jpeg', '057696787898', 3, '1'),
(19, 8, ' مدينة العجائب (الدمام)', '2025-01-01', 'https://dammam.platinumlist.net/ar/event-tickets/city-of-wonders', './img/event_/WhatsApp Image 2025-04-13 at 6.45.21 PM.jpeg', '057696787898', 3, '1');

-- --------------------------------------------------------

--
-- Table structure for table `fav_accommodation`
--

CREATE TABLE `fav_accommodation` (
  `id` int(11) NOT NULL,
  `acc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fav_accommodation`
--

INSERT INTO `fav_accommodation` (`id`, `acc_id`, `user_id`) VALUES
(0, 30, 4);

-- --------------------------------------------------------

--
-- Table structure for table `fav_events`
--

CREATE TABLE `fav_events` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fav_events`
--

INSERT INTO `fav_events` (`id`, `event_id`, `user_id`) VALUES
(0, 18, 4);

-- --------------------------------------------------------

--
-- Table structure for table `fav_places`
--

CREATE TABLE `fav_places` (
  `id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fav_places`
--

INSERT INTO `fav_places` (`id`, `place_id`, `user_id`) VALUES
(0, 52, 2),
(0, 49, 2),
(0, 38, 2),
(0, 35, 2),
(0, 52, 4);

-- --------------------------------------------------------

--
-- Table structure for table `places`
--

CREATE TABLE `places` (
  `id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `type` varchar(255) DEFAULT 'restaurant',
  `location` varchar(255) NOT NULL,
  `place_img` text DEFAULT NULL,
  `description` text NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `u_id` int(11) NOT NULL,
  `status` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `places`
--

INSERT INTO `places` (`id`, `city_id`, `type`, `location`, `place_img`, `description`, `phone`, `u_id`, `status`) VALUES
(14, 7, 'مطعم', 'https://maps.app.goo.gl/zmHYyuwF3qB2t6DF9?g_st=com.google.maps.preview.copy', './img/place/شوك.jpeg', 'مطعم مأكولات تركية', '057696787898', 3, '1'),
(15, 7, 'مطعم', 'https://maps.app.goo.gl/CDsDdnBMR5FxywAcA?g_st=com.google.maps.preview.copy', './img/place/تولاي.jpeg', 'مطعم مأكولات تركية', '057696787898', 3, '1'),
(16, 7, 'مطعم', 'https://maps.app.goo.gl/SpfEPqremRAc91M76?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 10.09.47 AM.jpeg', 'مطعم مأكولات إيطالية', '057696787898', 3, '1'),
(17, 7, 'كافيه', 'https://maps.app.goo.gl/X2cGf18tKX6YCM1NA?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 10.12.27 AM.jpeg', 'محمصة ومخبوزات ريب', '057696787898', 3, '1'),
(18, 7, 'كافيه', 'https://maps.app.goo.gl/RK22qGbuGVv2nhKc6?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 10.12.47 AM.jpeg', 'كافيه', '057696787898', 3, '1'),
(19, 7, 'كافيه', 'https://maps.app.goo.gl/thHxJTpFdFGLMpgNA?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 10.16.10 AM.jpeg', 'كافيه', '057696787898', 3, '1'),
(21, 2, 'مطعم', 'https://maps.app.goo.gl/6FZEUd96u6KsCPTX9?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 10.42.10 AM.jpeg', 'مطعم سوشي', '057696787898', 3, '1'),
(22, 2, 'مطعم', 'https://maps.app.goo.gl/BmA6shtqHgz5UmCZ6?g_st=ic', './img/place/WhatsApp Image 2025-04-09 at 10.42.27 AM (1).jpeg', 'مطعم مأكولات إيطالية', '057696787898', 3, '1'),
(23, 2, 'مطعم', 'https://maps.app.goo.gl/TKvYxQpodwN1TxCr6?g_st=ic', './img/place/WhatsApp Image 2025-04-09 at 10.44.40 AM.jpeg', 'مطعم مأكولات ارميني', '057696787898', 3, '1'),
(24, 2, 'كافيه', 'https://maps.app.goo.gl/9HjriAtyaLFgLQGv8?g_st=ic', './img/place/WhatsApp Image 2025-04-09 at 10.47.03 AM.jpeg', 'كافيه', '057696787898', 3, '1'),
(25, 2, 'كافيه', 'https://maps.app.goo.gl/weY1cBkTVzurPkLQ7?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 10.48.19 AM.jpeg', 'كافيه', '057696787898', 3, '1'),
(26, 2, 'كافيه', 'https://maps.app.goo.gl/weY1cBkTVzurPkLQ7?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 10.49.50 AM.jpeg', 'كافيه', '057696787898', 3, '1'),
(27, 10, 'مطعم', 'https://maps.app.goo.gl/2EBUnzgcmdxcd3wJ6?g_st=ic', './img/place/WhatsApp Image 2025-04-09 at 11.14.39 AM.jpeg', 'مطعم مأكولات بحرية', '057696787898', 3, '1'),
(28, 10, 'مطعم', 'https://maps.app.goo.gl/NoPqAUTfxszV3RkJ8?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 11.13.48 AM.jpeg', 'مطعم مأكولات مشوية', '057696787898', 3, '1'),
(29, 10, 'مطعم', 'https://maps.app.goo.gl/m2brriEyQpqNeQpx8?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 11.12.23 AM.jpeg', 'مطعم مأكولات امريكية', '057696787898', 3, '1'),
(30, 10, 'كافيه', 'https://maps.app.goo.gl/jDpf9K8W6iASKXGv5?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 11.20.38 AM.jpeg', 'كافيه', '057696787898', 3, '1'),
(31, 10, 'كافيه', 'https://maps.app.goo.gl/tHNrWA5RnSuV7vwg7?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 11.20.52 AM.jpeg', 'كافيه', '057696787898', 3, '1'),
(32, 10, 'كافيه', 'https://maps.app.goo.gl/bPbUmM4swSntg6F48?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-09 at 11.21.06 AM.jpeg', 'كافيه', '057696787898', 3, '1'),
(33, 9, 'مطعم', 'https://maps.app.goo.gl/7viq3ZKhpHLQzvMFA?g_st=ic', './img/place/WhatsApp Image 2025-04-13 at 1.57.38 PM.jpeg', 'أشهى المأكولات اليونانية بلمسة عصرية مع أروع المناظر من مطل الحرة', '057696787898', 3, '1'),
(34, 9, 'مطعم', 'https://maps.app.goo.gl/WknhqxkM9LyfhyYW7?g_st=ic', './img/place/WhatsApp Image 2025-04-13 at 1.56.58 PM.jpeg', 'مأكولات غنيّة بالنكهات الأصيلة من روائع المطبخ السعودي في قلب تيماء', '057696787898', 3, '1'),
(35, 9, 'مطعم', 'https://maps.app.goo.gl/tTBrwMEqpmZpsqdw6?g_st=ic', './img/place/WhatsApp Image 2025-04-13 at 1.56.01 PM.jpeg', 'وصفات لبنانية أصيلة مع أجواء راقية وتصاميم أنيقة', '057696787898', 3, '1'),
(36, 9, 'كافيه', 'https://maps.app.goo.gl/Hg7cSaEJrmMWKArV6?g_st=ic', './img/place/WhatsApp Image 2025-04-13 at 1.58.35 PM.jpeg', 'كافيه', '057696787898', 3, '1'),
(37, 9, 'كافيه', 'https://maps.app.goo.gl/w9LuEBC2Ab1rvMh6A?g_st=ic', './img/place/WhatsApp Image 2025-04-13 at 2.01.12 PM.jpeg', 'كافيه', '057696787898', 3, '1'),
(38, 9, 'كافيه', 'https://maps.app.goo.gl/AcZumFAZrE73NhYb9?g_st=ic', './img/place/WhatsApp Image 2025-04-13 at 2.04.11 PM.jpeg', 'كافيه', '057696787898', 3, '1'),
(39, 5, 'مطعم', 'https://maps.app.goo.gl/Y6Ba8FnbwPg6vTb86?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 3.18.34 PM.jpeg', 'مطعم مأكولات لبنانية', '057696787898', 3, '1'),
(40, 5, 'مطعم', 'https://maps.app.goo.gl/UaTPw8pQ9NPbBV648?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 3.20.45 PM.jpeg', 'مطعم مأكولات تركية', '057696787898', 3, '1'),
(41, 5, 'مطعم', 'https://maps.app.goo.gl/Ln2Y7DRvMTSxv3N96?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 3.24.53 PM.jpeg', 'مطعم مأكولات هندية', '057696787898', 3, '1'),
(42, 5, 'كافيه', 'https://maps.app.goo.gl/PYVk3Kx8inGxyZb87?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 3.27.09 PM.jpeg', 'كافيه', '057696787898', 3, '1'),
(43, 5, 'كافيه', 'https://maps.app.goo.gl/aRgiRGxF8bxzgBaz6?g_st=ic', './img/place/WhatsApp Image 2025-04-13 at 3.30.31 PM.jpeg', 'كافيه', '057696787898', 3, '1'),
(44, 5, 'كافيه', 'https://maps.app.goo.gl/DEVMBEfSHvsB6CT68?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 3.30.38 PM.jpeg', 'كافيه', '057696787898', 3, '1'),
(47, 8, 'مطعم', 'https://maps.app.goo.gl/YVyFyWvAwimb4KwBA?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 6.56.44 PM.jpeg', 'مطعم مأكولات قارية (الخبر)', '057696787898', 3, '1'),
(48, 8, 'مطعم', 'https://maps.app.goo.gl/ZGzRrzvs7LUdRDiQ8?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 6.56.45 PM (2).jpeg', 'مطعم مأكولات تركية', '057696787898', 3, '1'),
(49, 8, 'مطعم', 'https://maps.app.goo.gl/udXoZshiKWc6Shxs6?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 6.56.45 PM (3).jpeg', 'مطعم مأكولات إيطالية', '057696787898', 3, '1'),
(50, 8, 'كافيه', 'https://maps.app.goo.gl/pRomTuEiJiiGmex86?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 7.36.12 PM.jpeg', 'كافيه', '057696787898', 3, '1'),
(51, 8, 'كافيه', 'https://maps.app.goo.gl/5tetV47xo6KWtwDw8?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 7.36.13 PM.jpeg', 'كافيه', '+966 5215151251', 3, '1'),
(52, 8, 'كافيه', 'https://maps.app.goo.gl/HkidkxpNf59Nuskp7?g_st=com.google.maps.preview.copy', './img/place/WhatsApp Image 2025-04-13 at 7.36.13 PM (1).jpeg', 'كافيه', '+966 5215151251', 3, '1');

-- --------------------------------------------------------

--
-- Table structure for table `place_types`
--

CREATE TABLE `place_types` (
  `id` int(11) NOT NULL,
  `types` varchar(255) NOT NULL DEFAULT 'restaurant'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `place_types`
--

INSERT INTO `place_types` (`id`, `types`) VALUES
(1, 'restaurant'),
(2, 'كافيه'),
(7, 'مطعم'),
(8, 'Cafe');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` text NOT NULL,
  `role` enum('admin','tourist','local') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_nopad_ci NOT NULL DEFAULT 'tourist',
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `status`) VALUES
(1, 'admin', 'admin@gmail.com', '4297f44b13955235245b2497399d7a93', 'admin', '1'),
(2, 'tourist', 'tourist@gmail.com', '4297f44b13955235245b2497399d7a93', 'tourist', '1'),
(3, 'local', 'local@gmail.com', '4297f44b13955235245b2497399d7a93', 'local', '1'),
(4, 'James', 'tourist1@gmail.com', '4297f44b13955235245b2497399d7a93', 'tourist', '1'),
(5, 'tourist ola', 'touristola@gmail.com', '4297f44b13955235245b2497399d7a93', 'tourist', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accommodation`
--
ALTER TABLE `accommodation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `u_id` (`u_id`);

--
-- Indexes for table `accommodation_types`
--
ALTER TABLE `accommodation_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tourist_id` (`tourist_id`),
  ADD KEY `comments_ibfk_1` (`place_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `u_id` (`u_id`);

--
-- Indexes for table `places`
--
ALTER TABLE `places`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `u_id` (`u_id`);

--
-- Indexes for table `place_types`
--
ALTER TABLE `place_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accommodation`
--
ALTER TABLE `accommodation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `accommodation_types`
--
ALTER TABLE `accommodation_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `places`
--
ALTER TABLE `places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `place_types`
--
ALTER TABLE `place_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accommodation`
--
ALTER TABLE `accommodation`
  ADD CONSTRAINT `accommodation_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
  ADD CONSTRAINT `accommodation_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`tourist_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `places`
--
ALTER TABLE `places`
  ADD CONSTRAINT `places_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
  ADD CONSTRAINT `places_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
