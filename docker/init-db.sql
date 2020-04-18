-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Apr 16, 2020 at 09:14 PM
-- Server version: 5.5.62
-- PHP Version: 7.2.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `bambino`
--
USE `bambino`;

-- --------------------------------------------------------

--
-- Table structure for table `trex`
--

DROP TABLE IF EXISTS `trex`;
CREATE TABLE IF NOT EXISTS `trex` (
    `id` mediumint(6) NOT NULL AUTO_INCREMENT,
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
    `markup` enum('html','xhtml') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'xhtml',
    PRIMARY KEY (`id`),
    UNIQUE KEY `subject` (`subject`)
    ) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex`
--

INSERT INTO `trex` (`id`, `title`, `subject`, `url`, `image`, `category`, `status`, `show`, `dbhost`, `dbuser`, `dbpass`, `dbname`, `dbtype`, `dbtabl`, `dblist`, `dbaffs`, `dbflid`, `dbhttp`, `dbpath`, `desc`, `stats`, `affiliates`, `wishlist`, `quotes`, `members`, `members_header`, `members_footer`, `updates`, `form_delete`, `form_form`, `form_join`, `form_join_comments`, `form_join_rules`, `form_reset`, `form_update`, `fave_fields`, `previous`, `date`, `since`, `updated`, `granted`, `markup`) VALUES
    (1, 'Listing1', 'Cool Subject', 'http://localhost:8041/samplefl', '1da3ce569064_', '!3!28!52!', 0, 0, '', '', '', '', 'enth', '', 0, '', 0, '', '', 'DESCRIPTION', '&lt;p class=&quot;details&quot;&gt;\r\n&lt;strong&gt;Members:&lt;/strong&gt; {members} (&lt;em&gt;{pending} Pending &lt;/em&gt;)&lt;br&gt;\r\n&lt;strong&gt;Since:&lt;/strong&gt; {since}&lt;br&gt;\r\n&lt;strong&gt;Last Updated:&lt;/strong&gt; {updated}\r\n&lt;/p&gt;', '', '', '', '<li>{name}<br />\n{email} &middot; {url}</li>', '<ol>', '</ol>', '<div class=\"entry_listingadmin\">\n<span class=\"date\">{date}</span> {entry}\n<p class=\"tc cat\">Filed Under: {categories}</p>\n</div>', '', '', '', 0, '', '', '', '', '', 'F j, Y', '2000-02-27', '0000-00-00', 1, 'xhtml');

-- --------------------------------------------------------

--
-- Table structure for table `trex_affiliates`
--

DROP TABLE IF EXISTS `trex_affiliates`;
CREATE TABLE IF NOT EXISTS `trex_affiliates` (
    `aID` mediumint(6) NOT NULL AUTO_INCREMENT,
    `fNiq` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '!0!',
    `aSubject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aEmail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aImage` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aAdd` date NOT NULL,
    PRIMARY KEY (`aID`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_categories`
--

DROP TABLE IF EXISTS `trex_categories`;
CREATE TABLE IF NOT EXISTS `trex_categories` (
    `catid` smallint(3) NOT NULL AUTO_INCREMENT,
    `catname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `parent` smallint(3) UNSIGNED NOT NULL DEFAULT '0',
    PRIMARY KEY (`catid`)
    ) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
    (76, 'Websites', 0);

-- --------------------------------------------------------

--
-- Table structure for table `trex_codes`
--

