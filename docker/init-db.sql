-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Apr 24, 2020 at 03:46 PM
-- Server version: 5.5.62
-- PHP Version: 7.2.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `bambino`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertJoined` (IN `NumRows` INT)  BEGIN
        DECLARE i INT;
        DECLARE subject VARCHAR(40);
        DECLARE url VARCHAR(80);
        DECLARE catsMax INT;
        DECLARE cats VARCHAR(25);
        DECLARE added DATE;
        SET i = 1;
        SET added = '2017-08-25';
        select max(catid) INTO catsMax from trex_categories;
        START TRANSACTION;
        WHILE i <= NumRows DO
            SET url = CONCAT('http://', i, '.localhost123456.com');
            SET subject = CONCAT('Subject ', i);
            SET cats = CONCAT('|',MOD(i, catsMax),'|',MOD(i+2, catsMax),'|',MOD(i+4, catsMax),'|');
            SET added = DATE_ADD(added, INTERVAL 10 DAY);
            INSERT INTO `trex_joined` (`jSubject`, `jURL`, `jImage`, `jCategory`, `jMade`, `jStatus`, `jAdd`) VALUES
            (subject, url, '', cats, 'n', 0, added);
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `trex`
--

CREATE TABLE `trex` (
    `id` mediumint(6) NOT NULL,
    `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
    `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `category` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
    `status` tinyint(1) NOT NULL DEFAULT '0',
    `show` tinyint(1) NOT NULL DEFAULT '0',
    `dbhost` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'localhost',
    `dbuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dbpass` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dbname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dbtype` enum('enth','fanbase','listingadmin') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'enth',
    `dbtabl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dblist` tinyint(1) NOT NULL DEFAULT '0',
    `dbaffs` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dbflid` mediumint(6) NOT NULL,
    `dbhttp` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dbpath` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `desc` text COLLATE utf8_unicode_ci NOT NULL,
    `stats` text COLLATE utf8_unicode_ci NOT NULL,
    `affiliates` text COLLATE utf8_unicode_ci NOT NULL,
    `wishlist` text COLLATE utf8_unicode_ci NOT NULL,
    `quotes` text COLLATE utf8_unicode_ci NOT NULL,
    `members` text COLLATE utf8_unicode_ci NOT NULL,
    `members_header` text COLLATE utf8_unicode_ci NOT NULL,
    `members_footer` text COLLATE utf8_unicode_ci NOT NULL,
    `updates` text COLLATE utf8_unicode_ci NOT NULL,
    `form_delete` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'delete.php',
    `form_form` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'site.php',
    `form_join` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'join.php',
    `form_join_comments` tinyint(1) NOT NULL DEFAULT '0',
    `form_join_rules` text COLLATE utf8_unicode_ci NOT NULL,
    `form_reset` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'reset.php',
    `form_update` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'update.php',
    `fave_fields` text COLLATE utf8_unicode_ci NOT NULL,
    `previous` text COLLATE utf8_unicode_ci NOT NULL,
    `date` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `since` date NOT NULL,
    `updated` date NOT NULL DEFAULT '0000-00-00',
    `granted` tinyint(1) NOT NULL DEFAULT '0',
    `markup` enum('html','xhtml') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'xhtml'
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex`
--

INSERT INTO `trex` (`id`, `title`, `subject`, `url`, `image`, `category`, `status`, `show`, `dbhost`, `dbuser`, `dbpass`, `dbname`, `dbtype`, `dbtabl`, `dblist`, `dbaffs`, `dbflid`, `dbhttp`, `dbpath`, `desc`, `stats`, `affiliates`, `wishlist`, `quotes`, `members`, `members_header`, `members_footer`, `updates`, `form_delete`, `form_form`, `form_join`, `form_join_comments`, `form_join_rules`, `form_reset`, `form_update`, `fave_fields`, `previous`, `date`, `since`, `updated`, `granted`, `markup`) VALUES
    (1, 'Current Listing', 'Cool Current Subject', 'http://localhost:8041/samplefl', '1da3ce569064_', '!3!28!52!', 0, 0, '', '', '', '', 'enth', '', 0, '', 0, '', '', 'DESCRIPTION', '&lt;p class=&quot;details&quot;&gt;\r\n&lt;strong&gt;Members:&lt;/strong&gt; {members} (&lt;em&gt;{pending} Pending &lt;/em&gt;)&lt;br&gt;\r\n&lt;strong&gt;Since:&lt;/strong&gt; {since}&lt;br&gt;\r\n&lt;strong&gt;Last Updated:&lt;/strong&gt; {updated}\r\n&lt;/p&gt;', '', '', '', '<li>{name}<br />\n{email} &middot; {url}</li>', '<ol>', '</ol>', '<div class=\"entry_listingadmin\">\n<span class=\"date\">{date}</span> {entry}\n<p class=\"tc cat\">Filed Under: {categories}</p>\n</div>', 'delete.php', 'site.php', 'join.php', 0, '', 'reset.php', 'update.php', '', 'a:3:{s:17:\"http://google.com\";s:8:\"Previous\";s:30:\"http://localhost:8041/samplefl\";s:11:\"SomeoneElse\";s:18:\"http://google2.com\";s:8:\"Prevous2\";}', 'F j, Y', '2000-02-27', '0000-00-00', 1, 'xhtml'),
    (2, 'Some Upcoming', 'My Super Upcoming subject', '', 'bc84659a401c_', '!77!9!11!28!35!39!50!51!60!63!', 1, 0, '', '', '', '', 'enth', '', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, '', '', '', '', '', 'F j, Y', '2020-04-24', '0000-00-00', 0, 'xhtml'),
    (3, 'Animal Feline Upcoming', 'Animal Feline Upcoming Subj', '', '7f8df39e5ee0_', '!78!', 1, 0, '', '', '', '', 'enth', '', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, '', '', '', '', '', 'F j, Y', '2020-04-24', '0000-00-00', 0, 'xhtml'),
    (4, 'Current Animal Feline', 'Current Animal Feline Subject', '', 'de0cf4372b04_', '!78!', 0, 0, '', '', '', '', 'enth', '', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, '', '', '', '', '', 'F j, Y', '2020-04-11', '0000-00-00', 0, 'xhtml'),
    (5, 'Current Test Listing', 'Current Test Listing Subj', '', '37ff458d3e90_', '!81!', 0, 0, '', '', '', '', 'enth', '', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, '', '', '', '', '', 'F j, Y', '2020-04-01', '0000-00-00', 0, 'xhtml'),
    (6, 'Upcoming Test Listing', 'Upcoming Test Listing Subj', '', '04f1be71b54f_', '!80!', 1, 0, '', '', '', '', 'enth', '', 0, '', 0, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, '', '', '', '', '', 'F j, Y', '2020-04-24', '0000-00-00', 0, 'xhtml');

-- --------------------------------------------------------

--
-- Table structure for table `trex_affiliates`
--

CREATE TABLE `trex_affiliates` (
    `aID` mediumint(6) NOT NULL,
    `fNiq` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '!0!',
    `aSubject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aEmail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aImage` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aAdd` date NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_affiliates`
--

INSERT INTO `trex_affiliates` (`aID`, `fNiq`, `aSubject`, `aEmail`, `aURL`, `aImage`, `aAdd`) VALUES
    (1, '!1!', 'someon', 'gggg+someton@gmail.com', 'https://someone.website.com', 'LAdminAff_wahlberg.jpg', '2020-04-20'),
    (2, '!1!', '1111someon', 'gggg+sometoneeeee@gmail.com', 'https://someone.website.com', 'LAdminAff_wahlberg.jpg', '2020-04-20'),
    (3, '!1!', '1111someon', 'gggg+somehhhhhtoneeeee@gmail.com', 'https://someonhhe.website.com', 'LAdminAff_wahlberg.jpg', '2020-04-20'),
    (4, '!0!', '1111someon', 'gggg+somehhhhhtoneeeee@gmail.com', 'https://someonhhe.website.com', 'LAdminAff_topher.png', '2020-04-20'),
    (5, '!0!', '1111someon', 'gggg+hghgsomehhhhhtoneeeee@gmail.com', 'https://sggomeonhhe.website.com', 'LAdminAff_topher.png', '2020-04-20');

-- --------------------------------------------------------

--
-- Table structure for table `trex_categories`
--

CREATE TABLE `trex_categories` (
    `catid` smallint(3) NOT NULL,
    `catname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `parent` smallint(3) UNSIGNED NOT NULL DEFAULT '0'
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_categories`
--

INSERT INTO `trex_categories` (`catid`, `catname`, `parent`) VALUES
    (1, 'Academia', 0),
    (2, 'Actors', 0),
    (3, 'Actresses', 0),
    (4, 'Adult', 0),
    (5, 'Advertising/TV Channels', 0),
    (6, 'Albums', 0),
    (7, 'Animals', 0),
    (8, 'Animation', 0),
    (9, 'Anime/Manga', 0),
    (10, 'Anime/Manga: Adult', 0),
    (11, 'Anime/Manga: Characters 0-M', 0),
    (12, 'Anime/Manga: Characters N-Z', 0),
    (13, 'Anime/Manga: Companies', 0),
    (14, 'Anime/Manga: Episodes', 0),
    (15, 'Anime/Manga: Fanstuff', 0),
    (16, 'Anime/Manga: General', 0),
    (17, 'Anime/Manga: Items/Locations', 0),
    (18, 'Anime/Manga: Magazines', 0),
    (19, 'Anime/Manga: Manga-ka/Directors', 0),
    (20, 'Anime/Manga: Movies/OVAs', 0),
    (21, 'Anime/Manga: Music', 0),
    (22, 'Anime/Manga: Relationships', 0),
    (23, 'Anime/Manga: Rivalries', 0),
    (24, 'Anime/Manga: Series', 0),
    (25, 'Anime/Manga: Songs', 0),
    (26, 'Anime/Manga: Toys/Collectibles', 0),
    (27, 'Anime/Manga: Websites', 0),
    (28, 'Arts and Design', 0),
    (29, 'Authors/Writers', 0),
    (30, 'Calendar Events', 0),
    (31, 'Characters: Book/Movie', 0),
    (32, 'Characters: TV', 0),
    (33, 'Comics', 0),
    (34, 'Companies', 0),
    (35, 'Computer Miscellany and Internet', 0),
    (36, 'Directors/Producers', 0),
    (37, 'Episodes', 0),
    (38, 'Fan Works', 0),
    (39, 'Fashion/Beauty', 0),
    (40, 'Food/Drinks', 0),
    (41, 'Games', 0),
    (42, 'History/Royalty', 0),
    (43, 'Hobbies and Recreation', 0),
    (44, 'Literature', 0),
    (45, 'Magazines/Newspapers', 0),
    (46, 'Miscellaneous', 0),
    (47, 'Models', 0),
    (48, 'Movies', 0),
    (49, 'Music Miscellany', 0),
    (50, 'Musicians: Bands/Groups', 0),
    (51, 'Musicians: Female', 0),
    (52, 'Musicians: Male', 0),
    (53, 'Mythology/Religion', 0),
    (54, 'Nature', 0),
    (55, 'Objects', 0),
    (56, 'People Miscellany', 0),
    (57, 'Personalities', 0),
    (58, 'Places', 0),
    (59, 'Politics and Organisations', 0),
    (60, 'Relationships: Book/Movie', 0),
    (61, 'Relationships: Real Life', 0),
    (62, 'Relationships: TV', 0),
    (63, 'Songs: Bands/Groups 0-M', 0),
    (64, 'Songs: Bands/Groups N-Z', 0),
    (65, 'Songs: Female Solo', 0),
    (66, 'Songs: Male Solo', 0),
    (67, 'Songs: Various', 0),
    (68, 'Sports', 0),
    (69, 'Sports Entertainment', 0),
    (70, 'Stage/Theatre', 0),
    (71, 'Toys/Collectibles', 0),
    (72, 'Transportation', 0),
    (73, 'TV Shows', 0),
    (74, 'TV/Movie/Book Miscellany', 0),
    (75, 'Webmasters', 0),
    (76, 'Websites', 0),
    (77, 'Mammals: Canines', 7),
    (78, 'Mammals: Felines', 7),
    (79, 'Test Category', 0),
    (80, 'Upcoming Only', 79),
    (81, 'Current Only', 79);

-- --------------------------------------------------------

--
-- Table structure for table `trex_codes`
--

CREATE TABLE `trex_codes` (
    `cID` int(10) NOT NULL,
    `fNiq` mediumint(6) UNSIGNED NOT NULL,
    `cName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `cFile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `cCategory` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `cSize` tinyint(2) NOT NULL DEFAULT '1',
    `cDonor` smallint(3) NOT NULL DEFAULT '0',
    `cPending` tinyint(1) NOT NULL DEFAULT '0',
    `cAdded` datetime NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_codes`
