-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: sales_schema
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `product_master`
--

DROP TABLE IF EXISTS `product_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_master` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(45) NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` double NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_master`
--

LOCK TABLES `product_master` WRITE;
/*!40000 ALTER TABLE `product_master` DISABLE KEYS */;
INSERT INTO `product_master` VALUES (1,'Sunscreen',17,450),(2,'Body Lotion',20,260),(3,'Cleanser',30,340),(4,'Deodorant',15,550),(5,'Body Wash',10,280);
/*!40000 ALTER TABLE `product_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_rating`
--

DROP TABLE IF EXISTS `product_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_rating` (
  `product_rating_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `rating` varchar(15) NOT NULL,
  PRIMARY KEY (`product_rating_id`),
  KEY `product_id_idx` (`product_id`),
  CONSTRAINT `product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `product_master` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_rating`
--

LOCK TABLES `product_rating` WRITE;
/*!40000 ALTER TABLE `product_rating` DISABLE KEYS */;
INSERT INTO `product_rating` VALUES (6,1,'1 Star'),(7,1,'3 Star'),(8,2,'5 Star'),(9,3,'2 Star'),(10,4,'4 Star'),(11,1,'3 Star'),(12,1,'1 Star'),(13,1,'1 Star');
/*!40000 ALTER TABLE `product_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `sales_id` int NOT NULL AUTO_INCREMENT,
  `sales_date` date NOT NULL,
  `product_id` int NOT NULL,
  `sales_quantity` int NOT NULL,
  PRIMARY KEY (`sales_id`),
  KEY `product_id_fk99_idx` (`product_id`),
  CONSTRAINT `product_id_fk99` FOREIGN KEY (`product_id`) REFERENCES `product_master` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,'2023-01-12',1,4),(2,'2023-02-09',2,5),(3,'2023-03-01',3,9),(4,'2023-04-10',2,3),(5,'2023-05-10',4,6),(6,'2024-06-19',1,4),(7,'2024-06-19',1,3),(8,'2024-06-19',1,1);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'sales_schema'
--
/*!50003 DROP PROCEDURE IF EXISTS `sales_app_proc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sales_app_proc`(
IN status varchar(28),
IN p_product_id INT,
IN p_qnty INT,
IN p_rating varchar(12),
OUT p_msg varchar(128)
)
BEGIN
	declare v_qnty INT;
if status='seProd' then 
  select product_id,product_name, quantity, unit_price from product_master;
elseif status='insales' then
	select quantity into v_qnty from product_master where product_id=p_product_id;
    if v_qnty > p_qnty then
		insert into sales(sales_date, product_id,sales_quantity) values(curdate(),p_product_id, p_qnty);
        insert into product_rating(product_id, rating) values(p_product_id,p_rating);
        update product_master set quantity=quantity-p_qnty where product_id=p_product_id;
        set p_msg = "data saved successfully !!";
    
    else
     set p_msg = "insufficient quantity !!";
     end if;
  elseif status='setable' then
	select rating, count(*) total from product_rating where product_id= p_product_id group by rating;
  end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sales_proc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sales_proc`(
IN status varchar(28)
)
BEGIN
if status='seProd' then 
  select product_name, quantity, unit_price from product_master;
  end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-19 17:31:30
