-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: accomodate
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alojamiento`
--

DROP TABLE IF EXISTS `alojamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alojamiento` (
  `id_alojamiento` int NOT NULL AUTO_INCREMENT,
  `nombre_alojamiento` varchar(100) NOT NULL,
  `descripcion` text,
  `direccion` varchar(255) NOT NULL,
  `id_ciudad` int DEFAULT NULL,
  `id_anfitrion` int DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_alojamiento`),
  KEY `id_ciudad` (`id_ciudad`),
  KEY `id_anfitrion` (`id_anfitrion`),
  CONSTRAINT `alojamiento_ibfk_1` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`),
  CONSTRAINT `alojamiento_ibfk_2` FOREIGN KEY (`id_anfitrion`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alojamiento`
--

LOCK TABLES `alojamiento` WRITE;
/*!40000 ALTER TABLE `alojamiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `alojamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendario_disponibilidad_propiedad`
--

DROP TABLE IF EXISTS `calendario_disponibilidad_propiedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendario_disponibilidad_propiedad` (
  `id_calendario_disponibilidad` int NOT NULL AUTO_INCREMENT,
  `id_alojamiento` int DEFAULT NULL,
  `fecha` date NOT NULL,
  `disponible` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_calendario_disponibilidad`),
  KEY `id_alojamiento` (`id_alojamiento`),
  CONSTRAINT `calendario_disponibilidad_propiedad_ibfk_1` FOREIGN KEY (`id_alojamiento`) REFERENCES `alojamiento` (`id_alojamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendario_disponibilidad_propiedad`
--

LOCK TABLES `calendario_disponibilidad_propiedad` WRITE;
/*!40000 ALTER TABLE `calendario_disponibilidad_propiedad` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendario_disponibilidad_propiedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciudad`
--

DROP TABLE IF EXISTS `ciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciudad` (
  `id_ciudad` int NOT NULL AUTO_INCREMENT,
  `nombre_ciudad` varchar(100) NOT NULL,
  `id_pais` int DEFAULT NULL,
  PRIMARY KEY (`id_ciudad`),
  KEY `id_pais` (`id_pais`),
  CONSTRAINT `ciudad_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudad`
--

LOCK TABLES `ciudad` WRITE;
/*!40000 ALTER TABLE `ciudad` DISABLE KEYS */;
INSERT INTO `ciudad` VALUES (1,'Chihuahua',141);
/*!40000 ALTER TABLE `ciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritos` (
  `id_favorito` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `id_alojamiento` int DEFAULT NULL,
  `fecha_agregado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_favorito`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_alojamiento` (`id_alojamiento`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_alojamiento`) REFERENCES `alojamiento` (`id_alojamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pais` (
  `id_pais` int NOT NULL AUTO_INCREMENT,
  `nombre_pais` varchar(100) NOT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` VALUES (1,'Afganistán'),(2,'Albania'),(3,'Alemania'),(4,'Andorra'),(5,'Angola'),(6,'Anguila'),(7,'Antártida'),(8,'Antigua y Barbuda'),(9,'Arabia Saudita'),(10,'Argelia'),(11,'Argentina'),(12,'Armenia'),(13,'Aruba'),(14,'Australia'),(15,'Austria'),(16,'Azerbaiyán'),(17,'Bélgica'),(18,'Bahamas'),(19,'Bahrein'),(20,'Bangladesh'),(21,'Barbados'),(22,'Belice'),(23,'Benín'),(24,'Bhután'),(25,'Bielorrusia'),(26,'Birmania'),(27,'Bolivia'),(28,'Bosnia y Herzegovina'),(29,'Botsuana'),(30,'Brasil'),(31,'Brunéi'),(32,'Bulgaria'),(33,'Burkina Faso'),(34,'Burundi'),(35,'Cabo Verde'),(36,'Camboya'),(37,'Camerún'),(38,'Canadá'),(39,'Chad'),(40,'Chile'),(41,'China'),(42,'Chipre'),(43,'Ciudad del Vaticano'),(44,'Colombia'),(45,'Comoras'),(46,'República del Congo'),(47,'República Democrática del Congo'),(48,'Corea del Norte'),(49,'Corea del Sur'),(50,'Costa de Marfil'),(51,'Costa Rica'),(52,'Croacia'),(53,'Cuba'),(54,'Curazao'),(55,'Dinamarca'),(56,'Dominica'),(57,'Ecuador'),(58,'Egipto'),(59,'El Salvador'),(60,'Emiratos Árabes Unidos'),(61,'Eritrea'),(62,'Eslovaquia'),(63,'Eslovenia'),(64,'España'),(65,'Estados Unidos de América'),(66,'Estonia'),(67,'Etiopía'),(68,'Filipinas'),(69,'Finlandia'),(70,'Fiyi'),(71,'Francia'),(72,'Gabón'),(73,'Gambia'),(74,'Georgia'),(75,'Ghana'),(76,'Gibraltar'),(77,'Granada'),(78,'Grecia'),(79,'Groenlandia'),(80,'Guadalupe'),(81,'Guam'),(82,'Guatemala'),(83,'Guayana Francesa'),(84,'Guernsey'),(85,'Guinea'),(86,'Guinea Ecuatorial'),(87,'Guinea-Bissau'),(88,'Guyana'),(89,'Haití'),(90,'Honduras'),(91,'Hong kong'),(92,'Hungría'),(93,'India'),(94,'Indonesia'),(95,'Irán'),(96,'Irak'),(97,'Irlanda'),(98,'Isla Bouvet'),(99,'Isla de Man'),(100,'Isla de Navidad'),(101,'Isla Norfolk'),(102,'Islandia'),(103,'Islas Bermudas'),(104,'Islas Caimán'),(105,'Islas Cocos (Keeling)'),(106,'Islas Cook'),(107,'Islas de Åland'),(108,'Islas Feroe'),(109,'Islas Georgias del Sur y Sandwich del Sur'),(110,'Islas Heard y McDonald'),(111,'Islas Maldivas'),(112,'Islas Malvinas'),(113,'Islas Marianas del Norte'),(114,'Islas Marshall'),(115,'Islas Pitcairn'),(116,'Islas Salomón'),(117,'Islas Turcas y Caicos'),(118,'Islas Ultramarinas Menores de Estados Unidos'),(119,'Islas Vírgenes Británicas'),(120,'Islas Vírgenes de los Estados Unidos'),(121,'Israel'),(122,'Italia'),(123,'Jamaica'),(124,'Japón'),(125,'Jersey'),(126,'Jordania'),(127,'Kazajistán'),(128,'Kenia'),(129,'Kirguistán'),(130,'Kiribati'),(131,'Kuwait'),(132,'Líbano'),(133,'Laos'),(134,'Lesoto'),(135,'Letonia'),(136,'Liberia'),(137,'Libia'),(138,'Liechtenstein'),(139,'Lituania'),(140,'Luxemburgo'),(141,'México'),(142,'Mónaco'),(143,'Macao'),(144,'Macedônia'),(145,'Madagascar'),(146,'Malasia'),(147,'Malawi'),(148,'Mali'),(149,'Malta'),(150,'Marruecos'),(151,'Martinica'),(152,'Mauricio'),(153,'Mauritania'),(154,'Mayotte'),(155,'Micronesia'),(156,'Moldavia'),(157,'Mongolia'),(158,'Montenegro'),(159,'Montserrat'),(160,'Mozambique'),(161,'Namibia'),(162,'Nauru'),(163,'Nepal'),(164,'Nicaragua'),(165,'Niger'),(166,'Nigeria'),(167,'Niue'),(168,'Noruega'),(169,'Nueva Caledonia'),(170,'Nueva Zelanda'),(171,'Omán'),(172,'Países Bajos'),(173,'Pakistán'),(174,'Palau'),(175,'Palestina'),(176,'Panamá'),(177,'Papúa Nueva Guinea'),(178,'Paraguay'),(179,'Perú'),(180,'Polinesia Francesa'),(181,'Polonia'),(182,'Portugal'),(183,'Puerto Rico'),(184,'Qatar'),(185,'Reino Unido'),(186,'República Centroafricana'),(187,'República Checa'),(188,'República Dominicana'),(189,'República de Sudán del Sur'),(190,'Reunión'),(191,'Ruanda'),(192,'Rumanía'),(193,'Rusia'),(194,'Sahara Occidental'),(195,'Samoa'),(196,'Samoa Americana'),(197,'San Bartolomé'),(198,'San Cristóbal y Nieves'),(199,'San Marino'),(200,'San Martín (Francia)'),(201,'San Pedro y Miquelón'),(202,'San Vicente y las Granadinas'),(203,'Santa Elena'),(204,'Santa Lucía'),(205,'Santo Tomé y Príncipe'),(206,'Senegal'),(207,'Serbia'),(208,'Seychelles'),(209,'Sierra Leona'),(210,'Singapur'),(211,'Sint Maarten'),(212,'Siria'),(213,'Somalia'),(214,'Sri lanka'),(215,'Sudáfrica'),(216,'Sudán'),(217,'Suecia'),(218,'Suiza'),(219,'Surinám'),(220,'Svalbard y Jan Mayen'),(221,'Swazilandia'),(222,'Tayikistán'),(223,'Tailandia'),(224,'Taiwán'),(225,'Tanzania'),(226,'Territorio Británico del Océano Índico'),(227,'Territorios Australes y Antárticas Franceses'),(228,'Timor Oriental'),(229,'Togo'),(230,'Tokelau'),(231,'Tonga'),(232,'Trinidad y Tobago'),(233,'Tunez'),(234,'Turkmenistán'),(235,'Turquía'),(236,'Tuvalu'),(237,'Ucrania'),(238,'Uganda'),(239,'Uruguay'),(240,'Uzbekistán'),(241,'Vanuatu'),(242,'Venezuela'),(243,'Vietnam'),(244,'Wallis y Futuna'),(245,'Yemen'),(246,'Yibuti'),(247,'Zambia'),(248,'Zimbabue');
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resena`
--

DROP TABLE IF EXISTS `resena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resena` (
  `id_reseña` int NOT NULL AUTO_INCREMENT,
  `puntuacion` int DEFAULT NULL,
  `comentario` text,
  `id_usuario` int DEFAULT NULL,
  `id_alojamiento` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id_reseña`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_alojamiento` (`id_alojamiento`),
  CONSTRAINT `resena_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `resena_ibfk_2` FOREIGN KEY (`id_alojamiento`) REFERENCES `alojamiento` (`id_alojamiento`),
  CONSTRAINT `resena_chk_1` CHECK ((`puntuacion` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resena`
--

LOCK TABLES `resena` WRITE;
/*!40000 ALTER TABLE `resena` DISABLE KEYS */;
/*!40000 ALTER TABLE `resena` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `id_reserva` int NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `id_huesped` int DEFAULT NULL,
  `id_alojamiento` int DEFAULT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `id_huesped` (`id_huesped`),
  KEY `id_alojamiento` (`id_alojamiento`),
  CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`id_huesped`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `reserva_ibfk_2` FOREIGN KEY (`id_alojamiento`) REFERENCES `alojamiento` (`id_alojamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacciones`
--

DROP TABLE IF EXISTS `transacciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacciones` (
  `id_transaccion` int NOT NULL AUTO_INCREMENT,
  `id_reserva` int DEFAULT NULL,
  `metodo_pago` enum('tarjeta_credito','tarjeta_debito') NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_transaccion`),
  KEY `id_reserva` (`id_reserva`),
  CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reserva` (`id_reserva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacciones`
--

LOCK TABLES `transacciones` WRITE;
/*!40000 ALTER TABLE `transacciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `transacciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo_electronico` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `id_pais` int DEFAULT NULL,
  `id_ciudad` int DEFAULT NULL,
  `contrasena` varchar(100) NOT NULL,
  `tipo_usuario` enum('Cliente','Arrendatario') NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`),
  KEY `id_pais` (`id_pais`),
  KEY `id_ciudad` (`id_ciudad`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id_pais`),
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Felix','Fenix','felix@correo.com','Street 123',141,1,'felix123','Cliente','2024-05-27'),(2,'Jose','Hernandez','jose@correo.com','Steet 1234',141,1,'felix1234','Arrendatario','2024-05-27');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-27 17:53:20
