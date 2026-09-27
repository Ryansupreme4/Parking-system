-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: parking_system
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `barriers`
--

DROP TABLE IF EXISTS `barriers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barriers` (
  `barrier_id` int NOT NULL AUTO_INCREMENT,
  `barrier_name` varchar(50) DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`barrier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barriers`
--

LOCK TABLES `barriers` WRITE;
/*!40000 ALTER TABLE `barriers` DISABLE KEYS */;
INSERT INTO `barriers` VALUES (1,'Entry Barrier','Entry','Closed'),(2,'Exit Barrier','Exit','Closed');
/*!40000 ALTER TABLE `barriers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking_payments`
--

DROP TABLE IF EXISTS `parking_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parking_payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `vehicle_id` int DEFAULT NULL,
  `entry_time` datetime DEFAULT NULL,
  `exit_time` datetime DEFAULT NULL,
  `duration_hours` decimal(5,2) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `vehicle_id` (`vehicle_id`),
  CONSTRAINT `parking_payments_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking_payments`
--

LOCK TABLES `parking_payments` WRITE;
/*!40000 ALTER TABLE `parking_payments` DISABLE KEYS */;
INSERT INTO `parking_payments` VALUES (1,1,'2026-09-26 00:22:26','2026-09-26 00:27:43',0.08,80.00);
/*!40000 ALTER TABLE `parking_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking_sessions`
--

DROP TABLE IF EXISTS `parking_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parking_sessions` (
  `session_id` int NOT NULL AUTO_INCREMENT,
  `vehicle_id` int NOT NULL,
  `slot_id` int NOT NULL,
  `entry_time` datetime NOT NULL,
  `exit_time` datetime DEFAULT NULL,
  `amount_due` decimal(10,2) DEFAULT '0.00',
  `payment_status` varchar(20) DEFAULT 'Unpaid',
  `barrier_status` varchar(20) DEFAULT 'Closed',
  PRIMARY KEY (`session_id`),
  KEY `fk_vehicle` (`vehicle_id`),
  KEY `fk_slot` (`slot_id`),
  CONSTRAINT `fk_slot` FOREIGN KEY (`slot_id`) REFERENCES `parking_slots` (`slot_id`),
  CONSTRAINT `fk_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking_sessions`
--

LOCK TABLES `parking_sessions` WRITE;
/*!40000 ALTER TABLE `parking_sessions` DISABLE KEYS */;
INSERT INTO `parking_sessions` VALUES (1,1,1,'2026-09-26 22:50:21','2026-09-26 23:08:36',80.00,'Paid','Open'),(2,3,2,'2026-09-26 23:05:30',NULL,0.00,'Unpaid','Closed');
/*!40000 ALTER TABLE `parking_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking_slots`
--

DROP TABLE IF EXISTS `parking_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parking_slots` (
  `slot_id` int NOT NULL AUTO_INCREMENT,
  `slot_number` varchar(10) NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`slot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking_slots`
--

LOCK TABLES `parking_slots` WRITE;
/*!40000 ALTER TABLE `parking_slots` DISABLE KEYS */;
INSERT INTO `parking_slots` VALUES (1,'S01','Available'),(2,'S02','Occupied'),(3,'S03','Available'),(4,'S04','Available'),(5,'S05','Available'),(6,'S06','Available'),(7,'S07','Available'),(8,'S08','Available'),(9,'S09','Available'),(10,'S10','Available'),(11,'S11','Available'),(12,'S12','Available'),(13,'S13','Available'),(14,'S14','Available'),(15,'S15','Available'),(16,'S16','Available'),(17,'S17','Available'),(18,'S18','Available'),(19,'S19','Available'),(20,'S20','Available'),(21,'S21','Available'),(22,'S22','Available'),(23,'S23','Available'),(24,'S24','Available'),(25,'S25','Available'),(26,'S26','Available'),(27,'S27','Available'),(28,'S28','Available'),(29,'S29','Available'),(30,'S30','Available');
/*!40000 ALTER TABLE `parking_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `vehicle_id` int NOT NULL AUTO_INCREMENT,
  `registration_number` varchar(20) NOT NULL,
  `vehicle_type` varchar(30) NOT NULL,
  `owner_name` varchar(100) NOT NULL,
  `slot_number` varchar(3) DEFAULT NULL,
  `entry_time` datetime DEFAULT NULL,
  `exit_time` datetime DEFAULT NULL,
  `slot_id` int DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`),
  UNIQUE KEY `registration_number` (`registration_number`),
  KEY `slot_id` (`slot_id`),
  CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`slot_id`) REFERENCES `parking_slots` (`slot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES (1,'KDA123A','Car','Ryan Macharia','S01','2026-09-26 00:22:26',NULL,1),(2,'KDA 123A','Car','Ryan',NULL,NULL,NULL,NULL),(3,'KDB 456B','Car','Test Owner',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-27 21:47:35
