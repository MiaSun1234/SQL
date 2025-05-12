CREATE SCHEMA `BookList` DEFAULT CHARACTER SET utf8mb4 ;
CREATE TABLE `BookList`.`Author` (
  `authorid` INT NOT NULL AUTO_INCREMENT,
  `authorfn` VARCHAR(100) NOT NULL,
  `authorln` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`authorid`));
  CREATE TABLE `BookList`.`Genre` (
  `genreid` INT NOT NULL AUTO_INCREMENT,
  `genredescrip` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`genreid`));
  CREATE TABLE `BookList`.`Book` (
  `bookid` int NOT NULL AUTO_INCREMENT,
  `auid` int DEFAULT NULL,
  `genid` int DEFAULT NULL,
  `booktitle` varchar(255) NOT NULL,
  `pages` int DEFAULT NULL,
  `retailprice_$` decimal(10,2) DEFAULT '10.00',
  `quantityinstock` int DEFAULT '0',
  `yearofpublication` int NOT NULL,
  PRIMARY KEY (`bookid`),
  KEY `genid_idx` (`genid`),
  KEY `auid` (`auid`),
  CONSTRAINT `auid` FOREIGN KEY (`auid`) REFERENCES `Author` (`authorid`),
  CONSTRAINT `genid` FOREIGN KEY (`genid`) REFERENCES `Genre` (`genreid`),
  CONSTRAINT `book_chk_1` CHECK ((`pages` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `BookList`.`Summary` (
  `genrid` int NOT NULL AUTO_INCREMENT,
  `datetimestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `value` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`genrid`),
  CONSTRAINT `genrid` FOREIGN KEY (`genrid`) REFERENCES `Genre` (`genreid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TRIGGER IF EXISTS `BookList`.`Author_BEFORE_INSERT`;

DELIMITER $$
USE `BookList`$$
CREATE DEFINER = CURRENT_USER TRIGGER `BookList`.`Author_BEFORE_INSERT` 
BEFORE INSERT ON `Author` FOR EACH ROW
BEGIN
 UPDATE BookList.Author
 SET Author.authorfn = UPPER(Author.authorfn);
 UPDATE BookList.Author
 SET Author.authorln = UPPER(Author.authorln);
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS `BookList`.`Genre_BEFORE_INSERT`;

DELIMITER $$
USE `BookList`$$
CREATE DEFINER = CURRENT_USER TRIGGER `BookList`.`Genre_BEFORE_INSERT` 
BEFORE INSERT ON `Genre` FOR EACH ROW
BEGIN
UPDATE BookList.Genre
SET Genre.genredescrip = LOWER(Genre.genredescrip);
END$$
DELIMITER ;

SET @inventoryvalue=0;
DROP TRIGGER IF EXISTS `BookList`.`Book_AFTER_INSERT`;

DELIMITER $$
USE `BookList`$$
CREATE DEFINER = CURRENT_USER TRIGGER `BookList`.`Book_AFTER_INSERT` 
AFTER INSERT ON `Book` FOR EACH ROW
BEGIN
UPDATE BookList.Book
SET current_inventory_value = @inventoryvalue + (Book.retailprice_$ * Book.quantityinstock)
    WHERE id = 1;
END$$
DELIMITER ;