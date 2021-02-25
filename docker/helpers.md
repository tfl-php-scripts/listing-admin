DROP procedure if exists InsertMembers;

DELIMITER $$
CREATE PROCEDURE `InsertMembers` (IN `NumRows` INT)  BEGIN
DECLARE i INT;
DECLARE email VARCHAR(80);
DECLARE url VARCHAR(80);
DECLARE name VARCHAR(80);
DECLARE faveFields VARCHAR(80);
DECLARE added DATE;
SET i = 1;
SET added = '2000-08-25';
START TRANSACTION;
WHILE i <= NumRows DO
SET email = CONCAT(i, '@localhost123456.com');
SET url = CONCAT('https://', i, '.localhost123456.com');
SET faveFields = CONCAT('|', i, '|', CEIL(RAND() * 100), '|');
SET name = CONCAT(i, ' Joined');
SET added = DATE_ADD(added, INTERVAL 10 DAY);
INSERT INTO `trex_members` (`mEmail`, `fNiq`, `mName`, `mURL`, `mCountry`, `mPassword`, `mExtra`, `mVisible`, `mPending`, `mUpdate`, `mEdit`, `mAdd`) VALUES (email, 1, name, url, 'United States', md5('password'), faveFields, 1, 0, 'n', '2020-04-20 21:29:56', added);
SET i = i + 1;
END WHILE;
COMMIT;
END$$
DELIMITER ;

Call InsertMembers(1000);