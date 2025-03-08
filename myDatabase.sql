/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.8-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: eduway_db
-- ------------------------------------------------------
-- Server version	10.11.8-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES
(1,'Can add user',1,'add_customuser'),
(2,'Can change user',1,'change_customuser'),
(3,'Can delete user',1,'delete_customuser'),
(4,'Can view user',1,'view_customuser'),
(5,'Can add log entry',2,'add_logentry'),
(6,'Can change log entry',2,'change_logentry'),
(7,'Can delete log entry',2,'delete_logentry'),
(8,'Can view log entry',2,'view_logentry'),
(9,'Can add permission',3,'add_permission'),
(10,'Can change permission',3,'change_permission'),
(11,'Can delete permission',3,'delete_permission'),
(12,'Can view permission',3,'view_permission'),
(13,'Can add group',4,'add_group'),
(14,'Can change group',4,'change_group'),
(15,'Can delete group',4,'delete_group'),
(16,'Can view group',4,'view_group'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add lesson',7,'add_lesson'),
(26,'Can change lesson',7,'change_lesson'),
(27,'Can delete lesson',7,'delete_lesson'),
(28,'Can view lesson',7,'view_lesson'),
(29,'Can add course',8,'add_course'),
(30,'Can change course',8,'change_course'),
(31,'Can delete course',8,'delete_course'),
(32,'Can view course',8,'view_course'),
(33,'Can add question',9,'add_question'),
(34,'Can change question',9,'change_question'),
(35,'Can delete question',9,'delete_question'),
(36,'Can view question',9,'view_question'),
(37,'Can add certificate',10,'add_certificate'),
(38,'Can change certificate',10,'change_certificate'),
(39,'Can delete certificate',10,'delete_certificate'),
(40,'Can view certificate',10,'view_certificate'),
(41,'Can add discussion thread',11,'add_discussionthread'),
(42,'Can change discussion thread',11,'change_discussionthread'),
(43,'Can delete discussion thread',11,'delete_discussionthread'),
(44,'Can view discussion thread',11,'view_discussionthread'),
(45,'Can add discussion reply',12,'add_discussionreply'),
(46,'Can change discussion reply',12,'change_discussionreply'),
(47,'Can delete discussion reply',12,'delete_discussionreply'),
(48,'Can view discussion reply',12,'view_discussionreply'),
(49,'Can add live session',13,'add_livesession'),
(50,'Can change live session',13,'change_livesession'),
(51,'Can delete live session',13,'delete_livesession'),
(52,'Can view live session',13,'view_livesession'),
(53,'Can add notification',14,'add_notification'),
(54,'Can change notification',14,'change_notification'),
(55,'Can delete notification',14,'delete_notification'),
(56,'Can view notification',14,'view_notification'),
(57,'Can add order',15,'add_order'),
(58,'Can change order',15,'change_order'),
(59,'Can delete order',15,'delete_order'),
(60,'Can view order',15,'view_order'),
(61,'Can add choice',16,'add_choice'),
(62,'Can change choice',16,'change_choice'),
(63,'Can delete choice',16,'delete_choice'),
(64,'Can view choice',16,'view_choice'),
(65,'Can add quiz',17,'add_quiz'),
(66,'Can change quiz',17,'change_quiz'),
(67,'Can delete quiz',17,'delete_quiz'),
(68,'Can view quiz',17,'view_quiz'),
(69,'Can add review',18,'add_review'),
(70,'Can change review',18,'change_review'),
(71,'Can delete review',18,'delete_review'),
(72,'Can view review',18,'view_review'),
(73,'Can add user course progress',19,'add_usercourseprogress'),
(74,'Can change user course progress',19,'change_usercourseprogress'),
(75,'Can delete user course progress',19,'delete_usercourseprogress'),
(76,'Can view user course progress',19,'view_usercourseprogress'),
(77,'Can add badge',20,'add_badge'),
(78,'Can change badge',20,'change_badge'),
(79,'Can delete badge',20,'delete_badge'),
(80,'Can view badge',20,'view_badge'),
(81,'Can add tag',21,'add_tag'),
(82,'Can change tag',21,'change_tag'),
(83,'Can delete tag',21,'delete_tag'),
(84,'Can view tag',21,'view_tag'),
(85,'Can add user progress',22,'add_userprogress'),
(86,'Can change user progress',22,'change_userprogress'),
(87,'Can delete user progress',22,'delete_userprogress'),
(88,'Can view user progress',22,'view_userprogress'),
(89,'Can add message',23,'add_message'),
(90,'Can change message',23,'change_message'),
(91,'Can delete message',23,'delete_message'),
(92,'Can view message',23,'view_message'),
(93,'Can add course engagement',24,'add_courseengagement'),
(94,'Can change course engagement',24,'change_courseengagement'),
(95,'Can delete course engagement',24,'delete_courseengagement'),
(96,'Can view course engagement',24,'view_courseengagement'),
(97,'Can add study group',25,'add_studygroup'),
(98,'Can change study group',25,'change_studygroup'),
(99,'Can delete study group',25,'delete_studygroup'),
(100,'Can view study group',25,'view_studygroup'),
(101,'Can add user badge',26,'add_userbadge'),
(102,'Can change user badge',26,'change_userbadge'),
(103,'Can delete user badge',26,'delete_userbadge'),
(104,'Can view user badge',26,'view_userbadge'),
(105,'Can add leaderboard',27,'add_leaderboard'),
(106,'Can change leaderboard',27,'change_leaderboard'),
(107,'Can delete leaderboard',27,'delete_leaderboard'),
(108,'Can view leaderboard',27,'view_leaderboard'),
(109,'Can add module',28,'add_module'),
(110,'Can change module',28,'change_module'),
(111,'Can delete module',28,'delete_module'),
(112,'Can view module',28,'view_module'),
(113,'Can add user profile',29,'add_userprofile'),
(114,'Can change user profile',29,'change_userprofile'),
(115,'Can delete user profile',29,'delete_userprofile'),
(116,'Can view user profile',29,'view_userprofile'),
(117,'Can add tag',30,'add_tag'),
(118,'Can change tag',30,'change_tag'),
(119,'Can delete tag',30,'delete_tag'),
(120,'Can view tag',30,'view_tag'),
(121,'Can add user profile',31,'add_userprofile'),
(122,'Can change user profile',31,'change_userprofile'),
(123,'Can delete user profile',31,'delete_userprofile'),
(124,'Can view user profile',31,'view_userprofile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_badge`
--

DROP TABLE IF EXISTS `courses_badge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_badge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `icon` varchar(100) NOT NULL,
  `criteria` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`criteria`)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_badge`
--

LOCK TABLES `courses_badge` WRITE;
/*!40000 ALTER TABLE `courses_badge` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_badge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_certificate`
--

DROP TABLE IF EXISTS `courses_certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_certificate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `issued_date` datetime(6) NOT NULL,
  `Certificate_code` varchar(16) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Certificate_code` (`Certificate_code`),
  KEY `courses_certificate_course_id_83248c57_fk_courses_course_id` (`course_id`),
  KEY `courses_certificate_user_id_d83364d1_fk_users_customuser_id` (`user_id`),
  CONSTRAINT `courses_certificate_course_id_83248c57_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `courses_certificate_user_id_d83364d1_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_certificate`
--

LOCK TABLES `courses_certificate` WRITE;
/*!40000 ALTER TABLE `courses_certificate` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_certificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_choice`
--

DROP TABLE IF EXISTS `courses_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_choice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `question_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_choice_question_id_e3bc6751_fk_courses_question_id` (`question_id`),
  CONSTRAINT `courses_choice_question_id_e3bc6751_fk_courses_question_id` FOREIGN KEY (`question_id`) REFERENCES `courses_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_choice`
--

LOCK TABLES `courses_choice` WRITE;
/*!40000 ALTER TABLE `courses_choice` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_course`
--

DROP TABLE IF EXISTS `courses_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_course` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `instructor_id` bigint(20) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_course_instructor_id_5b0643dc_fk_users_customuser_id` (`instructor_id`),
  CONSTRAINT `courses_course_instructor_id_5b0643dc_fk_users_customuser_id` FOREIGN KEY (`instructor_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_course`
--

LOCK TABLES `courses_course` WRITE;
/*!40000 ALTER TABLE `courses_course` DISABLE KEYS */;
INSERT INTO `courses_course` VALUES
(1,'HTML: Beginners Course from Scratch','HyperText Markup Language (HTML) is a programming language that describes the structure of web pages. It\'s used to tell web browsers how to display content, such as text, images, and other media. \r\nHere are some key points about HTML:\r\nStructure\r\nHTML documents are made up of elements and attributes that are used to structure content. Elements are enclosed by angle brackets (<>) and are used to create paragraphs, lists, tables, and more. \r\nMarkup\r\nHTML markup is the text that appears between the angle brackets, while the content is everything else. \r\nTags\r\nHTML tags are used to define elements. Some elements are empty, meaning they don\'t have a closing tag. \r\nAttributes\r\nHTML tags can take attributes, such as style, ids, and classes, which are placed in the opening tag. \r\nVersion\r\nThe latest version of HTML is HTML5. \r\nFeatures\r\nHTML is beginner-friendly, open-source, and free. It\'s also flexible and can be integrated with other languages like PHP and Node.js.',0.00,'courses/2024/12/24/html.webp','2024-12-24 10:12:47.976344',4,'2024-12-24 10:12:47.976381'),
(2,'Python Programming: Scratch course for beginners','Python is a general-purpose, high-level, interpreted programming language that is used for a variety of tasks, including:\r\nWeb development: Python is used for server-side and backend web development. \r\nSoftware development: Python is used to build software. \r\nData science: Python is used for data analysis, modeling, and visualization. \r\nMachine learning: Python is used to execute models for machine learning, natural language processing, and computer vision. \r\nAutomation: Python is used to automate tasks. \r\nPython is popular because it is easy to learn, efficient, and can run on many platforms. It is also open-source, so anyone can contribute to its development. \r\nHere are some other characteristics of Python:\r\nDesign philosophy\r\nPython\'s design philosophy emphasizes simplicity, readability, and unambiguity. \r\nStandard library\r\nPython comes with a comprehensive standard library of functions and modules. \r\nDebugging\r\nPython\'s debugging is easy because the interpreter raises an exception when it discovers an error. \r\nEdit-test-debug cycle\r\nPython\'s edit-test-debug cycle is fast because there is no compilation step. \r\nGuido van Rossum developed Python in 1991 and named it after the British comedy group Monty Python.',0.00,'courses/2024/12/24/python-prog.webp','2024-12-24 12:53:14.757279',4,'2024-12-24 12:53:14.757342'),
(3,'Principles of Economics','Economic conditions are constantly changing, and each generation looks at its own problems in its own way. In England, as well as on the Continent and in America, Economic studies are being more vigorously pursued now than ever before; but all this activity has only shown the more clearly that Economic science is, and must be, one of slow and continuous growth. Some of the best work of the present generation has indeed appeared at first sight to be antagonistic to that of earlier writers; but when it has had time to settle down into its proper place, and its rough edges have been worn away, it has been found to involve no real breach of continuity in the development of the science. The new doctrines have supplemented the older, have extended, developed, and sometimes corrected them, and often have given them a different tone by a new distribution of emphasis; but very seldom have subverted them.',0.00,'courses/2024/12/27/principles_of_eco.png','2024-12-27 10:40:37.507812',3,'2024-12-27 10:40:37.507843'),
(4,'How to Scale through as a Freelancer','Wondering how to become a successful freelancer? Learn more about choosing a niche, building your brand, increasing pricing, and more.',0.00,'courses/2024/12/27/feature-image-2.png','2024-12-27 10:58:27.612913',3,'2024-12-27 10:58:27.612952'),
(5,'Data Analyst: Beginners course','A data analyst uses statistical and computational techniques to extract insights from data and help businesses make informed decisions. Their responsibilities include: \r\nData preparation\r\nCleaning, filtering, and handling missing values to ensure the data is accurate and relevant \r\nData analysis\r\nUsing statistical tools to identify patterns, relationships, and trends \r\nData visualization\r\nPresenting data findings in a clear and accessible format using charts, graphs, and dashboards \r\nReporting\r\nCommunicating insights and findings to stakeholders through reports and presentations \r\nCollaboration\r\nWorking with other departments to understand their data needs and help them make informed decisions \r\nData analysts use a variety of tools, including: Structured Query Language (SQL), Microsoft Excel, R or Python statistical programming, Tableau, and Jupyter Notebook. \r\nData analysts can work in a variety of industries, including healthcare, finance, and marketing. The average annual salary for a data analyst can range from $67,509 to $137,000, depending on the city, industry, and specialization.',0.00,'courses/2024/12/31/data_analytics.png','2024-12-31 19:53:30.999033',4,'2024-12-31 19:53:30.999063'),
(6,'Computer Science','Courses in computer science are offered at diploma, degree and doctorate levels. A computer science diploma is a basic course while the degree program at undergraduate and postgraduate levels are advanced-level courses. Computer Science courses like BTech, BCA, MCA, BSc IT, MSc IT are very popular among students.',0.00,'courses/2025/01/01/comp_science.jpeg','2025-01-01 19:28:16.959034',4,'2025-01-01 19:28:16.959067'),
(7,'C Programming Language','C (pronounced /ˈsiː/ – like the letter c) is a general-purpose programming language. It was created in the 1970s by Dennis Ritchie and remains very widely used and influential. By design, C\'s features cleanly reflect the capabilities of the targeted CPUs. It has found lasting use in operating systems code (especially in kernels), device drivers, and protocol stacks, but its use in application software has been decreasing. C is commonly used on computer architectures that range from the largest supercomputers to the smallest microcontrollers and embedded systems.',0.00,'courses/2025/01/01/c_program.jpeg','2025-01-01 19:35:53.109181',4,'2025-01-01 19:35:53.109231'),
(8,'History of Geography','The foundations of geography can be traced to ancient cultures, such as the ancient, medieval, and early modern Chinese. The Greeks, who were the first to explore geography as both art and science, achieved this through Cartography, Philosophy, and Literature, or through Mathematics.',0.00,'courses/2025/01/01/geog.jpg','2025-01-01 19:43:47.289172',4,'2025-01-01 19:43:47.289190'),
(9,'PSYCHOLOGY BASICS','Psychology is the scientific study of mind and behavior. Its subject matter includes the behavior of humans and nonhumans, both conscious and unconscious phenomena, and mental processes such as thoughts, feelings, and motives.',0.00,'courses/2025/01/01/what-is-psych-jpg.webp','2025-01-01 20:14:33.998534',3,'2025-01-01 20:14:33.998592');
/*!40000 ALTER TABLE `courses_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_course_tags`
--

DROP TABLE IF EXISTS `courses_course_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_course_tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_course_tags_course_id_tag_id_52b73814_uniq` (`course_id`,`tag_id`),
  KEY `courses_course_tags_tag_id_20fb041b_fk_courses_tag_id` (`tag_id`),
  CONSTRAINT `courses_course_tags_course_id_f326f2c6_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `courses_course_tags_tag_id_20fb041b_fk_courses_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `courses_tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_course_tags`
--

LOCK TABLES `courses_course_tags` WRITE;
/*!40000 ALTER TABLE `courses_course_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_course_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_courseengagement`
--

DROP TABLE IF EXISTS `courses_courseengagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_courseengagement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time_spent` bigint(20) NOT NULL,
  `completed` tinyint(1) NOT NULL,
  `last_accessed` datetime(6) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_courseengagement_course_id_0efc1d17_fk_courses_course_id` (`course_id`),
  KEY `courses_courseengagement_user_id_519613a6_fk_users_customuser_id` (`user_id`),
  CONSTRAINT `courses_courseengagement_course_id_0efc1d17_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `courses_courseengagement_user_id_519613a6_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_courseengagement`
--

LOCK TABLES `courses_courseengagement` WRITE;
/*!40000 ALTER TABLE `courses_courseengagement` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_courseengagement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_discussionreply`
--

DROP TABLE IF EXISTS `courses_discussionreply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_discussionreply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `thread_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_discussionreply_user_id_bdaf573e_fk_users_customuser_id` (`user_id`),
  KEY `courses_discussionre_thread_id_a4037d65_fk_courses_d` (`thread_id`),
  CONSTRAINT `courses_discussionre_thread_id_a4037d65_fk_courses_d` FOREIGN KEY (`thread_id`) REFERENCES `courses_discussionthread` (`id`),
  CONSTRAINT `courses_discussionreply_user_id_bdaf573e_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_discussionreply`
--

LOCK TABLES `courses_discussionreply` WRITE;
/*!40000 ALTER TABLE `courses_discussionreply` DISABLE KEYS */;
INSERT INTO `courses_discussionreply` VALUES
(1,'You can follow the course instructions and finish the course to gain a better understanding of the process.','2024-12-30 15:07:13.320010',3,1),
(2,'You can follow the course instructions and finish the course to gain a better understanding of the process.','2024-12-30 15:08:11.192793',3,1);
/*!40000 ALTER TABLE `courses_discussionreply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_discussionthread`
--

DROP TABLE IF EXISTS `courses_discussionthread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_discussionthread` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_discussionthread_course_id_6d7eac9d_fk_courses_course_id` (`course_id`),
  KEY `courses_discussionthread_user_id_21e42283_fk_users_customuser_id` (`user_id`),
  CONSTRAINT `courses_discussionthread_course_id_6d7eac9d_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `courses_discussionthread_user_id_21e42283_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_discussionthread`
--

LOCK TABLES `courses_discussionthread` WRITE;
/*!40000 ALTER TABLE `courses_discussionthread` DISABLE KEYS */;
INSERT INTO `courses_discussionthread` VALUES
(1,'How can I maintain the process of scaling through the business.','2024-12-27 11:31:44.355267',4,4),
(2,'How can I maintain the process of scaling through the business.','2024-12-27 11:56:44.692352',4,4),
(3,'Let\'s be addictive to learning','2025-02-21 15:04:33.026572',9,4);
/*!40000 ALTER TABLE `courses_discussionthread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_leaderboard`
--

DROP TABLE IF EXISTS `courses_leaderboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_leaderboard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `courses_leaderboard_user_id_ad1d077d_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_leaderboard`
--

LOCK TABLES `courses_leaderboard` WRITE;
/*!40000 ALTER TABLE `courses_leaderboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_leaderboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_lesson`
--

DROP TABLE IF EXISTS `courses_lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_lesson` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `video_url` varchar(200) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `video` varchar(100) NOT NULL,
  `resources` varchar(100) DEFAULT NULL,
  `thumbnail` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_lesson_course_id_16bc4882_fk_courses_course_id` (`course_id`),
  CONSTRAINT `courses_lesson_course_id_16bc4882_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_lesson`
--

LOCK TABLES `courses_lesson` WRITE;
/*!40000 ALTER TABLE `courses_lesson` DISABLE KEYS */;
INSERT INTO `courses_lesson` VALUES
(1,'Part 1: Beginners course','HyperText Markup Language (HTML) is a programming language that describes the structure of web pages. It\'s used to tell web browsers how to display content, such as text, images, and other media. Here are some key points about HTML: Structure HTML documents are made up of elements and attributes that are used to structure content. Elements are enclosed by angle brackets (<>) and are used to create paragraphs, lists, tables, and more. Markup HTML markup is the text that appears between the angle brackets, while the content is everything else. Tags HTML tags are used to define elements. Some elements are empty, meaning they don\'t have a closing tag. Attributes HTML tags can take attributes, such as style, ids, and classes, which are placed in the opening tag. Version The latest version of HTML is HTML5. Features HTML is beginner-friendly, open-source, and free. It\'s also flexible and can be integrated with other languages like PHP and Node.js','https://www.youtube.com/watch?v=qz0aGYrrlhU','2024-12-30 12:20:31.762007',1,'https://www.example.com/placeholder-video.mp4','',NULL),
(2,'Part 1','Python programming language','https://www.youtube.com/watch?v=_MYAWGxlVSg','2024-12-30 12:27:15.639517',2,'lessons/2024/12/30/GMT20241216-211159_Clip_Team_Alphas_Prototype.mp4','',NULL),
(3,'Part 2','Python programming exercise 2','https://www.youtube.com/watch?v=_MYAWGxlVSg','2024-12-30 12:54:30.792189',2,'lessons/2024/12/30/GMT20241216-211159_Clip_Team_Alphas_Prototype_th9fQbZ.mp4','','thumbnails/python-prog.webp');
/*!40000 ALTER TABLE `courses_lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_livesession`
--

DROP TABLE IF EXISTS `courses_livesession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_livesession` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `date` datetime(6) NOT NULL,
  `duration_minutes` int(11) NOT NULL,
  `link` varchar(200) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_livesession_course_id_ae858b7d_fk_courses_course_id` (`course_id`),
  CONSTRAINT `courses_livesession_course_id_ae858b7d_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_livesession`
--

LOCK TABLES `courses_livesession` WRITE;
/*!40000 ALTER TABLE `courses_livesession` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_livesession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_message`
--

DROP TABLE IF EXISTS `courses_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `receiver_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  `attachment` varchar(100) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_message_receiver_id_4efe7f59_fk_users_customuser_id` (`receiver_id`),
  KEY `courses_message_sender_id_8817da7b_fk_users_customuser_id` (`sender_id`),
  KEY `courses_message_parent_id_04020315_fk_courses_message_id` (`parent_id`),
  CONSTRAINT `courses_message_parent_id_04020315_fk_courses_message_id` FOREIGN KEY (`parent_id`) REFERENCES `courses_message` (`id`),
  CONSTRAINT `courses_message_receiver_id_4efe7f59_fk_users_customuser_id` FOREIGN KEY (`receiver_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `courses_message_sender_id_8817da7b_fk_users_customuser_id` FOREIGN KEY (`sender_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_message`
--

LOCK TABLES `courses_message` WRITE;
/*!40000 ALTER TABLE `courses_message` DISABLE KEYS */;
INSERT INTO `courses_message` VALUES
(1,'Testing 1\r\n','2024-12-30 17:25:48.190086',3,4,NULL,0,NULL),
(2,'Hello, still testing','2024-12-30 18:44:15.881308',3,4,'',0,NULL),
(3,'Hello, still testing','2024-12-30 18:48:49.846594',3,4,'',0,NULL),
(4,'Hello Admin','2024-12-30 18:56:20.384451',4,3,'',0,NULL);
/*!40000 ALTER TABLE `courses_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_module`
--

DROP TABLE IF EXISTS `courses_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_module` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_module`
--

LOCK TABLES `courses_module` WRITE;
/*!40000 ALTER TABLE `courses_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_notification`
--

DROP TABLE IF EXISTS `courses_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `reply_id` bigint(20) DEFAULT NULL,
  `thread_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_notification_user_id_7cc5ad38_fk_users_customuser_id` (`user_id`),
  KEY `courses_notification_reply_id_39d7f5aa_fk_courses_d` (`reply_id`),
  KEY `courses_notification_thread_id_46d21f60_fk_courses_d` (`thread_id`),
  CONSTRAINT `courses_notification_reply_id_39d7f5aa_fk_courses_d` FOREIGN KEY (`reply_id`) REFERENCES `courses_discussionreply` (`id`),
  CONSTRAINT `courses_notification_thread_id_46d21f60_fk_courses_d` FOREIGN KEY (`thread_id`) REFERENCES `courses_discussionthread` (`id`),
  CONSTRAINT `courses_notification_user_id_7cc5ad38_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_notification`
--

LOCK TABLES `courses_notification` WRITE;
/*!40000 ALTER TABLE `courses_notification` DISABLE KEYS */;
INSERT INTO `courses_notification` VALUES
(1,'Welcome to our platform! We\'re excited to have you here 🎉.',1,'2025-02-21 14:19:52.130327',4,NULL,NULL),
(2,'Welcome to our platform! We\'re excited to have you here 🎉.',1,'2025-03-04 09:21:55.382028',2,NULL,NULL);
/*!40000 ALTER TABLE `courses_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_order`
--

DROP TABLE IF EXISTS `courses_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` tinyint(1) NOT NULL,
  `payment_id` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_order_course_id_6ab9eb12_fk_courses_course_id` (`course_id`),
  KEY `courses_order_user_id_45d42f55_fk_users_customuser_id` (`user_id`),
  CONSTRAINT `courses_order_course_id_6ab9eb12_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `courses_order_user_id_45d42f55_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_order`
--

LOCK TABLES `courses_order` WRITE;
/*!40000 ALTER TABLE `courses_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_question`
--

DROP TABLE IF EXISTS `courses_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `text` longtext NOT NULL,
  `quiz_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_question_quiz_id_7bd87b34_fk_courses_quiz_id` (`quiz_id`),
  CONSTRAINT `courses_question_quiz_id_7bd87b34_fk_courses_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `courses_quiz` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_question`
--

LOCK TABLES `courses_question` WRITE;
/*!40000 ALTER TABLE `courses_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_quiz`
--

DROP TABLE IF EXISTS `courses_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_quiz` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_quiz_course_id_1a0543d1_fk_courses_course_id` (`course_id`),
  CONSTRAINT `courses_quiz_course_id_1a0543d1_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_quiz`
--

LOCK TABLES `courses_quiz` WRITE;
/*!40000 ALTER TABLE `courses_quiz` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_review`
--

DROP TABLE IF EXISTS `courses_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_review` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rating` int(11) NOT NULL,
  `comment` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_review_course_id_536a14f9_fk_courses_course_id` (`course_id`),
  KEY `courses_review_user_id_5a028109_fk_users_customuser_id` (`user_id`),
  CONSTRAINT `courses_review_course_id_536a14f9_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `courses_review_user_id_5a028109_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_review`
--

LOCK TABLES `courses_review` WRITE;
/*!40000 ALTER TABLE `courses_review` DISABLE KEYS */;
INSERT INTO `courses_review` VALUES
(1,5,'This is great','2025-02-21 14:38:53.420454',9,4);
/*!40000 ALTER TABLE `courses_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_studygroup`
--

DROP TABLE IF EXISTS `courses_studygroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_studygroup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `course_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_studygroup_course_id_786300af_fk_courses_course_id` (`course_id`),
  CONSTRAINT `courses_studygroup_course_id_786300af_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_studygroup`
--

LOCK TABLES `courses_studygroup` WRITE;
/*!40000 ALTER TABLE `courses_studygroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_studygroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_studygroup_members`
--

DROP TABLE IF EXISTS `courses_studygroup_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_studygroup_members` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `studygroup_id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_studygroup_membe_studygroup_id_customuser_e2ec73a0_uniq` (`studygroup_id`,`customuser_id`),
  KEY `courses_studygroup_m_customuser_id_7187283f_fk_users_cus` (`customuser_id`),
  CONSTRAINT `courses_studygroup_m_customuser_id_7187283f_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `courses_studygroup_m_studygroup_id_61b05161_fk_courses_s` FOREIGN KEY (`studygroup_id`) REFERENCES `courses_studygroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_studygroup_members`
--

LOCK TABLES `courses_studygroup_members` WRITE;
/*!40000 ALTER TABLE `courses_studygroup_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_studygroup_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_tag`
--

DROP TABLE IF EXISTS `courses_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_tag`
--

LOCK TABLES `courses_tag` WRITE;
/*!40000 ALTER TABLE `courses_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_userbadge`
--

DROP TABLE IF EXISTS `courses_userbadge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_userbadge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `awarded_date` datetime(6) NOT NULL,
  `badge_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_userbadge_badge_id_06994ddb_fk_courses_badge_id` (`badge_id`),
  KEY `courses_userbadge_user_id_99a225ed_fk_users_customuser_id` (`user_id`),
  CONSTRAINT `courses_userbadge_badge_id_06994ddb_fk_courses_badge_id` FOREIGN KEY (`badge_id`) REFERENCES `courses_badge` (`id`),
  CONSTRAINT `courses_userbadge_user_id_99a225ed_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_userbadge`
--

LOCK TABLES `courses_userbadge` WRITE;
/*!40000 ALTER TABLE `courses_userbadge` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_userbadge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_usercourseprogress`
--

DROP TABLE IF EXISTS `courses_usercourseprogress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_usercourseprogress` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `progress` double NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_usercoursepr_course_id_d840f60d_fk_courses_c` (`course_id`),
  KEY `courses_usercoursepr_user_id_16683a45_fk_users_cus` (`user_id`),
  CONSTRAINT `courses_usercoursepr_course_id_d840f60d_fk_courses_c` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `courses_usercoursepr_user_id_16683a45_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_usercourseprogress`
--

LOCK TABLES `courses_usercourseprogress` WRITE;
/*!40000 ALTER TABLE `courses_usercourseprogress` DISABLE KEYS */;
INSERT INTO `courses_usercourseprogress` VALUES
(1,100,2,4),
(2,0,1,4),
(3,50,2,2);
/*!40000 ALTER TABLE `courses_usercourseprogress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_usercourseprogress_completed_lessons`
--

DROP TABLE IF EXISTS `courses_usercourseprogress_completed_lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_usercourseprogress_completed_lessons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usercourseprogress_id` bigint(20) NOT NULL,
  `lesson_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_usercourseprogre_usercourseprogress_id_le_ad632987_uniq` (`usercourseprogress_id`,`lesson_id`),
  KEY `courses_usercoursepr_lesson_id_0829f11a_fk_courses_l` (`lesson_id`),
  CONSTRAINT `courses_usercoursepr_lesson_id_0829f11a_fk_courses_l` FOREIGN KEY (`lesson_id`) REFERENCES `courses_lesson` (`id`),
  CONSTRAINT `courses_usercoursepr_usercourseprogress_i_a3e45000_fk_courses_u` FOREIGN KEY (`usercourseprogress_id`) REFERENCES `courses_usercourseprogress` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_usercourseprogress_completed_lessons`
--

LOCK TABLES `courses_usercourseprogress_completed_lessons` WRITE;
/*!40000 ALTER TABLE `courses_usercourseprogress_completed_lessons` DISABLE KEYS */;
INSERT INTO `courses_usercourseprogress_completed_lessons` VALUES
(3,1,2),
(1,1,3),
(7,3,2);
/*!40000 ALTER TABLE `courses_usercourseprogress_completed_lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_userprogress`
--

DROP TABLE IF EXISTS `courses_userprogress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_userprogress` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quiz_scores` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`quiz_scores`)),
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_userprogress_course_id_6a4e2ee3_fk_courses_course_id` (`course_id`),
  KEY `courses_userprogress_user_id_b4dcd58f_fk_users_customuser_id` (`user_id`),
  CONSTRAINT `courses_userprogress_course_id_6a4e2ee3_fk_courses_course_id` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `courses_userprogress_user_id_b4dcd58f_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_userprogress`
--

LOCK TABLES `courses_userprogress` WRITE;
/*!40000 ALTER TABLE `courses_userprogress` DISABLE KEYS */;
INSERT INTO `courses_userprogress` VALUES
(1,'{}',1,4),
(2,'{}',2,4);
/*!40000 ALTER TABLE `courses_userprogress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_userprogress_completed_modules`
--

DROP TABLE IF EXISTS `courses_userprogress_completed_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_userprogress_completed_modules` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userprogress_id` bigint(20) NOT NULL,
  `module_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_userprogress_com_userprogress_id_module_i_dcdaaa1b_uniq` (`userprogress_id`,`module_id`),
  KEY `courses_userprogress_module_id_cd6e7f72_fk_courses_m` (`module_id`),
  CONSTRAINT `courses_userprogress_module_id_cd6e7f72_fk_courses_m` FOREIGN KEY (`module_id`) REFERENCES `courses_module` (`id`),
  CONSTRAINT `courses_userprogress_userprogress_id_0eb669d4_fk_courses_u` FOREIGN KEY (`userprogress_id`) REFERENCES `courses_userprogress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_userprogress_completed_modules`
--

LOCK TABLES `courses_userprogress_completed_modules` WRITE;
/*!40000 ALTER TABLE `courses_userprogress_completed_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_userprogress_completed_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES
(1,'2024-12-24 10:12:48.027611','1','HTML: Beginners Course from Scratch',1,'[{\"added\": {}}]',8,4),
(2,'2024-12-24 10:14:23.378733','4','admin',2,'[{\"changed\": {\"fields\": [\"Is Instructor\", \"Is Student\"]}}]',1,4),
(3,'2024-12-24 12:53:15.116336','2','Python Programming: Scratch course for beginners',1,'[{\"added\": {}}]',8,4);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES
(2,'admin','logentry'),
(4,'auth','group'),
(3,'auth','permission'),
(5,'contenttypes','contenttype'),
(20,'courses','badge'),
(10,'courses','certificate'),
(16,'courses','choice'),
(8,'courses','course'),
(24,'courses','courseengagement'),
(12,'courses','discussionreply'),
(11,'courses','discussionthread'),
(27,'courses','leaderboard'),
(7,'courses','lesson'),
(13,'courses','livesession'),
(23,'courses','message'),
(28,'courses','module'),
(14,'courses','notification'),
(15,'courses','order'),
(9,'courses','question'),
(17,'courses','quiz'),
(18,'courses','review'),
(25,'courses','studygroup'),
(21,'courses','tag'),
(26,'courses','userbadge'),
(19,'courses','usercourseprogress'),
(29,'courses','userprofile'),
(22,'courses','userprogress'),
(6,'sessions','session'),
(1,'users','customuser'),
(30,'users','tag'),
(31,'users','userprofile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2024-12-08 03:18:57.911051'),
(2,'contenttypes','0002_remove_content_type_name','2024-12-08 03:18:59.247350'),
(3,'auth','0001_initial','2024-12-08 03:19:04.994914'),
(4,'auth','0002_alter_permission_name_max_length','2024-12-08 03:19:05.750612'),
(5,'auth','0003_alter_user_email_max_length','2024-12-08 03:19:05.784116'),
(6,'auth','0004_alter_user_username_opts','2024-12-08 03:19:05.821772'),
(7,'auth','0005_alter_user_last_login_null','2024-12-08 03:19:05.859632'),
(8,'auth','0006_require_contenttypes_0002','2024-12-08 03:19:05.929666'),
(9,'auth','0007_alter_validators_add_error_messages','2024-12-08 03:19:05.973334'),
(10,'auth','0008_alter_user_username_max_length','2024-12-08 03:19:06.023066'),
(11,'auth','0009_alter_user_last_name_max_length','2024-12-08 03:19:06.061953'),
(12,'auth','0010_alter_group_name_max_length','2024-12-08 03:19:06.538135'),
(13,'auth','0011_update_proxy_permissions','2024-12-08 03:19:06.582541'),
(14,'auth','0012_alter_user_first_name_max_length','2024-12-08 03:19:06.622774'),
(15,'users','0001_initial','2024-12-08 03:19:14.425361'),
(16,'admin','0001_initial','2024-12-08 03:19:16.491855'),
(17,'admin','0002_logentry_remove_auto_add','2024-12-08 03:19:16.577929'),
(18,'admin','0003_logentry_add_action_flag_choices','2024-12-08 03:19:16.727213'),
(19,'sessions','0001_initial','2024-12-08 03:19:17.615288'),
(20,'courses','0001_initial','2024-12-08 03:54:48.232707'),
(21,'courses','0002_question_lesson_video_certificate_discussionthread_and_more','2024-12-12 14:10:30.472304'),
(22,'users','0002_alter_customuser_is_student','2024-12-12 14:10:30.624910'),
(23,'courses','0003_badge_module_tag_courseengagement_leaderboard_and_more','2024-12-13 18:30:49.794065'),
(24,'users','0003_alter_customuser_is_instructor_and_more','2024-12-13 19:52:03.108668'),
(25,'courses','0004_course_updated_at','2024-12-21 09:54:15.414205'),
(26,'courses','0005_alter_course_options_alter_course_description_and_more','2024-12-23 21:32:34.919988'),
(27,'courses','0006_alter_course_instructor','2024-12-24 09:19:01.987272'),
(28,'courses','0007_lesson_resources','2024-12-28 11:11:57.196746'),
(29,'courses','0008_lesson_thumbnail','2024-12-30 12:48:38.804002'),
(30,'courses','0009_notification_reply_notification_thread','2024-12-30 16:19:40.856157'),
(31,'courses','0010_message_attachment_message_is_read_and_more','2024-12-30 18:42:05.176980'),
(32,'courses','0011_message_parent_alter_userprofile_user','2024-12-30 19:14:35.736633'),
(33,'courses','0012_userprofile_profile_picture','2024-12-31 13:29:07.440375'),
(34,'courses','0013_delete_userprofile','2025-02-21 14:17:57.506582'),
(35,'users','0004_tag_userprofile','2025-02-21 14:18:07.076093'),
(36,'users','0005_userprofile_points','2025-03-04 15:33:41.078424');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES
('634oa8qa1t980atq27ceplo91x5ur5v3','e30:1tWbTM:psxgYMHr-uxJlxk8u2dmJxlXF5jnPhSlWMoAV2PygVA','2025-01-25 13:24:16.824420'),
('6sfkxlbitbpfujq3hfwv7tsnl36stkyk','.eJxVjDsOwjAQBe_iGln-20tJnzNEm10bB1AixUmFuDuylALaNzPvLUY89joeLW_jzOIqnLj8bhPSMy8d8AOX-yppXfZtnmRX5EmbHFbOr9vp_h1UbLXXRgEpbbkA2imRY08uAVC2xDrGYiAgQHLBecwWo_ZGlRAto0lRkfh8AeM7N4Y:1tpSVW:XNVVTCojXfMI5Id4PhEPLyonVBgaZqY33o7myhbRWtQ','2025-03-18 13:40:26.507293'),
('aqh2lrw1k8xihd64xwah9ue4c2llwnmf','e30:1tWbQ4:pupMZyc_b5lptBYorTjDGYPT0TjiRrh8Le3cIWUBq0I','2025-01-25 13:20:52.954773'),
('fxf4oic0anaxmu3a8jozbcbkcrokat1v','e30:1tOdqJ:mwDpVHzMVpNLpL2GSJHvUos7PW-pYkxZMQ4ayKlZTAU','2025-01-03 14:19:03.965082'),
('ii9n46ss6fqr518agravxrthrc92jzxb','e30:1tWbR5:dNOWSP4TcxzxcY-GrtX1-ZpAaCsnTi90hkS2ice1ZGs','2025-01-25 13:21:55.514924'),
('jdff0z2a10wi8h6ztk9dackwbb82jzot','e30:1tOi3C:adM9g647RTDsuLh06THLfmFtAZL5GY8utuTHj1uzIMg','2025-01-03 18:48:38.182555'),
('jdqpkkwtcc7qy2bdrnkt1luosij1ps1b','e30:1tWcL1:hjd0M3fpIXjg_Vcm6E9wkizmvFDmyGuqvjUNlpu0Ip8','2025-01-25 14:19:43.561478'),
('k99hsa7pgqk5obqg8c42e12oenpts6nc','.eJxVjDsOwjAQBe_iGln-20tJnzNEm10bB1AixUmFuDuylALaNzPvLUY89joeLW_jzOIqnLj8bhPSMy8d8AOX-yppXfZtnmRX5EmbHFbOr9vp_h1UbLXXRgEpbbkA2imRY08uAVC2xDrGYiAgQHLBecwWo_ZGlRAto0lRkfh8AeM7N4Y:1tR84O:y_42g7IURJPiJB-iEAImTciahkbpBnHKVsXcQCMYfOI','2025-01-10 10:59:52.635553'),
('nsaquyfwomfjibgor74yd7jc8tocnq21','.eJxVjEEOwiAQRe_C2hCgSMGl-56BDDOMVA0kpV0Z765NutDtf-_9l4iwrSVuPS9xJnERgzj9bgnwkesO6A711iS2ui5zkrsiD9rl1Cg_r4f7d1Cgl2_NirRFHs9sMNgEFm1wgzYJFUFwwAFGTT44ttlndoO3HjExsiFWCsT7AwADOP4:1tSHJv:RBd575GS9aXbZc6U3njelLGJClD0Oh01Rhxyb6WmWF4','2025-01-13 15:04:39.641551'),
('yp15lgpx4ecz4398m1m36ixagug7d69e','.eJxVjDEOAiEURO9CbQhf4C9Y2nsGAnyQVQPJslsZ7y6bbKHNFG_ezJs5v63FbT0tbiZ2YWd2-mXBx2eqe0EPX--Nx1bXZQ58V_jRdn5rlF7Xw_07KL6XsQYQlFVELVGCHWEgywnQapMRs8oygRg0GAKlZfTWTlIIIIiIFAT7fAGjbjZW:1tpOTL:XpMBAQn25HV1AdP32vgkNN4ar6MHklSFPVuOoRs8qio','2025-03-18 09:21:55.419807');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser`
--

DROP TABLE IF EXISTS `users_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_customuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_instructor` tinyint(1) NOT NULL,
  `is_student` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser`
--

LOCK TABLES `users_customuser` WRITE;
/*!40000 ALTER TABLE `users_customuser` DISABLE KEYS */;
INSERT INTO `users_customuser` VALUES
(2,'pbkdf2_sha256$870000$hoE39F8yofY79WtFCRKRsg$/Ld13ce5TO8RJAKw6U4fVLcPR7QJeDzeA7vEr9XQ3jc=','2025-03-04 09:21:55.341213',0,'Gabby','','','gabrielakinshola021@gmail.com',0,1,'2024-12-20 14:19:02.851328',0,1),
(3,'pbkdf2_sha256$870000$ltofE2iPGyatvWis8OwHYp$9qnaKLIOqvP7i/OqLcN0LF8Mg2B1G9tjApW8jpEWmCA=','2024-12-30 15:04:38.890695',0,'Hackin','Gabriel','Akinshola','gabrielakinshola021@gmail.com',0,1,'2024-12-20 18:48:37.398154',1,0),
(4,'pbkdf2_sha256$870000$WE8ryXtUCxcCvl3eqBKo39$J9DBbv7j5gnHnLN6v7FFV16jyPrQtreBBHmMv8Mf3iM=','2025-03-04 13:40:26.137832',1,'admin','','','gabrielakinshola3@gmail.com',1,1,'2024-12-24 10:06:24.000000',1,0);
/*!40000 ALTER TABLE `users_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser_groups`
--

DROP TABLE IF EXISTS `users_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_customuser_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_customuser_groups_customuser_id_group_id_76b619e3_uniq` (`customuser_id`,`group_id`),
  KEY `users_customuser_groups_group_id_01390b14_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_customuser_gro_customuser_id_958147bf_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `users_customuser_groups_group_id_01390b14_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser_groups`
--

LOCK TABLES `users_customuser_groups` WRITE;
/*!40000 ALTER TABLE `users_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser_user_permissions`
--

DROP TABLE IF EXISTS `users_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_customuser_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_customuser_user_pe_customuser_id_permission_7a7debf6_uniq` (`customuser_id`,`permission_id`),
  KEY `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_customuser_use_customuser_id_5771478b_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser_user_permissions`
--

LOCK TABLES `users_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_tag`
--

DROP TABLE IF EXISTS `users_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_tag`
--

LOCK TABLES `users_tag` WRITE;
/*!40000 ALTER TABLE `users_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile`
--

DROP TABLE IF EXISTS `users_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userprofile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_picture` varchar(100) DEFAULT NULL,
  `bio` longtext DEFAULT NULL,
  `last_seen` datetime(6) NOT NULL,
  `status_message` longtext DEFAULT NULL,
  `status_image` varchar(100) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `points` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `users_userprofile_user_id_87251ef1_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile`
--

LOCK TABLES `users_userprofile` WRITE;
/*!40000 ALTER TABLE `users_userprofile` DISABLE KEYS */;
INSERT INTO `users_userprofile` VALUES
(1,'profile_pictures/aboutme_5ZdaDh0.jpg','I\'m a Chosen! Who are you??','2025-03-04 15:56:07.471209','','',4,3000),
(2,'',NULL,'2025-03-04 09:21:55.134648',NULL,'',2,0);
/*!40000 ALTER TABLE `users_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile_completed_courses`
--

DROP TABLE IF EXISTS `users_userprofile_completed_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userprofile_completed_courses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userprofile_id` bigint(20) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_userprofile_comple_userprofile_id_course_id_53fcf118_uniq` (`userprofile_id`,`course_id`),
  KEY `users_userprofile_co_course_id_1b620ac2_fk_courses_c` (`course_id`),
  CONSTRAINT `users_userprofile_co_course_id_1b620ac2_fk_courses_c` FOREIGN KEY (`course_id`) REFERENCES `courses_course` (`id`),
  CONSTRAINT `users_userprofile_co_userprofile_id_c802db3a_fk_users_use` FOREIGN KEY (`userprofile_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile_completed_courses`
--

LOCK TABLES `users_userprofile_completed_courses` WRITE;
/*!40000 ALTER TABLE `users_userprofile_completed_courses` DISABLE KEYS */;
INSERT INTO `users_userprofile_completed_courses` VALUES
(1,1,1);
/*!40000 ALTER TABLE `users_userprofile_completed_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile_interests`
--

DROP TABLE IF EXISTS `users_userprofile_interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userprofile_interests` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userprofile_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_userprofile_interests_userprofile_id_tag_id_cf1f4607_uniq` (`userprofile_id`,`tag_id`),
  KEY `users_userprofile_interests_tag_id_97eeef55_fk_users_tag_id` (`tag_id`),
  CONSTRAINT `users_userprofile_in_userprofile_id_a94abbdd_fk_users_use` FOREIGN KEY (`userprofile_id`) REFERENCES `users_userprofile` (`id`),
  CONSTRAINT `users_userprofile_interests_tag_id_97eeef55_fk_users_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `users_tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile_interests`
--

LOCK TABLES `users_userprofile_interests` WRITE;
/*!40000 ALTER TABLE `users_userprofile_interests` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_userprofile_interests` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-08 12:55:39