DROP TABLE IF EXISTS `trex_codes`;
CREATE TABLE IF NOT EXISTS `trex_codes` (
    `cID` int(10) NOT NULL AUTO_INCREMENT,
    `fNiq` mediumint(6) UNSIGNED NOT NULL,
    `cName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `cFile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `cCategory` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `cSize` tinyint(2) NOT NULL DEFAULT '1',
    `cDonor` smallint(3) NOT NULL DEFAULT '0',
    `cPending` tinyint(1) NOT NULL DEFAULT '0',
    `cAdded` datetime NOT NULL,
    PRIMARY KEY (`cID`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_codes_categories`
--

DROP TABLE IF EXISTS `trex_codes_categories`;
CREATE TABLE IF NOT EXISTS `trex_codes_categories` (
    `catID` mediumint(6) NOT NULL AUTO_INCREMENT,
    `fNiq` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `catName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `catParent` mediumint(6) NOT NULL DEFAULT '0',
    PRIMARY KEY (`catID`),
    UNIQUE KEY `fNiq` (`fNiq`,`catName`(70),`catParent`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_codes_donors`
--

DROP TABLE IF EXISTS `trex_codes_donors`;
CREATE TABLE IF NOT EXISTS `trex_codes_donors` (
    `dID` mediumint(6) NOT NULL AUTO_INCREMENT,
    `dName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dEmail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `dPending` tinyint(1) NOT NULL DEFAULT '1',
    `dUpdated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    `dAdded` datetime NOT NULL,
    PRIMARY KEY (`dID`),
    UNIQUE KEY `dName` (`dName`(25),`dEmail`(80),`dURL`(90))
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_codes_donors`
--

INSERT INTO `trex_codes_donors` (`dID`, `dName`, `dEmail`, `dURL`, `dPending`, `dUpdated`, `dAdded`) VALUES
    (1, 'fff', 'newemail+1234@gmail.com', '', 0, '0000-00-00 00:00:00', '2020-04-18 21:40:07');

-- --------------------------------------------------------

--
-- Table structure for table `trex_codes_sizes`
--

DROP TABLE IF EXISTS `trex_codes_sizes`;
CREATE TABLE IF NOT EXISTS `trex_codes_sizes` (
    `sID` smallint(2) NOT NULL AUTO_INCREMENT,
    `sName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `sOrder` smallint(2) UNSIGNED NOT NULL,
    PRIMARY KEY (`sID`)
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

DROP TABLE IF EXISTS `trex_errors`;
CREATE TABLE IF NOT EXISTS `trex_errors` (
    `messID` mediumint(4) NOT NULL AUTO_INCREMENT,
    `messType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `messURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `messText` text COLLATE utf8_unicode_ci NOT NULL,
    `messInfo` text COLLATE utf8_unicode_ci NOT NULL,
    `messAdded` datetime NOT NULL,
    PRIMARY KEY (`messID`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_joined`
--

DROP TABLE IF EXISTS `trex_joined`;
CREATE TABLE IF NOT EXISTS `trex_joined` (
    `jID` mediumint(5) NOT NULL AUTO_INCREMENT,
    `jSubject` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
    `jURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `jImage` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `jCategory` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `jMade` enum('y','n') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'n',
    `jStatus` tinyint(1) NOT NULL DEFAULT '0',
    `jAdd` date NOT NULL,
    PRIMARY KEY (`jID`)
    ) ENGINE=MyISAM AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_joined`
--

INSERT INTO `trex_joined` (`jID`, `jSubject`, `jURL`, `jImage`, `jCategory`, `jMade`, `jStatus`, `jAdd`) VALUES
    (1, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (2, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (3, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (4, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (5, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (6, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (7, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (8, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (9, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (10, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (11, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (12, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (13, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (14, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (15, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (16, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (17, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (18, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (19, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (20, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (21, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (22, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (23, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (24, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (25, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (26, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (27, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (28, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (29, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (30, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (31, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (32, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (33, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (34, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (35, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (36, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (37, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (38, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (39, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (40, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (41, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (42, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (43, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (44, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (45, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (46, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (47, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (48, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (49, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (50, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (51, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (52, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (53, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (54, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (55, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (56, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (57, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (58, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (59, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (60, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (61, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (62, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (63, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (64, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (65, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (66, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (67, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (68, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (69, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (70, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (71, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (72, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (73, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (74, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (75, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (76, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (77, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (78, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (79, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (80, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (81, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27'),
    (82, 'Joined My Owned one', 'http://localhost:8041/samplefl', '', '|21|41|55|', 'y', 0, '2020-02-27');

-- --------------------------------------------------------

--
-- Table structure for table `trex_kim`
--

DROP TABLE IF EXISTS `trex_kim`;
CREATE TABLE IF NOT EXISTS `trex_kim` (
    `mID` int(10) NOT NULL AUTO_INCREMENT,
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
    `mAdd` date NOT NULL,
    PRIMARY KEY (`mID`),
    UNIQUE KEY `mName` (`fNiq`,`mEmail`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_logs`
--

DROP TABLE IF EXISTS `trex_logs`;
CREATE TABLE IF NOT EXISTS `trex_logs` (
    `logID` int(10) NOT NULL AUTO_INCREMENT,
    `userNiq` mediumint(4) NOT NULL,
    `logUser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `logInfo` text COLLATE utf8_unicode_ci NOT NULL,
    `logLast` datetime NOT NULL,
    PRIMARY KEY (`logID`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_lyrics`
--

DROP TABLE IF EXISTS `trex_lyrics`;
CREATE TABLE IF NOT EXISTS `trex_lyrics` (
    `lyID` int(10) NOT NULL AUTO_INCREMENT,
    `fNiq` mediumint(6) UNSIGNED NOT NULL,
    `aNiq` int(10) UNSIGNED NOT NULL,
    `lyName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `lyText` longtext COLLATE utf8_unicode_ci NOT NULL,
    PRIMARY KEY (`lyID`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_lyrics_albums`
--

DROP TABLE IF EXISTS `trex_lyrics_albums`;
CREATE TABLE IF NOT EXISTS `trex_lyrics_albums` (
    `aID` int(10) NOT NULL AUTO_INCREMENT,
    `fNiq` mediumint(6) UNSIGNED NOT NULL,
    `aArtist` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `aYear` mediumint(4) NOT NULL,
    PRIMARY KEY (`aID`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_members`
--

DROP TABLE IF EXISTS `trex_members`;
CREATE TABLE IF NOT EXISTS `trex_members` (
    `mID` mediumint(6) NOT NULL AUTO_INCREMENT,
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
    `mAdd` date NOT NULL,
    PRIMARY KEY (`mID`),
    UNIQUE KEY `mName` (`fNiq`,`mEmail`)
    ) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_members`
--

INSERT INTO `trex_members` (`mID`, `mEmail`, `fNiq`, `mName`, `mURL`, `mCountry`, `mPassword`, `mExtra`, `mVisible`, `mPending`, `mUpdate`, `mEdit`, `mAdd`) VALUES
    (1, 'joinerjoiner@gmaaaaaaail.com', 1, 'Joiner', 'http://myurl.com', 'El Salvador', '6f55c171fdf2ba21bff9a9f17cb76c65', '', 1, 0, 'n', '0000-00-00 00:00:00', '2020-02-27');

-- --------------------------------------------------------

--
-- Table structure for table `trex_options`
--

DROP TABLE IF EXISTS `trex_options`;
CREATE TABLE IF NOT EXISTS `trex_options` (
    `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `text` text COLLATE utf8_unicode_ci NOT NULL,
    UNIQUE KEY `name` (`name`)
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
    ('kim_join', 'http://localhost:8041/kim.php?join'),
    ('kim_list', 'http://localhost:8041/kim.php?list'),
    ('kim_reset', 'http://localhost:8041/kim.php?reset'),
    ('kim_update', 'http://localhost:8041/kim.php?update'),
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

DROP TABLE IF EXISTS `trex_quotes`;
CREATE TABLE IF NOT EXISTS `trex_quotes` (
    `qID` mediumint(5) NOT NULL AUTO_INCREMENT,
    `fNiq` mediumint(6) UNSIGNED NOT NULL,
    `qQuote` text COLLATE utf8_unicode_ci NOT NULL,
    `qAuthor` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `qUpdated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    `qAdded` datetime NOT NULL,
    PRIMARY KEY (`qID`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_success`
--

DROP TABLE IF EXISTS `trex_success`;
CREATE TABLE IF NOT EXISTS `trex_success` (
    `messID` mediumint(4) NOT NULL AUTO_INCREMENT,
    `messType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `messURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `messText` text COLLATE utf8_unicode_ci NOT NULL,
    `messInfo` text COLLATE utf8_unicode_ci NOT NULL,
    `messAdded` datetime NOT NULL,
    PRIMARY KEY (`messID`)
    ) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_success`
--

INSERT INTO `trex_success` (`messID`, `messType`, `messURL`, `messText`, `messInfo`, `messAdded`) VALUES
    (1, 'User Log-In Success', 'http://localhost/admin/index.php', 'Username: My Name\nPassword: password', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36|', '2020-02-27 18:26:24'),
    (2, 'User Log-In Success', 'http://localhost/admin/members.php', 'Username: username\nPassword: password', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36|', '2020-02-27 18:27:45'),
    (3, 'User Log-In Success', 'http://localhost/admin/emails.php', 'Username: admin\nPassword: password', '|192.168.210.1|Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36|', '2020-02-27 18:35:43');

-- --------------------------------------------------------

--
-- Table structure for table `trex_templates`
--

DROP TABLE IF EXISTS `trex_templates`;
CREATE TABLE IF NOT EXISTS `trex_templates` (
    `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `template` text COLLATE utf8_unicode_ci NOT NULL,
    UNIQUE KEY `name` (`name`)
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
    ('updates_template', 'Updates', '{date} {entry}\r\nFiled Under: {categories}'),
    ('wishlist_top_template', 'Wishlist: Top', '&lt;p class=&quot;floatLeft&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject} ({category})&quot; title=&quot;{subject} ({category})&quot; class&quot;top-wishlist&quot;&gt;&lt;br&gt;{desc}&lt;/p&gt;'),
    ('wishlist_granted_template', 'Wishlist: Granted', '&lt;p class=&quot;floatLeft&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject} ({category})&quot; title=&quot;{subject} ({category})&quot; class&quot;top-wishlist&quot;&gt;&lt;br&gt;{desc}&lt;/p&gt;'),
    ('wishlist_query_template', 'Wishlist: Query', '&lt;p class=&quot;floatLeft&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject} ({category})&quot; title=&quot;{subject} ({category})&quot; class&quot;top-wishlist&quot;&gt;&lt;br&gt;{desc}&lt;/p&gt;'),
    ('wishlist_template', 'Wishlist', '&lt;p class=&quot;floatLeft&quot;&gt;&lt;img src=&quot;{image}&quot; alt=&quot;{subject} ({category})&quot; title=&quot;{subject} ({category})&quot; class&quot;top-wishlist&quot;&gt;&lt;br&gt;{desc}&lt;/p&gt;');

-- --------------------------------------------------------

--
-- Table structure for table `trex_templates_emails`
--

DROP TABLE IF EXISTS `trex_templates_emails`;
CREATE TABLE IF NOT EXISTS `trex_templates_emails` (
    `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `template` text COLLATE utf8_unicode_ci NOT NULL,
    UNIQUE KEY `name` (`name`)
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

    DROP TABLE IF EXISTS `trex_updates`;
    CREATE TABLE IF NOT EXISTS `trex_updates` (
    `uID` int(10) NOT NULL AUTO_INCREMENT,
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
    `uAdded` datetime NOT NULL,
    PRIMARY KEY (`uID`),
    UNIQUE KEY `uTitle` (`uID`,`uTitle`(50))
    ) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `trex_updates`
--

    INSERT INTO `trex_updates` (`uID`, `uTitle`, `uCategory`, `uEntry`, `uDW`, `uDWOpt`, `uIJ`, `uIJOpt`, `uLJ`, `uLJOpt`, `uPending`, `uDisabled`, `uAdded`) VALUES
    (1, 'cool update', '!0!1!', 'Blablah', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 'n', '|itemid:|community:|tags:|userpic:|', 0, 0, '2020-02-27 19:05:38'),
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

    DROP TABLE IF EXISTS `trex_updates_comments`;
    CREATE TABLE IF NOT EXISTS `trex_updates_comments` (
    `cID` int(20) NOT NULL AUTO_INCREMENT,
    `eNiq` int(10) UNSIGNED NOT NULL,
    `cName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `cEmail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `cURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `cComment` text COLLATE utf8_unicode_ci NOT NULL,
    `cInfo` text COLLATE utf8_unicode_ci NOT NULL,
    `cFlag` enum('legit','spam') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'legit',
    `cPending` tinyint(1) NOT NULL DEFAULT '0',
    `cAdded` datetime NOT NULL,
    PRIMARY KEY (`cID`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trex_wishlist`
--

    DROP TABLE IF EXISTS `trex_wishlist`;
    CREATE TABLE IF NOT EXISTS `trex_wishlist` (
    `wID` smallint(3) NOT NULL AUTO_INCREMENT,
    `wSubject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `wURL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `wImage` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `wCategory` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
    `wDesc` text COLLATE utf8_unicode_ci NOT NULL,
    `wType` enum('custom','granted','list','top') COLLATE utf8_unicode_ci NOT NULL,
    PRIMARY KEY (`wID`)
    ) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
    COMMIT;