--

INSERT INTO `trex_codes` (`cID`, `fNiq`, `cName`, `cFile`, `cCategory`, `cSize`, `cDonor`, `cPending`, `cAdded`) VALUES
    (1, 1, '', 'SnOW--F   lake.png', '', 1, 1, 1, '2020-04-20 19:18:30');

-- --------------------------------------------------------

--
-- Table structure for table `trex_codes_categories`
--

CREATE TABLE `trex_codes_categories` (
    `catID` mediumint(6) NOT NULL,
    `fNiq` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `catName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `catParent` mediumint(6) NOT NULL DEFAULT '0'
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_codes_donors`
--

CREATE TABLE `trex_codes_donors` (
    `dID` mediumint(6) NOT NULL,
    `dName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dEmail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dPending` tinyint(1) NOT NULL DEFAULT '1',
    `dUpdated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    `dAdded` datetime NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_codes_donors`
--

INSERT INTO `trex_codes_donors` (`dID`, `dName`, `dEmail`, `dURL`, `dPending`, `dUpdated`, `dAdded`) VALUES
    (1, 'fff', 'newemail+1234@gmail.com', 'https://someone.google.com', 0, '2020-04-20 19:55:07', '2020-04-18 21:40:07');

-- --------------------------------------------------------

--
-- Table structure for table `trex_codes_sizes`
--

CREATE TABLE `trex_codes_sizes` (
    `sID` smallint(2) NOT NULL,
    `sName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `sOrder` smallint(2) UNSIGNED NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_codes_sizes`
--

INSERT INTO `trex_codes_sizes` (`sID`, `sName`, `sOrder`) VALUES
    (1, '50x50', 1);

-- --------------------------------------------------------

--
-- Table structure for table `trex_errors`
--

CREATE TABLE `trex_errors` (
    `messID` mediumint(4) NOT NULL,
    `messType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `messURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `messText` text COLLATE utf8_unicode_ci NOT NULL,
    `messInfo` text COLLATE utf8_unicode_ci NOT NULL,
    `messAdded` datetime NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_errors`
--

INSERT INTO `trex_errors` (`messID`, `messType`, `messURL`, `messText`, `messInfo`, `messAdded`) VALUES
    (1, 'Update Error', 'http://localhost/samplefl/update.php', 'E-Mail Address: joiner+kkkkjoiner@gmaaaaaaail.com\nPassword: password\nNew E-Mail Address: \nNew Name: New Name\nNew URL: \nNew Password: \nNew Country: Choose\nVisible: 2', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36|http://localhost:8041/samplefl/update.php|', '2020-04-24 12:14:54'),
    (2, 'Join Error', 'http://localhost/samplefl/join.php', 'Name: Dsffdfs\nE-mail Address: sdfsdfsfd@jkjlgf.com\nURL: \nVisible: 0\nFave Fields: \nComments: ', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36|http://localhost:8041/samplefl/join.php|', '2020-04-24 12:40:13');

-- --------------------------------------------------------

--
-- Table structure for table `trex_joined`
--

CREATE TABLE `trex_joined` (
    `jID` mediumint(5) NOT NULL,
    `jSubject` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
    `jURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `jImage` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `jCategory` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `jMade` enum('y','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n',
    `jStatus` tinyint(1) NOT NULL DEFAULT '0',
    `jAdd` date NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_joined`
--

INSERT INTO `trex_joined` (`jID`, `jSubject`, `jURL`, `jImage`, `jCategory`, `jMade`, `jStatus`, `jAdd`) VALUES
    (1, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (83, 'Subject 1', 'http://1.localhost123456.com', '', '|1|3|5|', 'n', 0, '2017-09-04'),
    (84, 'Subject 2', 'http://2.localhost123456.com', '', '|2|4|6|', 'n', 0, '2017-09-14'),
    (85, 'Subject 3', 'http://3.localhost123456.com', '', '|3|5|7|', 'n', 0, '2017-09-24'),
    (86, 'Subject 4', 'http://4.localhost123456.com', '', '|4|6|8|', 'n', 0, '2017-10-04'),
    (87, 'Subject 5', 'http://5.localhost123456.com', '', '|5|7|9|', 'n', 0, '2017-10-14'),
    (88, 'Subject 6', 'http://6.localhost123456.com', '', '|6|8|10|', 'n', 0, '2017-10-24'),
    (89, 'Subject 7', 'http://7.localhost123456.com', '', '|7|9|11|', 'n', 0, '2017-11-03'),
    (90, 'Subject 8', 'http://8.localhost123456.com', '', '|8|10|12|', 'n', 0, '2017-11-13'),
    (91, 'Subject 9', 'http://9.localhost123456.com', '', '|9|11|13|', 'n', 0, '2017-11-23'),
    (92, 'Subject 10', 'http://10.localhost123456.com', '', '|10|12|14|', 'n', 0, '2017-12-03'),
    (93, 'Subject 11', 'http://11.localhost123456.com', '', '|11|13|15|', 'n', 0, '2017-12-13'),
    (94, 'Subject 12', 'http://12.localhost123456.com', '', '|12|14|16|', 'n', 0, '2017-12-23'),
    (95, 'Subject 13', 'http://13.localhost123456.com', '', '|13|15|17|', 'n', 0, '2018-01-02'),
    (96, 'Subject 14', 'http://14.localhost123456.com', '', '|14|16|18|', 'n', 0, '2018-01-12'),
    (97, 'Subject 15', 'http://15.localhost123456.com', '', '|15|17|19|', 'n', 0, '2018-01-22'),
    (98, 'Subject 16', 'http://16.localhost123456.com', '', '|16|18|20|', 'n', 0, '2018-02-01'),
    (99, 'Subject 17', 'http://17.localhost123456.com', '', '|17|19|21|', 'n', 0, '2018-02-11'),
    (100, 'Subject 18', 'http://18.localhost123456.com', '', '|18|20|22|', 'n', 0, '2018-02-21'),
    (101, 'Subject 19', 'http://19.localhost123456.com', '', '|19|21|23|', 'n', 0, '2018-03-03'),
    (102, 'Subject 20', 'http://20.localhost123456.com', '', '|20|22|24|', 'n', 0, '2018-03-13'),
    (103, 'Subject 21', 'http://21.localhost123456.com', '', '|21|23|25|', 'n', 0, '2018-03-23'),
    (104, 'Subject 22', 'http://22.localhost123456.com', '', '|22|24|26|', 'n', 0, '2018-04-02'),
    (105, 'Subject 23', 'http://23.localhost123456.com', '', '|23|25|27|', 'n', 0, '2018-04-12'),
    (106, 'Subject 24', 'http://24.localhost123456.com', '', '|24|26|28|', 'n', 0, '2018-04-22'),
    (107, 'Subject 25', 'http://25.localhost123456.com', '', '|25|27|29|', 'n', 0, '2018-05-02'),
    (108, 'Subject 26', 'http://26.localhost123456.com', '', '|26|28|30|', 'n', 0, '2018-05-12'),
    (109, 'Subject 27', 'http://27.localhost123456.com', '', '|27|29|31|', 'n', 0, '2018-05-22'),
    (110, 'Subject 28', 'http://28.localhost123456.com', '', '|28|30|32|', 'n', 0, '2018-06-01'),
    (111, 'Subject 29', 'http://29.localhost123456.com', '', '|29|31|33|', 'n', 0, '2018-06-11'),
    (112, 'Subject 30', 'http://30.localhost123456.com', '', '|30|32|34|', 'n', 0, '2018-06-21'),
    (113, 'Subject 31', 'http://31.localhost123456.com', '', '|31|33|35|', 'n', 0, '2018-07-01'),
    (114, 'Subject 32', 'http://32.localhost123456.com', '', '|32|34|36|', 'n', 0, '2018-07-11'),
    (115, 'Subject 33', 'http://33.localhost123456.com', '', '|33|35|37|', 'n', 0, '2018-07-21'),
    (116, 'Subject 34', 'http://34.localhost123456.com', '', '|34|36|38|', 'n', 0, '2018-07-31'),
    (117, 'Subject 35', 'http://35.localhost123456.com', '', '|35|37|39|', 'n', 0, '2018-08-10'),
    (118, 'Subject 36', 'http://36.localhost123456.com', '', '|36|38|40|', 'n', 0, '2018-08-20'),
    (119, 'Subject 37', 'http://37.localhost123456.com', '', '|37|39|41|', 'n', 0, '2018-08-30'),
    (120, 'Subject 38', 'http://38.localhost123456.com', '', '|38|40|42|', 'n', 0, '2018-09-09'),
    (121, 'Subject 39', 'http://39.localhost123456.com', '', '|39|41|43|', 'n', 0, '2018-09-19'),
    (122, 'Subject 40', 'http://40.localhost123456.com', '', '|40|42|44|', 'n', 0, '2018-09-29'),
    (123, 'Subject 41', 'http://41.localhost123456.com', '', '|41|43|45|', 'n', 0, '2018-10-09'),
    (124, 'Subject 42', 'http://42.localhost123456.com', '', '|42|44|46|', 'n', 0, '2018-10-19'),
    (125, 'Subject 43', 'http://43.localhost123456.com', '', '|43|45|47|', 'n', 0, '2018-10-29'),
    (126, 'Subject 44', 'http://44.localhost123456.com', '', '|44|46|48|', 'n', 0, '2018-11-08'),
    (127, 'Subject 45', 'http://45.localhost123456.com', '', '|45|47|49|', 'n', 0, '2018-11-18'),
    (128, 'Subject 46', 'http://46.localhost123456.com', '', '|46|48|50|', 'n', 0, '2018-11-28'),
    (129, 'Subject 47', 'http://47.localhost123456.com', '', '|47|49|51|', 'n', 0, '2018-12-08'),
    (130, 'Subject 48', 'http://48.localhost123456.com', '', '|48|50|52|', 'n', 0, '2018-12-18'),
    (131, 'Subject 49', 'http://49.localhost123456.com', '', '|49|51|53|', 'n', 0, '2018-12-28'),
    (132, 'Subject 50', 'http://50.localhost123456.com', '', '|50|52|54|', 'n', 0, '2019-01-07'),
    (133, 'Subject 51', 'http://51.localhost123456.com', '', '|51|53|55|', 'n', 0, '2019-01-17'),
    (134, 'Subject 52', 'http://52.localhost123456.com', '', '|52|54|56|', 'n', 0, '2019-01-27'),
    (135, 'Subject 53', 'http://53.localhost123456.com', '', '|53|55|57|', 'n', 0, '2019-02-06'),
    (136, 'Subject 54', 'http://54.localhost123456.com', '', '|54|56|58|', 'n', 0, '2019-02-16'),
    (137, 'Subject 55', 'http://55.localhost123456.com', '', '|55|57|59|', 'n', 0, '2019-02-26'),
    (138, 'Subject 56', 'http://56.localhost123456.com', '', '|56|58|60|', 'n', 0, '2019-03-08'),
    (139, 'Subject 57', 'http://57.localhost123456.com', '', '|57|59|61|', 'n', 0, '2019-03-18'),
    (140, 'Subject 58', 'http://58.localhost123456.com', '', '|58|60|62|', 'n', 0, '2019-03-28'),
    (141, 'Subject 59', 'http://59.localhost123456.com', '', '|59|61|63|', 'n', 0, '2019-04-07'),
    (142, 'Subject 60', 'http://60.localhost123456.com', '', '|60|62|64|', 'n', 0, '2019-04-17'),
    (143, 'Subject 61', 'http://61.localhost123456.com', '', '|61|63|65|', 'n', 0, '2019-04-27'),
    (144, 'Subject 62', 'http://62.localhost123456.com', '', '|62|64|66|', 'n', 0, '2019-05-07'),
    (145, 'Subject 63', 'http://63.localhost123456.com', '', '|63|65|67|', 'n', 0, '2019-05-17'),
    (146, 'Subject 64', 'http://64.localhost123456.com', '', '|64|66|68|', 'n', 0, '2019-05-27'),
    (147, 'Subject 65', 'http://65.localhost123456.com', '', '|65|67|69|', 'n', 0, '2019-06-06'),
    (148, 'Subject 66', 'http://66.localhost123456.com', '', '|66|68|70|', 'n', 0, '2019-06-16'),
    (149, 'Subject 67', 'http://67.localhost123456.com', '', '|67|69|71|', 'n', 0, '2019-06-26'),
    (150, 'Subject 68', 'http://68.localhost123456.com', '', '|68|70|72|', 'n', 0, '2019-07-06'),
    (151, 'Subject 69', 'http://69.localhost123456.com', '', '|69|71|73|', 'n', 0, '2019-07-16'),
    (152, 'Subject 70', 'http://70.localhost123456.com', '', '|70|72|74|', 'n', 0, '2019-07-26'),
    (153, 'Subject 71', 'http://71.localhost123456.com', '', '|71|73|75|', 'n', 0, '2019-08-05'),
    (154, 'Subject 72', 'http://72.localhost123456.com', '', '|72|74|0|', 'n', 0, '2019-08-15'),
    (155, 'Subject 73', 'http://73.localhost123456.com', '', '|73|75|1|', 'n', 0, '2019-08-25'),
    (156, 'Subject 74', 'http://74.localhost123456.com', '', '|74|0|2|', 'n', 0, '2019-09-04'),
    (157, 'Subject 75', 'http://75.localhost123456.com', '', '|75|1|3|', 'n', 0, '2019-09-14'),
    (158, 'Subject 76', 'http://76.localhost123456.com', '', '|0|2|4|', 'n', 0, '2019-09-24'),
    (159, 'Subject 77', 'http://77.localhost123456.com', '', '|1|3|5|', 'n', 0, '2019-10-04'),
    (160, 'Subject 78', 'http://78.localhost123456.com', '', '|2|4|6|', 'n', 0, '2019-10-14'),
    (161, 'Subject 79', 'http://79.localhost123456.com', '', '|3|5|7|', 'n', 0, '2019-10-24'),
    (162, 'Subject 80', 'http://80.localhost123456.com', '', '|4|6|8|', 'n', 0, '2019-11-03'),
    (163, 'Subject 81', 'http://81.localhost123456.com', '', '|5|7|9|', 'n', 0, '2019-11-13'),
    (164, 'Subject 82', 'http://82.localhost123456.com', '', '|6|8|10|', 'n', 0, '2019-11-23'),
    (165, 'Subject 83', 'http://83.localhost123456.com', '', '|7|9|11|', 'n', 0, '2019-12-03'),
    (166, 'Subject 84', 'http://84.localhost123456.com', '', '|8|10|12|', 'n', 0, '2019-12-13'),
    (167, 'Subject 85', 'http://85.localhost123456.com', '', '|9|11|13|', 'n', 0, '2019-12-23'),
    (168, 'Subject 86', 'http://86.localhost123456.com', '', '|10|12|14|', 'n', 0, '2020-01-02'),
    (169, 'Subject 87', 'http://87.localhost123456.com', '', '|11|13|15|', 'n', 0, '2020-01-12'),
    (170, 'Subject 88', 'http://88.localhost123456.com', '', '|12|14|16|', 'n', 0, '2020-01-22'),
    (171, 'Subject 89', 'http://89.localhost123456.com', '', '|13|15|17|', 'n', 0, '2020-02-01'),
    (172, 'Subject 90', 'http://90.localhost123456.com', '', '|14|16|18|', 'n', 0, '2020-02-11'),
    (173, 'Subject 91', 'http://91.localhost123456.com', '', '|15|17|19|', 'n', 0, '2020-02-21'),
    (174, 'Subject 92', 'http://92.localhost123456.com', '', '|16|18|20|', 'n', 0, '2020-03-02'),
    (175, 'Subject 93', 'http://93.localhost123456.com', '', '|17|19|21|', 'n', 0, '2020-03-12'),
    (176, 'Subject 94', 'http://94.localhost123456.com', '', '|18|20|22|', 'n', 0, '2020-03-22'),
    (177, 'Subject 95', 'http://95.localhost123456.com', '', '|19|21|23|', 'n', 0, '2020-04-01'),
    (178, 'Subject 96', 'http://96.localhost123456.com', '', '|20|22|24|', 'n', 0, '2020-04-11'),
    (179, 'Subject 97', 'http://97.localhost123456.com', '', '|21|23|25|', 'n', 0, '2020-04-21'),
    (180, 'Subject 98', 'http://98.localhost123456.com', '', '|22|24|26|', 'n', 0, '2020-05-01'),
    (181, 'Subject 99', 'http://99.localhost123456.com', '', '|23|25|27|', 'n', 0, '2020-05-11'),
    (182, 'Subject 100', 'http://100.localhost123456.com', '', '|24|26|28|', 'n', 0, '2020-05-21'),
    (183, 'Subject 101', 'http://101.localhost123456.com', '', '|25|27|29|', 'n', 0, '2020-05-31'),
    (184, 'Subject 102', 'http://102.localhost123456.com', '', '|26|28|30|', 'n', 0, '2020-06-10'),
    (185, 'Subject 103', 'http://103.localhost123456.com', '', '|27|29|31|', 'n', 0, '2020-06-20'),
    (186, 'Subject 104', 'http://104.localhost123456.com', '', '|28|30|32|', 'n', 0, '2020-06-30'),
    (187, 'Subject 105', 'http://105.localhost123456.com', '', '|29|31|33|', 'n', 0, '2020-07-10'),
    (188, 'Subject 106', 'http://106.localhost123456.com', '', '|30|32|34|', 'n', 0, '2020-07-20'),
    (189, 'Subject 107', 'http://107.localhost123456.com', '', '|31|33|35|', 'n', 0, '2020-07-30'),
    (190, 'Subject 108', 'http://108.localhost123456.com', '', '|32|34|36|', 'n', 0, '2020-08-09'),
    (191, 'Subject 109', 'http://109.localhost123456.com', '', '|33|35|37|', 'n', 0, '2020-08-19'),
    (192, 'Subject 110', 'http://110.localhost123456.com', '', '|34|36|38|', 'n', 0, '2020-08-29'),
    (193, 'Subject 111', 'http://111.localhost123456.com', '', '|35|37|39|', 'n', 0, '2020-09-08'),
    (194, 'Subject 112', 'http://112.localhost123456.com', '', '|36|38|40|', 'n', 0, '2020-09-18'),
    (195, 'Subject 113', 'http://113.localhost123456.com', '', '|37|39|41|', 'n', 0, '2020-09-28'),
    (196, 'Subject 114', 'http://114.localhost123456.com', '', '|38|40|42|', 'n', 0, '2020-10-08'),
    (197, 'Subject 115', 'http://115.localhost123456.com', '', '|39|41|43|', 'n', 0, '2020-10-18'),
    (198, 'Subject 116', 'http://116.localhost123456.com', '', '|40|42|44|', 'n', 0, '2020-10-28'),
    (199, 'Subject 117', 'http://117.localhost123456.com', '', '|41|43|45|', 'n', 0, '2020-11-07'),
    (200, 'Subject 118', 'http://118.localhost123456.com', '', '|42|44|46|', 'n', 0, '2020-11-17'),
    (201, 'Subject 119', 'http://119.localhost123456.com', '', '|43|45|47|', 'n', 0, '2020-11-27'),
    (202, 'Subject 120', 'http://120.localhost123456.com', '', '|44|46|48|', 'n', 0, '2020-12-07'),
    (203, 'Subject 121', 'http://121.localhost123456.com', '', '|45|47|49|', 'n', 0, '2020-12-17'),
    (204, 'Subject 122', 'http://122.localhost123456.com', '', '|46|48|50|', 'n', 0, '2020-12-27'),
    (205, 'Subject 123', 'http://123.localhost123456.com', '', '|47|49|51|', 'n', 0, '2021-01-06'),
    (206, 'Subject 124', 'http://124.localhost123456.com', '', '|48|50|52|', 'n', 0, '2021-01-16'),
    (207, 'Subject 125', 'http://125.localhost123456.com', '', '|49|51|53|', 'n', 0, '2021-01-26'),
    (208, 'Subject 126', 'http://126.localhost123456.com', '', '|50|52|54|', 'n', 0, '2021-02-05'),
    (209, 'Subject 127', 'http://127.localhost123456.com', '', '|51|53|55|', 'n', 0, '2021-02-15'),
    (210, 'Subject 128', 'http://128.localhost123456.com', '', '|52|54|56|', 'n', 0, '2021-02-25'),
    (211, 'Subject 129', 'http://129.localhost123456.com', '', '|53|55|57|', 'n', 0, '2021-03-07'),
    (212, 'Subject 130', 'http://130.localhost123456.com', '', '|54|56|58|', 'n', 0, '2021-03-17'),
    (213, 'Subject 131', 'http://131.localhost123456.com', '', '|55|57|59|', 'n', 0, '2021-03-27'),
    (214, 'Subject 132', 'http://132.localhost123456.com', '', '|56|58|60|', 'n', 0, '2021-04-06'),
    (215, 'Subject 133', 'http://133.localhost123456.com', '', '|57|59|61|', 'n', 0, '2021-04-16'),
    (216, 'Subject 134', 'http://134.localhost123456.com', '', '|58|60|62|', 'n', 0, '2021-04-26'),
    (217, 'Subject 135', 'http://135.localhost123456.com', '', '|59|61|63|', 'n', 0, '2021-05-06'),
    (218, 'Subject 136', 'http://136.localhost123456.com', '', '|60|62|64|', 'n', 0, '2021-05-16'),
    (219, 'Subject 137', 'http://137.localhost123456.com', '', '|61|63|65|', 'n', 0, '2021-05-26'),
    (220, 'Subject 138', 'http://138.localhost123456.com', '', '|62|64|66|', 'n', 0, '2021-06-05'),
    (221, 'Subject 139', 'http://139.localhost123456.com', '', '|63|65|67|', 'n', 0, '2021-06-15'),
    (222, 'Subject 140', 'http://140.localhost123456.com', '', '|64|66|68|', 'n', 0, '2021-06-25'),
    (223, 'Subject 141', 'http://141.localhost123456.com', '', '|65|67|69|', 'n', 0, '2021-07-05'),
    (224, 'Subject 142', 'http://142.localhost123456.com', '', '|66|68|70|', 'n', 0, '2021-07-15'),
    (225, 'Subject 143', 'http://143.localhost123456.com', '', '|67|69|71|', 'n', 0, '2021-07-25'),
    (226, 'Subject 144', 'http://144.localhost123456.com', '', '|68|70|72|', 'n', 0, '2021-08-04'),
    (227, 'Subject 145', 'http://145.localhost123456.com', '', '|69|71|73|', 'n', 0, '2021-08-14'),
    (228, 'Subject 146', 'http://146.localhost123456.com', '', '|70|72|74|', 'n', 0, '2021-08-24'),
    (229, 'Subject 147', 'http://147.localhost123456.com', '', '|71|73|75|', 'n', 0, '2021-09-03'),
    (230, 'Subject 148', 'http://148.localhost123456.com', '', '|72|74|0|', 'n', 0, '2021-09-13'),
    (231, 'Subject 149', 'http://149.localhost123456.com', '', '|73|75|1|', 'n', 0, '2021-09-23'),
    (232, 'Subject 150', 'http://150.localhost123456.com', '', '|74|0|2|', 'n', 0, '2021-10-03'),
    (233, 'New Pending Joined', 'https://aaaaaaa.com', '', '|80|', 'n', 1, '2020-04-24'),
    (234, 'Subject Current', 'https://aaaaccccccccc.com', '', '|81|', 'n', 0, '2020-04-24');

-- --------------------------------------------------------

--
-- Table structure for table `trex_kim`
--

CREATE TABLE `trex_kim` (
    `mID` int(10) NOT NULL,
    `mEmail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `fNiq` mediumint(6) UNSIGNED NOT NULL,
    `mName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
    `mURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `mPassword` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `mVisible` tinyint(1) NOT NULL DEFAULT '0',
    `mPending` tinyint(1) NOT NULL DEFAULT '0',
    `mPrevious` tinyint(1) NOT NULL DEFAULT '0',
    `mUpdate` enum('y','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n',
    `mEdit` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    `mAdd` date NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_kim`
--

INSERT INTO `trex_kim` (`mID`, `mEmail`, `fNiq`, `mName`, `mURL`, `mPassword`, `mVisible`, `mPending`, `mPrevious`, `mUpdate`, `mEdit`, `mAdd`) VALUES
    (1, 'kimmm+someone@gmail.com', 1, 'Kimmer', 'https://myurl.com', 'ff33c53a4ca55a21e8ea44f79b728260', 1, 0, 0, 'y', '0000-00-00 00:00:00', '2020-04-20');

-- --------------------------------------------------------

--
-- Table structure for table `trex_logs`
--

CREATE TABLE `trex_logs` (
    `logID` int(10) NOT NULL,
    `userNiq` mediumint(4) NOT NULL,
    `logUser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `logInfo` text COLLATE utf8_unicode_ci NOT NULL,
    `logLast` datetime NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_lyrics`
--

CREATE TABLE `trex_lyrics` (
    `lyID` int(10) NOT NULL,
    `fNiq` mediumint(6) UNSIGNED NOT NULL,
    `aNiq` int(10) UNSIGNED NOT NULL,
    `lyName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `lyText` longtext COLLATE utf8_unicode_ci NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_lyrics_albums`
--

CREATE TABLE `trex_lyrics_albums` (
    `aID` int(10) NOT NULL,
    `fNiq` mediumint(6) UNSIGNED NOT NULL,
    `aArtist` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aYear` mediumint(4) NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_members`
--

CREATE TABLE `trex_members` (
    `mID` mediumint(6) NOT NULL,
    `mEmail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `fNiq` mediumint(6) UNSIGNED NOT NULL,
    `mName` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
    `mURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `mCountry` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
    `mPassword` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `mExtra` text COLLATE utf8_unicode_ci NOT NULL,
    `mVisible` tinyint(1) NOT NULL DEFAULT '0',
    `mPending` tinyint(1) NOT NULL DEFAULT '0',
    `mUpdate` enum('y','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n',
    `mEdit` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    `mAdd` date NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_members`
--

INSERT INTO `trex_members` (`mID`, `mEmail`, `fNiq`, `mName`, `mURL`, `mCountry`, `mPassword`, `mExtra`, `mVisible`, `mPending`, `mUpdate`, `mEdit`, `mAdd`) VALUES
    (1, 'joiner+kkkkjoiner@gmaaaaaaail.com', 1, 'Joiner', 'http://myurl.com', 'El Salvador', '6f55c171fdf2ba21bff9a9f17cb76c65', '', 1, 0, 'n', '2020-04-20 21:29:56', '2020-04-20'),
    (2, 'gkhjgffk@ojokhflg.com', 1, 'New Name', 'http://fan123.com', 'Bahrain', '5f4dcc3b5aa765d61d8327deb882cf99', '', 0, 0, 'y', '0000-00-00 00:00:00', '2020-04-24'),
    (3, 'sdfsdfsfd@jkjlgf.com', 1, 'Dsffdfs', '', 'Australia', 'd8b27a5482e64b2ff7968fe50583b0ed', '', 1, 0, 'n', '0000-00-00 00:00:00', '2020-04-24'),
    (4, 'sdfsdfsffffdsssss+dddddd@jkjlgf.com', 1, 'Dsffdfs', '', 'Australia', 'f562ddf743b7c2c48ee10e2c3651862c', '', 0, 0, 'n', '0000-00-00 00:00:00', '2020-04-24');

-- --------------------------------------------------------

--
-- Table structure for table `trex_options`
--

CREATE TABLE `trex_options` (
    `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `text` text COLLATE utf8_unicode_ci NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_options`
--

INSERT INTO `trex_options` (`name`, `text`) VALUES
    ('collective_name', 'Collective Name'),
    ('per_joined', '25'),
    ('per_members', '25'),
    ('per_page', '15'),
    ('adm_path', '/app/public/admin/inc/'),
    ('adm_http', 'http://localhost:8041/admin/inc/'),
    ('aff_path', '/app/public/images/affiliates/'),
    ('aff_http', 'http://localhost:8041/images/affiliates/'),
    ('img_path', '/app/public/images/'),
    ('img_http', 'http://localhost:8041/images/'),
    ('jnd_path', '/app/public/admin/images/joined/'),
    ('jnd_http', 'http://localhost:8041/images/joined/'),
    ('wsh_path', '/app/public/admin/images/wishlist/'),
    ('wsh_http', 'http://localhost:8041/images/wishlist/'),
    ('my_name', 'My Name'),
    ('my_email', 'you@fhgfhfghfghfgohfkghpf.com'),
    ('my_website', 'http://localhost:8041/samplecollective'),
    ('user_username', 'admin'),
    ('user_password', '5f4dcc3b5aa765d61d8327deb882cf99'),
    ('user_salthash', '18cc024da690a3b19e785ca26ae8ea476a73b596'),
    ('user_passhint', 'password'),
    ('user_passhinthash', ''),
    ('markup', 'xhtml'),
    ('format_links', '&amp;#187;'),
    ('kim_join', 'http://localhost:8041/samplecollective/kim-join.php'),
    ('kim_list', 'http://localhost:8041/samplecollective/kim-list.php'),
    ('kim_reset', 'http://localhost:8041/samplecollective/kim-reset.php'),
    ('kim_update', 'http://localhost:8041/samplecollective/kim-update.php'),
    ('notify_approval', 'y'),
    ('notify_update', 'y'),
    ('akismet_key', ''),
    ('akismet_opt', 'n'),
    ('antispam_spam_words_required', 'alert|bcc:|cc:|content-type|document.cookie|ejaculate|fag|javascript|jism|onclick|onload'),
    ('antispam_spam_words', ''),
    ('antispam_opt', 'y'),
    ('captcha_opt', 'n'),
    ('javascript_opt', 'y'),
    ('javascript_key', '5b1a6f8a047d5e6e5ec60de62ce1484e11def449'),
    ('codes_opt', 'y'),
    ('codes_filesize', '921600'),
    ('codes_formurl', 'donate.php'),
    ('codes_img_path', '/app/public/images/codes/'),
    ('codes_img_http', 'http://localhost:8041/images/codes/'),
    ('codes_order', 'DESC'),
    ('kim_opt', 'y'),
    ('lyrics_opt', 'y'),
    ('quotes_opt', 'y'),
    ('wishlist_opt', 'n'),
    ('updates_opt', 'y'),
    ('updates_akismet', 'n'),
    ('updates_akismet_key', ''),
    ('updates_antispam', 'y'),
    ('updates_captcha', 'n'),
    ('updates_comments', 'n'),
    ('updates_comments_header', '/home/username/site/header.php'),
    ('updates_comments_footer', '/home/username/site/footer.php'),
    ('updates_comments_moderation', 'n'),
    ('updates_comments_notification', 'n'),
    ('updates_crosspost_dw', 'n'),
    ('updates_crosspost_dw_user', ''),
    ('updates_crosspost_dw_pass', ''),
    ('updates_crosspost_ij', 'n'),
    ('updates_crosspost_ij_user', ''),
    ('updates_crosspost_ij_pass', ''),
    ('updates_crosspost_lj', 'n'),
    ('updates_crosspost_lj_user', ''),
    ('updates_crosspost_lj_pass', ''),
    ('updates_crosspost_dw_link', 'y'),
    ('updates_crosspost_ij_link', 'y'),
    ('updates_crosspost_lj_link', 'y'),
    ('updates_gravatar', 'y'),
    ('updates_gravatar_size', '60'),
    ('updates_gravatar_rating', 'PG'),
    ('updates_prettyurls', 'n'),
    ('updates_url', 'http://localhost:8041/samplecollective/updates.php'),
    ('wishlist_granted', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `trex_quotes`
--

CREATE TABLE `trex_quotes` (
    `qID` mediumint(5) NOT NULL,
    `fNiq` mediumint(6) UNSIGNED NOT NULL,
    `qQuote` text COLLATE utf8_unicode_ci NOT NULL,
    `qAuthor` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `qUpdated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    `qAdded` datetime NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_success`
--

CREATE TABLE `trex_success` (
    `messID` mediumint(4) NOT NULL,
    `messType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `messURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `messText` text COLLATE utf8_unicode_ci NOT NULL,
    `messInfo` text COLLATE utf8_unicode_ci NOT NULL,
    `messAdded` datetime NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_success`
--

INSERT INTO `trex_success` (`messID`, `messType`, `messURL`, `messText`, `messInfo`, `messAdded`) VALUES
    (1, 'User Log-In Success', 'http://localhost/admin/index.php', 'Username: My Name\nPassword: password', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36|', '2020-02-27 18:26:24'),
    (2, 'User Log-In Success', 'http://localhost/admin/members.php', 'Username: username\nPassword: password', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36|', '2020-02-27 18:27:45'),
    (3, 'User Log-In Success', 'http://localhost/admin/emails.php', 'Username: admin\nPassword: password', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36|', '2020-02-27 18:35:43'),
    (4, 'New Comment', 'http://localhost/admin/inc/fun-process.inc.php', 'Name: Gdfgdgdfg\nE-mail: ggggdkd+kd@kkkggg.com\nURL: https://123455.com\nComment: GGGFDGD', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36|', '2020-04-20 21:03:27'),
    (5, 'New Comment', 'http://localhost/admin/inc/fun-process.inc.php', 'Name: Gdfgdgdfg\nE-mail: ggggdkd+kd@kkkggg.com\nURL: https://123455.com\nComment: GGGFDGD', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36|', '2020-04-20 21:04:16');

-- --------------------------------------------------------

--
-- Table structure for table `trex_templates`
--

CREATE TABLE `trex_templates` (
    `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `template` text COLLATE utf8_unicode_ci NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_templates`
--

INSERT INTO `trex_templates` (`name`, `title`, `template`) VALUES
    ('affiliates_template', 'Affiliates', '&lt;a href=&quot;{url}&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject}&quot; title=&quot;{subject}&quot; /&gt;&lt;/a&gt;'),
    ('collective_stats_template', 'Collective Stats', '&lt;table id=&quot;stats&quot; width=&quot;100%&quot;&gt;&lt;tbody&gt;\r\n&lt;tr&gt;&lt;td class=&quot;right&quot;&gt;Current Listings:&lt;/td&gt;\r\n&lt;td class=&quot;left&quot;&gt;{current} (&lt;em&gt;{upcoming} Upcoming &lt;/em&gt;)&lt;/td&gt;&lt;/tr&gt;\r\n&lt;tr&gt;&lt;td class=&quot;right&quot;&gt;Joined Listings:&lt;/td&gt;\r\n&lt;td class=&quot;left&quot;&gt;{joined} Listings&lt;/td&gt;&lt;/tr&gt;\r\n&lt;tr&gt;&lt;td class=&quot;right&quot;&gt;Overall Member Count:&lt;/td&gt;\r\n&lt;td class=&quot;left&quot;&gt;{mApproved} (&lt;em&gt;{mPending} Pending &lt;/em&gt;)&lt;/td&gt;&lt;/tr&gt;\r\n&lt;tr&gt;&lt;td class=&quot;right&quot;&gt;Newest Listing:&lt;/td&gt;\r\n&lt;td class=&quot;left&quot;&gt;{newest}&lt;/td&gt;&lt;/tr&gt;\r\n&lt;/tbody&gt;&lt;/table&gt;'),
    ('date_template', 'Date', 'F j, Y'),
    ('listings_template', 'Listings', '&lt;p class=&quot;img&quot;&gt;&lt;a href=&quot;{url}&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject}&quot; title=&quot;{subject}&quot; class=&quot;current&quot;&gt;&lt;/a&gt;&lt;/p&gt;\r\n&lt;p class=&quot;details&quot;&gt;\r\n&lt;strong&gt;Subject:&lt;/strong&gt; {subject}&lt;br&gt;\r\n&lt;strong&gt;Members:&lt;/strong&gt; {approved} (&lt;em&gt;{pending} Pending &lt;/em&gt;)&lt;br&gt;\r\n&lt;strong&gt;Since:&lt;/strong&gt; {since}&lt;br&gt;\r\n&lt;strong&gt;Last Updated:&lt;/strong&gt; {updated}\r\n&lt;/p&gt;\r\n&lt;p class=&quot;desc&quot;&gt;\r\n{desc}\r\n&lt;/p&gt;'),
    ('joined_template', 'Joined', '&lt;a href=&quot;{url}&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject}&quot; title=&quot;{subject}&quot; class=&quot;joined&quot; /&gt;&lt;/a&gt;'),
    ('kim_stats_template', 'KIM Stats', '&lt;table class=&quot;kim-stats&quot; width=&quot;100%&quot;&gt;&lt;tbody&gt;\r\n&lt;tr&gt;&lt;td class=&quot;tr&quot;&gt;Listed:&lt;/td&gt;\r\n&lt;td class=&quot;tl&quot;&gt;{members} (&lt;em&gt;{pending} Pending &lt;/em&gt;)&lt;/td&gt;&lt;/tr&gt;\r\n&lt;tr&gt;&lt;td class=&quot;tr&quot;&gt;Last Updated:&lt;/td&gt;\r\n&lt;td class=&quot;tl&quot;&gt;{updated}&lt;/td&gt;&lt;/tr&gt;\r\n&lt;/tbody&gt;&lt;/table&gt;'),
    ('updates_template', 'Updates', '{title}\r\n{date} {entry}\r\nFiled Under: {categories}  \r\n{permalink}'),
    ('wishlist_top_template', 'Wishlist: Top', '&lt;p class=&quot;floatLeft&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject} ({category})&quot; title=&quot;{subject} ({category})&quot; class&quot;top-wishlist&quot;&gt;&lt;br&gt;{desc}&lt;/p&gt;'),
    ('wishlist_granted_template', 'Wishlist: Granted', '&lt;p class=&quot;floatLeft&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject} ({category})&quot; title=&quot;{subject} ({category})&quot; class&quot;top-wishlist&quot;&gt;&lt;br&gt;{desc}&lt;/p&gt;'),
    ('wishlist_query_template', 'Wishlist: Query', '&lt;p class=&quot;floatLeft&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject} ({category})&quot; title=&quot;{subject} ({category})&quot; class&quot;top-wishlist&quot;&gt;&lt;br&gt;{desc}&lt;/p&gt;'),
    ('wishlist_template', 'Wishlist', '&lt;p class=&quot;floatLeft&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject} ({category})&quot; title=&quot;{subject} ({category})&quot; class&quot;top-wishlist&quot;&gt;&lt;br&gt;{desc}&lt;/p&gt;');

-- --------------------------------------------------------

--
-- Table structure for table `trex_templates_emails`
--

CREATE TABLE `trex_templates_emails` (
    `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `template` text COLLATE utf8_unicode_ci NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_templates_emails`
--

INSERT INTO `trex_templates_emails` (`name`, `title`, `template`) VALUES
    ('affiliates_approve', 'Affiliates: Approve', 'Hello,\n\nThis is a notice to let you know that you have been added at the {listing} {type}! You can now see your listing listed at the {type}: <{listing_url}>.\n\nIf you need to change your information, you can send in another affiliation request at the {type}. :)\n\n--\n{owner}\n{listing_title} <{listing_url}>'),
    ('affiliates_closed', 'Affiliates: Closed', 'Hello,\n\nThis is a notice to let you know that the {listing} listing has closed. If you could remove your link(s) as soon as possible, it would be greatly appreciated!\n\n--\n{owner}\n{listing} <{listing_url}>'),
    ('affiliates_moved', 'Affiliates: Moved', 'Hello {name},\n\nThis is a notice to let you know that the {listing} listing has closed. If you could remove your links as soon as possible, it would be greatly appreciated!\n\n--\n{owner}\n{listing} <{listing_url}>'),
    ('kim_approve', 'KIM: Approve', 'Hello {name},\n\nThis is a notice to let you know that you have been removed from the pending list at {collective_name}\'s KIM list and added to the members list. You can now see your information at the list: <{kim_list}>.\n\nIf you need to change your information, you can do so here: <{kim_update}>. :D\n\n--\n{owner}\n{collective_name} <{collective_url}>'),
    ('kim_update', 'KIM: Update', 'Hello {name},\n\nThis is a notice to let you know that you have been removed from the pending list at {collective_name}\'s KIM list and your information has been updated at your request. Your information is below: \n\nName: {name}\nE-Mail Address: {email}\nURL: {url}\nListing: {listing}\n\nIf this has been an error, or the information listed is wrong, feel more than free to reply to this message and let me know. Thank you for keeping your information up to date! :D\n\n--\n{owner}\n{collective_name} <{collective_url}>'),
    ('members_approve', 'Members: Approve', 'Hello {name},\n\nThis is a notice to let you know that you have been removed from the pending list at the {listing} listing and added to the members list. You can now see your information at the listing: <{listing_url}>.\n\nIf you need to change your information, you can do so at the listing. :D\n\n--\n{owner}\n{title} <{listing_url}>'),
    ('members_closed', 'Members: Closed', 'Hello {name},\n\nThis is a notice to let you know that the {listing} listing has closed. If you could remove your link(s) (if applicable) as soon as possible, it would be greatly appreciated!\n\n--\n{owner}\n{listing} <{listing_url}>'),
    ('members_delete', 'Members: Delete', ''),
    ('members_lostpass', 'Members: Reset Password', 'Hello {name},\n\nSomeone (hopefully you) asked for a renewal of their password at the {listing} listing. Below is an automated alphanumerical password; I strongly recommend you change your password by way of update form at the listing:\n\nPassword: {password}\n\nIf this is in error, simply send in an update form updating your password. If the problem persists, feel more than free to contact me!\n\n--\n{owner}\n{collective_name} <{collective_url}>'),
    ('members_moved', 'Members: Moved', 'Hello {name},\n\nThis is a notice to let you know that the {listing} listing has closed. If you could remove your links (if applicable) as soon as possible, it would be greatly appreciated!\n\n--\n{owner}\n{listing} <{listing_url}>'),
    ('members_update', 'Members: Update', 'Hello {name},\n\nThis is a notice to let you know that you have been removed from the pending list at the {listing} listing and your information has been updated at your request. Your information is below: \n\nName: {name}\nE-Mail Address: {email}\nURL: {url}\nCountry: {country}\n\nIf this has been an error, or the information listed is wrong, feel more than free to reply to this message and let me know. Thank you for keeping your information up to date! :D\n\n--\n{owner}\n{listing_title} <{listing_url}>');

-- --------------------------------------------------------

--
-- Table structure for table `trex_updates`
--

    CREATE TABLE `trex_updates` (
    `uID` int(10) NOT NULL,
    `uTitle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `uCategory` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '!0!',
    `uEntry` longtext COLLATE utf8_unicode_ci NOT NULL,
    `uDW` enum('y','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n',
    `uDWOpt` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '|community:|tags:|userpic:|',
    `uIJ` enum('y','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n',
    `uIJOpt` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '|community:|tags:|userpic:|',
    `uLJ` enum('y','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n',
    `uLJOpt` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '|community:|tags:|userpic:|',
    `uPending` tinyint(1) NOT NULL DEFAULT '0',
    `uDisabled` tinyint(1) NOT NULL DEFAULT '0',
    `uAdded` datetime NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_updates`
--

    INSERT INTO `trex_updates` (`uID`, `uTitle`, `uCategory`, `uEntry`, `uDW`, `uDWOpt`, `uIJ`, `uIJOpt`, `uLJ`, `uLJOpt`, `uPending`, `uDisabled`, `uAdded`) VALUES
    (1, 'WITH COMMENTS', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 1, '2020-02-10 20:42:29'),
    (2, 'cool update 2', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (3, 'cool update 3', '!0!1!', 'Blablah4444', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (4, 'cool update ', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (5, 'cool update 2', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (6, 'cool update 3', '!0!1!', 'Blablah4444', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (7, 'cool update', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (8, 'cool update 2', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (9, 'cool update 3', '!0!1!', 'Blablah4444', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (10, 'cool update ', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (11, 'cool update 2', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (12, 'cool update 3', '!0!1!', 'Blablah4444', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (13, 'cool update', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (14, 'cool update 2', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (15, 'cool update 3', '!0!1!', 'Blablah4444', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (16, 'cool update ', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (17, 'cool update 2', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (18, 'cool update 3', '!0!1!', 'Blablah4444', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (19, 'cool update', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (20, 'cool update 2', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (21, 'cool update 3', '!0!1!', 'Blablah4444', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (22, 'cool update ', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (23, 'cool update 2', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17'),
    (24, 'cool update 3', '!0!1!', 'Blablah4444', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 18:48:17');

-- --------------------------------------------------------

--
-- Table structure for table `trex_updates_comments`
--

    CREATE TABLE `trex_updates_comments` (
    `cID` int(20) NOT NULL,
    `eNiq` int(10) UNSIGNED NOT NULL,
    `cName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `cEmail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `cURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `cComment` text COLLATE utf8_unicode_ci NOT NULL,
    `cInfo` text COLLATE utf8_unicode_ci NOT NULL,
    `cFlag` enum('legit','spam') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'legit',
    `cPending` tinyint(1) NOT NULL DEFAULT '0',
    `cAdded` datetime NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_updates_comments`
--

    INSERT INTO `trex_updates_comments` (`cID`, `eNiq`, `cName`, `cEmail`, `cURL`, `cComment`, `cInfo`, `cFlag`, `cPending`, `cAdded`) VALUES
    (1, 1, 'Gdfgdgdfg', 'ggggdkd+kd@kkkggg.com', 'https://123455.com', 'GGGFDGD  777', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36|', 'legit', 0, '2020-04-20 21:03:27'),
    (2, 1, 'Gdfgdgdfg', 'ggggdkd+kd@kkkggg.com', 'https://123455.com', 'GGGFDGD', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36|', 'legit', 0, '2020-04-20 21:04:16');

-- --------------------------------------------------------

--
-- Table structure for table `trex_wishlist`
--

    CREATE TABLE `trex_wishlist` (
    `wID` smallint(3) NOT NULL,
    `wSubject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `wURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `wImage` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `wCategory` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
    `wDesc` text COLLATE utf8_unicode_ci NOT NULL,
    `wType` enum('custom','granted','list','top') COLLATE utf8_unicode_ci NOT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_wishlist`
--

    INSERT INTO `trex_wishlist` (`wID`, `wSubject`, `wURL`, `wImage`, `wCategory`, `wDesc`, `wType`) VALUES
    (1, '1', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (2, '2', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (3, '3', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (4, '4', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (5, '5', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (6, '6', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (7, 'My Wish', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (8, 'My Wish11', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (9, 'My Wish', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (10, 'My Wish11', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (11, 'My Wish', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (12, 'My Wish11', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (13, 'My Wish', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (14, 'My Wish11', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (15, 'My Wish', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (16, 'My Wish1111', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (17, '1', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (18, '2', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (19, '3', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (20, '4', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (21, '5', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (22, '6', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (23, 'My Wish', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (24, 'My Wish11', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (25, 'My Wish', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (26, 'My Wish11', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (27, 'My Wish', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (28, 'My Wish11', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (29, 'My Wish', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (30, 'My Wish11', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (31, 'My Wish', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list'),
    (32, 'My Wish1111', 'http://wwwwwwwwwwwwwwwwwwwwwwwwww.com', 'LAdminWish_', '!8!21!', 'My regular', 'list');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `trex`
--
    ALTER TABLE `trex`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `subject` (`subject`);

--
-- Indexes for table `trex_affiliates`
--
    ALTER TABLE `trex_affiliates`
    ADD PRIMARY KEY (`aID`);

--
-- Indexes for table `trex_categories`
--
    ALTER TABLE `trex_categories`
    ADD PRIMARY KEY (`catid`);

--
-- Indexes for table `trex_codes`
--
    ALTER TABLE `trex_codes`
    ADD PRIMARY KEY (`cID`);

--
-- Indexes for table `trex_codes_categories`
--
    ALTER TABLE `trex_codes_categories`
    ADD PRIMARY KEY (`catID`),
    ADD UNIQUE KEY `fNiq` (`fNiq`,`catName`(70),`catParent`);

--
-- Indexes for table `trex_codes_donors`
--
    ALTER TABLE `trex_codes_donors`
    ADD PRIMARY KEY (`dID`),
    ADD UNIQUE KEY `dName` (`dName`(25),`dEmail`(80),`dURL`(90));

--
-- Indexes for table `trex_codes_sizes`
--
    ALTER TABLE `trex_codes_sizes`
    ADD PRIMARY KEY (`sID`);

--
-- Indexes for table `trex_errors`
--
    ALTER TABLE `trex_errors`
    ADD PRIMARY KEY (`messID`);

--
-- Indexes for table `trex_joined`
--
    ALTER TABLE `trex_joined`
    ADD PRIMARY KEY (`jID`);

--
-- Indexes for table `trex_kim`
--
    ALTER TABLE `trex_kim`
    ADD PRIMARY KEY (`mID`),
    ADD UNIQUE KEY `mName` (`fNiq`,`mEmail`);

--
-- Indexes for table `trex_logs`
--
    ALTER TABLE `trex_logs`
    ADD PRIMARY KEY (`logID`);

--
-- Indexes for table `trex_lyrics`
--
    ALTER TABLE `trex_lyrics`
    ADD PRIMARY KEY (`lyID`);

--
-- Indexes for table `trex_lyrics_albums`
--
    ALTER TABLE `trex_lyrics_albums`
    ADD PRIMARY KEY (`aID`);

--
-- Indexes for table `trex_members`
--
    ALTER TABLE `trex_members`
    ADD PRIMARY KEY (`mID`),
    ADD UNIQUE KEY `mName` (`fNiq`,`mEmail`);

--
-- Indexes for table `trex_options`
--
    ALTER TABLE `trex_options`
    ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `trex_quotes`
--
    ALTER TABLE `trex_quotes`
    ADD PRIMARY KEY (`qID`);

--
-- Indexes for table `trex_success`
--
    ALTER TABLE `trex_success`
    ADD PRIMARY KEY (`messID`);

--
-- Indexes for table `trex_templates`
--
    ALTER TABLE `trex_templates`
    ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `trex_templates_emails`
--
    ALTER TABLE `trex_templates_emails`
    ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `trex_updates`
--
    ALTER TABLE `trex_updates`
    ADD PRIMARY KEY (`uID`),
    ADD UNIQUE KEY `uTitle` (`uID`,`uTitle`(50));

--
-- Indexes for table `trex_updates_comments`
--
    ALTER TABLE `trex_updates_comments`
    ADD PRIMARY KEY (`cID`);

--
-- Indexes for table `trex_wishlist`
--
    ALTER TABLE `trex_wishlist`
    ADD PRIMARY KEY (`wID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `trex`
--
    ALTER TABLE `trex`
    MODIFY `id` mediumint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `trex_affiliates`
--
    ALTER TABLE `trex_affiliates`
    MODIFY `aID` mediumint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `trex_categories`
--
    ALTER TABLE `trex_categories`
    MODIFY `catid` smallint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `trex_codes`
--
    ALTER TABLE `trex_codes`
    MODIFY `cID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `trex_codes_categories`
--
    ALTER TABLE `trex_codes_categories`
    MODIFY `catID` mediumint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trex_codes_donors`
--
    ALTER TABLE `trex_codes_donors`
    MODIFY `dID` mediumint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `trex_codes_sizes`
--
    ALTER TABLE `trex_codes_sizes`
    MODIFY `sID` smallint(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `trex_errors`
--
    ALTER TABLE `trex_errors`
    MODIFY `messID` mediumint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `trex_joined`
--
    ALTER TABLE `trex_joined`
    MODIFY `jID` mediumint(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=235;

--
-- AUTO_INCREMENT for table `trex_kim`
--
    ALTER TABLE `trex_kim`
    MODIFY `mID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `trex_logs`
--
    ALTER TABLE `trex_logs`
    MODIFY `logID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trex_lyrics`
--
    ALTER TABLE `trex_lyrics`
    MODIFY `lyID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trex_lyrics_albums`
--
    ALTER TABLE `trex_lyrics_albums`
    MODIFY `aID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trex_members`
--
    ALTER TABLE `trex_members`
    MODIFY `mID` mediumint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `trex_quotes`
--
    ALTER TABLE `trex_quotes`
    MODIFY `qID` mediumint(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trex_success`
--
    ALTER TABLE `trex_success`
    MODIFY `messID` mediumint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `trex_updates`
--
    ALTER TABLE `trex_updates`
    MODIFY `uID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `trex_updates_comments`
--
    ALTER TABLE `trex_updates_comments`
    MODIFY `cID` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `trex_wishlist`
--
    ALTER TABLE `trex_wishlist`
    MODIFY `wID` smallint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
    COMMIT;
