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
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alojamiento`
--

LOCK TABLES `alojamiento` WRITE;
/*!40000 ALTER TABLE `alojamiento` DISABLE KEYS */;
INSERT INTO `alojamiento` VALUES (1,'Lujoso Apartamento en el Centro Histórico','Apartamento moderno y lujoso en el corazón de la Ciudad de México, con vista a la catedral.','Avenida Reforma #123',1,2,150.00),(2,'Casa Colonial en Coyoacán','Hermosa casa colonial en uno de los barrios más pintorescos de Ciudad de México, cerca de museos y restaurantes.','Calle Hidalgo #456',1,2,120.00),(3,'Penthouse con Vista Panorámica','Penthouse de lujo con terraza y vista panorámica de toda la ciudad, ideal para familias o grupos grandes.','Paseo de la Reforma #789',1,2,250.00),(4,'Acogedor Loft en Condesa','Loft moderno y acogedor en la trendy colonia Condesa, cerca de bares y parques.','Avenida Amsterdam #567',1,2,100.00),(5,'Suite Ejecutiva Reforma','Suite ejecutiva completamente equipada en la principal avenida de Ciudad de México, ideal para viajes de negocios.','Paseo de la Reforma #1010',1,2,180.00),(6,'Apartamento Moderno en Hollywood','Moderno apartamento en el corazón de Hollywood, cerca de atracciones turísticas y restaurantes.','Sunset Blvd #123',2,2,200.00),(7,'Casa Espaciosa en Beverly Hills','Amplia casa con jardín en el exclusivo vecindario de Beverly Hills, ideal para familias.','Rodeo Drive #456',2,5,350.00),(8,'Loft con Vistas en Downtown LA','Loft con vistas panorámicas del skyline de Los Angeles, ubicado en el centro histórico.','Broadway #789',2,5,180.00),(9,'Apartamento de Lujo en Santa Monica','Apartamento de lujo cerca de la playa de Santa Monica, con acceso a piscina y gimnasio.','Ocean Avenue #1010',2,5,300.00),(10,'Casa Moderna en Venice Beach','Casa moderna con diseño vanguardista cerca de las famosas playas de Venice Beach.','Abbott Kinney Blvd #567',2,5,250.00),(11,'Apartamento Céntrico en Toronto','Apartamento moderno y céntrico en el corazón de Toronto, cerca de CN Tower y museos.','King Street #123',3,5,150.00),(12,'Casa Histórica en Distillery District','Casa histórica restaurada en el pintoresco Distillery District de Toronto, ideal para turistas.','Mill Street #456',3,5,120.00),(13,'Loft de Diseño en Queen West','Loft de diseño en la vibrante zona de Queen West, conocida por sus galerías de arte y boutiques.','Queen Street West #789',3,5,180.00),(14,'Piso Ejecutivo en Financial District','Piso ejecutivo en el distrito financiero de Toronto, perfecto para estancias de negocios.','Bay Street #1010',3,5,200.00),(15,'Apartamento Familiar en Yorkville','Apartamento familiar en el exclusivo barrio de Yorkville, ideal para explorar tiendas de lujo y restaurantes.','Bloor Street #567',3,5,250.00),(16,'Apartamento Histórico en Westminster','Apartamento histórico cerca de Westminster Abbey y Houses of Parliament, ideal para conocer la historia de Londres.','Victoria Street #123',4,6,180.00),(17,'Casa de Campo en Hampstead Heath','Encantadora casa de campo en el tranquilo Hampstead Heath, perfecta para escapadas rurales en Londres.','Heath Street #456',4,6,220.00),(18,'Loft Moderno en Shoreditch','Loft moderno en el vibrante barrio de Shoreditch, conocido por sus galerías de arte y vida nocturna.','Old Street #789',4,6,160.00),(19,'Penthouse con Vistas al Támesis','Penthouse con vistas panorámicas del río Támesis y la ciudad de Londres, ubicado en Canary Wharf.','South Quay #1010',4,6,300.00),(20,'Apartamento Elegante en Chelsea','Apartamento elegante en el exclusivo barrio de Chelsea, cerca de tiendas de diseño y restaurantes de renombre.','Sloane Street #567',4,6,250.00),(21,'Apartamento Clásico en Le Marais','Apartamento clásico en el histórico barrio de Le Marais, ideal para explorar museos y tiendas vintage.','Rue Vieille du Temple #123',5,6,200.00),(22,'Casa con Jardín en Montmartre','Encantadora casa con jardín en la bohemia Montmartre, perfecta para disfrutar de vistas panorámicas de París.','Rue des Abbesses #456',5,6,280.00),(23,'Loft Industrial en Canal Saint-Martin','Loft de estilo industrial en el moderno Canal Saint-Martin, conocido por sus cafés y boutiques de diseño.','Quai de Valmy #789',5,6,150.00),(24,'Piso Art Nouveau en Montparnasse','Piso elegante de estilo Art Nouveau en Montparnasse, ideal para amantes del arte y la arquitectura.','Rue Vavin #1010',5,8,220.00),(25,'Apartamento Chic en Le Marais','Apartamento chic y moderno en Le Marais, cerca de galerías de arte contemporáneo y tiendas de moda.','Rue de Turenne #567',5,8,180.00),(26,'Apartamento en Mitte','Apartamento moderno y funcional en el vibrante barrio de Mitte, cerca de galerías de arte y cafeterías.','Torstrasse #123',6,8,120.00),(27,'Casa Tradicional en Charlottenburg','Casa tradicional en el distinguido barrio de Charlottenburg, ideal para quienes buscan tranquilidad y elegancia.','Kurfürstendamm #456',6,8,180.00),(28,'Loft con Terraza en Friedrichshain','Loft con terraza privada en el dinámico Friedrichshain, conocido por su vida nocturna y mercados alternativos.','Warschauer Strasse #789',6,8,150.00),(29,'Penthouse en Prenzlauer Berg','Penthouse con vistas panorámicas de Berlín en Prenzlauer Berg, perfecto para escapadas urbanas.','Kollwitzplatz #1010',6,8,250.00),(30,'Apartamento Minimalista en Neukölln','Apartamento minimalista en el multicultural barrio de Neukölln, ideal para amantes de la vida bohemia.','Karl-Marx-Strasse #567',6,8,100.00),(31,'Piso Moderno en Malasaña','Piso moderno en el trendy barrio de Malasaña, ideal para explorar tiendas vintage y bares de moda.','Calle Fuencarral #789',7,10,130.00),(32,'Casa Histórica en Lavapiés','Casa histórica restaurada en el multicultural barrio de Lavapiés, perfecta para experiencias auténticas en Madrid.','Calle Argumosa #1010',7,10,110.00),(33,'Loft con Vistas en Chamberí','Loft con vistas panorámicas en el elegante barrio de Chamberí, cerca de museos y elegantes boutiques.','Calle Santa Engracia #567',7,10,160.00),(34,'Apartamento Ejecutivo en Salamanca','Apartamento ejecutivo en el exclusivo barrio de Salamanca, ideal para estancias de negocios y compras de lujo.','Calle Serrano #123',7,10,200.00),(35,'Apartamento Familiar en Retiro','Amplio apartamento familiar cerca del Parque del Retiro, perfecto para actividades al aire libre y paseos.','Calle Alcalá #456',7,10,180.00),(36,'Departamento en Palermo Soho','Moderno departamento en el trendy barrio de Palermo Soho, cerca de tiendas de diseño y restaurantes.','Calle Thames #123',8,10,150.00),(37,'Casa Histórica en San Telmo','Casa histórica restaurada en el bohemio barrio de San Telmo, ideal para explorar galerías de arte y tango.','Calle Defensa #456',8,10,120.00),(38,'Loft con Terraza en Puerto Madero','Loft con terraza privada en el moderno Puerto Madero, cerca de restaurantes y vistas al río.','Avenida Alicia Moreau de Justo #789',8,10,180.00),(39,'Penthouse en Recoleta','Penthouse con vistas panorámicas en el distinguido barrio de Recoleta, perfecto para estancias exclusivas.','Avenida Alvear #1010',8,10,250.00),(40,'Apartamento Familiar en Belgrano','Amplio apartamento familiar en el residencial barrio de Belgrano, ideal para quienes buscan tranquilidad.','Calle Juramento #567',8,10,200.00),(41,'Apartamento con Vistas en Darling Harbour','Apartamento con vistas espectaculares del puerto Darling Harbour, cerca de atracciones turísticas.','Hickson Road #123',9,12,200.00),(42,'Casa de Playa en Bondi Beach','Encantadora casa de playa en la famosa Bondi Beach, perfecta para surfistas y amantes del sol.','Campbell Parade #456',9,12,280.00),(43,'Loft Moderno en Surry Hills','Loft moderno en el animado barrio de Surry Hills, conocido por sus cafés y vida nocturna.','Crown Street #789',9,12,150.00),(44,'Piso Ejecutivo en CBD','Piso ejecutivo en el Central Business District (CBD) de Sydney, ideal para viajes de negocios.','George Street #1010',9,12,300.00),(45,'Apartamento Familiar en Manly','Amplio apartamento familiar en la pintoresca Manly, ideal para actividades al aire libre y relax.','The Corso #567',9,12,250.00),(46,'Apartamento Frente a la Playa en Copacabana','Apartamento con vistas panorámicas de la famosa playa de Copacabana, ideal para disfrutar del sol y el mar.','Avenida Atlântica #123',10,12,180.00),(47,'Casa con Jardín en Santa Teresa','Casa con jardín en el bohemio barrio de Santa Teresa, perfecta para escapadas culturales y artísticas.','Rua Aprazível #456',10,14,220.00),(48,'Loft Moderno en Ipanema','Loft moderno en el chic barrio de Ipanema, cerca de tiendas de moda y restaurantes de lujo.','Rua Vinícius de Moraes #789',10,14,160.00),(49,'Penthouse en Barra da Tijuca','Penthouse con vistas panorámicas en la exclusiva Barra da Tijuca, perfecto para estancias de lujo.','Avenida das Américas #1010',10,14,300.00),(50,'Apartamento Estudio en Leblon','Apartamento estudio en el sofisticado barrio de Leblon, ideal para quienes buscan tranquilidad y exclusividad.','Rua Dias Ferreira #567',10,14,250.00),(51,'Apartamento Moderno en Polanco','Apartamento moderno en el exclusivo barrio de Polanco, cerca de restaurantes y tiendas de diseño.','Avenida Presidente Masaryk #123',1,2,180.00),(52,'Casa Tradicional en Coyoacán','Casa tradicional mexicana en el pintoresco barrio de Coyoacán, ideal para explorar arte y cultura.','Calle Francisco Sosa #456',1,2,150.00),(53,'Loft con Terraza en Roma Norte','Loft con terraza privada en la vibrante colonia Roma Norte, cerca de cafés y galerías de arte.','Calle Mérida #789',1,2,160.00),(54,'Penthouse en Santa Fe','Penthouse de lujo en el moderno distrito financiero de Santa Fe, perfecto para viajes de negocios.','Prolongación Paseo de la Reforma #1010',1,2,250.00),(55,'Apartamento Familiar en Condesa','Amplio apartamento familiar en la elegante colonia Condesa, ideal para quienes buscan estilo y confort.','Calle Michoacán #567',1,2,200.00),(56,'Apartamento en Manhattan','Acogedor apartamento en el corazón de Manhattan, cerca de teatros de Broadway y atracciones icónicas.','Broadway #123',11,14,300.00),(57,'Loft en Brooklyn','Espacioso loft en el creativo barrio de Brooklyn, ideal para explorar galerías de arte y mercados locales.','Smith Street #456',11,14,250.00),(58,'Casa Histórica en Greenwich Village','Casa histórica restaurada en el bohemio Greenwich Village, perfecta para quienes buscan una experiencia única.','Bleecker Street #789',11,14,280.00),(59,'Apartamento Ejecutivo en Midtown','Apartamento ejecutivo en el vibrante Midtown de Manhattan, ideal para estancias de negocios y placer.','5th Avenue #1010',11,14,350.00),(60,'Penthouse en Upper East Side','Penthouse con vistas impresionantes en el sofisticado Upper East Side, perfecto para estancias de lujo.','Park Avenue #567',11,14,400.00),(61,'Apartamento en Covent Garden','Apartamento elegante en el animado barrio de Covent Garden, cerca de teatros y tiendas de lujo.','Strand #123',185,NULL,280.00),(62,'Casa Adosada en Notting Hill','Encantadora casa adosada en el pintoresco Notting Hill, ideal para explorar mercados y cafeterías.','Portobello Road #456',185,NULL,320.00),(63,'Loft Moderno en Shoreditch','Loft moderno en el creativo Shoreditch, perfecto para quienes buscan arte urbano y vida nocturna.','Old Street #789',185,NULL,200.00),(64,'Penthouse en Kensington','Penthouse de lujo en el exclusivo Kensington, con vistas panorámicas de la ciudad.','Kensington High Street #1010',185,NULL,450.00),(65,'Apartamento Familiar en Camden Town','Amplio apartamento familiar en el vibrante Camden Town, cerca de mercados y música en vivo.','Camden High Street #567',185,NULL,300.00),(66,'Apartamento en Le Marais','Acogedor apartamento en el histórico Le Marais, cerca de museos y boutiques de moda.','Rue des Archives #123',71,20,250.00),(67,'Loft con Vistas a la Torre Eiffel','Loft espacioso con vistas impresionantes a la Torre Eiffel, ideal para una experiencia parisina única.','Quai Branly #456',71,20,380.00),(68,'Casa Renovada en Montmartre','Encantadora casa renovada en el bohemio Montmartre, perfecta para quienes buscan arte y cultura.','Rue des Abbesses #789',71,20,300.00),(69,'Apartamento Chic en Saint-Germain-des-Prés','Apartamento chic en el sofisticado Saint-Germain-des-Prés, ideal para estancias elegantes.','Rue de Rennes #1010',71,20,350.00),(70,'Penthouse en Champs-Élysées','Penthouse de lujo en la icónica avenida Champs-Élysées, con vistas a los Campos Elíseos.','Avenue des Champs-Élysées #567',71,20,500.00),(71,'Apartamento en Polanco','Moderno apartamento en la exclusiva zona de Polanco, cerca de restaurantes y tiendas de diseño.','Av. Presidente Masaryk #123',171,20,280.00),(72,'Casa Colonial en Coyoacán','Encantadora casa colonial en el histórico barrio de Coyoacán, perfecta para quienes buscan arte y cultura.','Calle Francisco Sosa #456',171,20,320.00),(73,'Loft en Reforma','Espacioso loft en la vibrante Avenida Reforma, ideal para explorar museos y vida nocturna.','Paseo de la Reforma #789',171,20,200.00),(74,'Penthouse en Santa Fe','Penthouse de lujo en la moderna zona de Santa Fe, con vistas panorámicas de la ciudad.','Av. Santa Fe #1010',171,20,450.00),(75,'Apartamento Familiar en Roma Norte','Amplio apartamento familiar en la bohemia colonia Roma Norte, cerca de cafés y galerías de arte.','Calle Córdoba #567',171,20,300.00),(76,'Casa con Jardín en Zapopan','Acogedora casa con jardín en el tranquilo Zapopan, ideal para familias o grupos.','Av. Vallarta #123',177,22,250.00),(77,'Apartamento en Providencia','Apartamento moderno en la zona de Providencia, cerca de restaurantes y centros comerciales.','Av. Pablo Neruda #456',177,22,280.00),(78,'Loft en el Centro Histórico','Loft contemporáneo en el animado Centro Histórico, perfecto para quienes buscan arte y arquitectura.','Calle Independencia #789',177,22,220.00),(79,'Penthouse con Vistas en Chapultepec','Penthouse con vistas espectaculares en la zona de Chapultepec, ideal para estancias de lujo.','Av. Chapultepec #1010',177,22,400.00),(80,'Apartamento Ejecutivo en Tlaquepaque','Apartamento ejecutivo en la tradicional Tlaquepaque, perfecto para viajes de negocios.','Av. Revolución #567',177,NULL,300.00),(81,'Casa Moderna en San Pedro','Casa moderna en la exclusiva zona de San Pedro Garza García, con piscina y jardín.','Av. Vasconcelos #123',175,22,350.00),(82,'Departamento en el Centro','Departamento contemporáneo en el corazón del Centro de Monterrey, cerca de puntos de interés turístico.','Calle Morelos #456',175,22,240.00),(83,'Loft Ejecutivo en Valle Oriente','Loft ejecutivo en la dinámica zona de Valle Oriente, ideal para estancias cortas o largas.','Av. Lázaro Cárdenas #789',175,22,280.00),(84,'Penthouse con Vista a la Sierra','Penthouse con impresionantes vistas a la Sierra Madre, perfecto para relajarse y disfrutar de la naturaleza.','Av. Eugenio Garza Sada #1010',175,22,420.00),(85,'Apartamento Familiar en Contry','Amplio apartamento familiar en la tranquila colonia Contry, ideal para vacaciones en familia.','Calle Río Amazonas #567',175,22,300.00),(86,'Villa de Lujo en Zona Hotelera','Espectacular villa de lujo en la Zona Hotelera de Cancún, con acceso directo a la playa.','Blvd. Kukulcán #123',172,20,600.00),(87,'Condominio Frente al Mar','Condominio frente al mar Caribe, ideal para quienes buscan unas vacaciones relajantes y llenas de confort.','Av. Bonampak #456',172,20,450.00),(88,'Apartamento con Vista a la Laguna Nichupté','Apartamento con vistas panorámicas a la laguna Nichupté, perfecto para amantes de la naturaleza.','Calle Labná #789',172,20,350.00),(89,'Casa Colonial en el Centro','Encantadora casa colonial en el corazón del Centro de Cancún, cerca de restaurantes y tiendas.','Av. Tulum #1010',172,22,320.00),(90,'Loft Moderno en Punta Cancún','Loft moderno en la exclusiva Punta Cancún, ideal para escapadas románticas o vacaciones en pareja.','Calle Yaxchilán #567',172,22,280.00),(91,'Casa Tradicional en el Centro Histórico','Casa tradicional en el pintoresco Centro Histórico de Puebla, con patio colonial.','Calle 5 de Mayo #123',176,22,260.00),(92,'Departamento Ejecutivo en Angelópolis','Departamento ejecutivo en la moderna zona de Angelópolis, cerca de centros comerciales y restaurantes.','Blvd. del Niño Poblano #456',176,22,300.00),(93,'Loft con Terraza en Cholula','Loft con terraza privada en la bohemia Cholula, con vistas a la Pirámide de Cholula.','Av. de los Remedios #789',176,22,240.00),(94,'Penthouse en Lomas de Angelópolis','Penthouse de lujo en Lomas de Angelópolis, con amplias áreas verdes y seguridad.','Calle Atlixcáyotl #1010',176,22,380.00),(95,'Apartamento Familiar en La Paz','Amplio apartamento familiar en la tranquila La Paz, perfecto para disfrutar de la cultura y gastronomía poblana.','Calle Francisco Villa #567',176,22,280.00),(96,'Apartamento Moderno en el Centro Histórico','Apartamento completamente equipado en el corazón del Centro Histórico de la Ciudad de México.','Calle Principal #123',1,2,1500.00),(97,'Casa Colonial en Coyoacán','Hermosa casa colonial en el barrio de Coyoacán, cerca de museos y cafés.','Calle Coyoacán #456',1,2,1800.00),(98,'Hotel Boutique en Polanco','Hotel boutique de lujo en la exclusiva zona de Polanco, ideal para viajeros exigentes.','Av. Presidente Masaryk #789',1,2,2500.00),(99,'Hostal en la Zona Rosa','Hostal con ambiente juvenil en la animada Zona Rosa, perfecto para quienes buscan vida nocturna.','Calle Zona Rosa #1010',1,2,500.00),(100,'Departamento con Vista al Ángel de la Independencia','Amplio departamento con vistas panorámicas al Ángel de la Independencia, ubicación privilegiada.','Av. Reforma #1111',1,2,2000.00),(101,'Casa Tradicional en Tlaquepaque','Casa tradicional en el encantador pueblo de Tlaquepaque, famoso por su artesanía.','Calle Tlaquepaque #123',2,5,1200.00),(102,'Hotel en el Centro Histórico','Hotel cómodo en el centro histórico de Guadalajara, cerca de la Catedral y los principales puntos de interés.','Av. Juárez #456',2,5,1500.00),(103,'Departamento Moderno en Zapopan','Moderno departamento en la zona residencial de Zapopan, ideal para estancias largas.','Calle Zapopan #789',2,5,1800.00),(104,'Hostal Boutique en Chapultepec','Hostal boutique con diseño contemporáneo en la vibrante zona de Chapultepec.','Av. Chapultepec #1010',2,5,600.00),(105,'Casa de Huéspedes en Tonalá','Acogedora casa de huéspedes en Tonalá, ideal para quienes buscan autenticidad y tranquilidad.','Calle Tonalá #1111',2,5,800.00),(106,'Loft Moderno en el Barrio Antiguo','Loft moderno en el trendy Barrio Antiguo de Monterrey, cerca de bares y galerías de arte.','Calle Barrio Antiguo #123',3,5,1000.00),(107,'Hotel Ejecutivo en San Pedro Garza García','Hotel ejecutivo en la exclusiva zona de San Pedro Garza García, ideal para viajeros de negocios.','Av. San Pedro #456',3,5,2000.00),(108,'Departamento con Vista a la Sierra Madre','Amplio departamento con vistas a la Sierra Madre en Monterrey, perfecto para quienes aman la naturaleza.','Av. Sierra Madre #789',3,6,1500.00),(109,'Hostal en el Centro de Monterrey','Hostal con ambiente internacional en el centro de Monterrey, ideal para mochileros y jóvenes viajeros.','Calle Centro #1010',3,6,400.00),(110,'Casa de Huéspedes en Fundidora','Casa de huéspedes cerca del Parque Fundidora, ideal para familias y grupos pequeños.','Calle Fundidora #1111',3,6,800.00),(111,'Casa Colonial en el Centro Histórico','Casa colonial restaurada en el centro histórico de Puebla, cerca de la Catedral y museos.','Calle Principal #123',4,6,900.00),(112,'Hotel Boutique en Cholula','Hotel boutique con encanto en Cholula, ideal para quienes desean explorar la zona arqueológica y la pirámide.','Av. Cholula #456',4,6,1200.00),(113,'Departamento Moderno en Angelópolis','Departamento moderno en la zona residencial de Angelópolis, perfecto para estancias largas.','Calle Angelópolis #789',4,6,1500.00),(114,'Hostal en la Zona de los Fuertes','Hostal con ambiente joven y dinámico en la zona de los Fuertes de Puebla, cerca de atracciones históricas.','Calle Fuertes #1010',4,6,300.00),(115,'Casa de Huéspedes en Atlixco','Acogedora casa de huéspedes en Atlixco, ideal para quienes buscan tranquilidad y contacto con la naturaleza.','Calle Atlixco #1111',4,6,600.00),(116,'Apartamento en la Zona Río','Amplio apartamento en la zona Río de Tijuana, cerca de restaurantes y centros comerciales.','Av. Río Tijuana #123',5,8,800.00),(117,'Casa con Vista al Mar en Playas de Tijuana','Casa con vistas espectaculares al mar en Playas de Tijuana, perfecta para vacaciones familiares.','Calle Playas #456',5,8,1500.00),(118,'Hotel Boutique en el Centro','Hotel boutique con diseño contemporáneo en el centro de Tijuana, ideal para viajeros que buscan comodidad.','Calle Centro #789',5,8,1200.00),(119,'Hostal en Zona Turística','Hostal económico en la zona turística de Tijuana, ideal para mochileros y viajeros con presupuesto limitado.','Calle Turística #1010',5,8,300.00),(120,'Casa de Huéspedes en Otay','Casa de huéspedes en la tranquila zona de Otay, perfecta para quienes viajan por negocios o placer.','Calle Otay #1111',5,8,500.00),(121,'Casa Moderna en León','Casa moderna con jardín en la ciudad de León, ideal para familias y grupos pequeños.','Av. Principal #123',6,8,700.00),(122,'Hotel en el Centro Histórico','Hotel cómodo en el centro histórico de León, cerca de la Plaza Principal y tiendas de artesanías.','Calle Centro #456',6,8,1000.00),(123,'Departamento Ejecutivo en Zona Dorada','Departamento ejecutivo en la exclusiva Zona Dorada de León, ideal para estancias de negocios.','Calle Zona Dorada #789',6,8,1200.00),(124,'Hostal en Plaza Mayor','Hostal con ambiente juvenil en la zona comercial de Plaza Mayor, perfecto para quienes buscan diversión y compras.','Av. Plaza Mayor #1010',6,8,400.00),(125,'Casa de Huéspedes en León Moderno','Acogedora casa de huéspedes en la zona residencial de León Moderno, ideal para estancias prolongadas.','Calle León Moderno #1111',6,10,600.00),(126,'Apartamento con Vista a la Ciudad','Amplio apartamento con vistas panorámicas a la ciudad en Juárez, ideal para estancias cortas y largas.','Av. Principal #123',7,10,800.00),(127,'Casa Colonial en el Centro','Casa colonial restaurada en el centro histórico de Juárez, cerca de museos y sitios de interés cultural.','Calle Centro #456',7,10,1200.00),(128,'Hotel de Lujo en Zona Río','Hotel de lujo en la exclusiva Zona Río de Juárez, perfecto para quienes buscan confort y exclusividad.','Av. Zona Río #789',7,10,2000.00),(129,'Hostal Económico en la Zona Turística','Hostal económico en la animada zona turística de Juárez, ideal para mochileros y jóvenes viajeros.','Calle Turística #1010',7,10,300.00),(130,'Casa de Huéspedes en Colonia Moderna','Casa de huéspedes acogedora en la moderna Colonia de Juárez, perfecta para estancias prolongadas.','Calle Colonia Moderna #1111',7,10,600.00),(131,'Casa Colonial en el Centro Histórico','Casa colonial restaurada en el encantador centro histórico de Mérida, cerca de plazas y restaurantes.','Calle Principal #123',8,12,900.00),(132,'Hotel Boutique en Paseo Montejo','Hotel boutique de lujo en la emblemática avenida Paseo de Montejo de Mérida, ideal para viajeros sofisticados.','Av. Paseo de Montejo #456',8,12,1500.00),(133,'Departamento Moderno en Altabrisa','Departamento moderno en la zona residencial de Altabrisa, perfecto para estancias largas.','Calle Altabrisa #789',8,12,1200.00),(134,'Hostal en el Centro Cultural','Hostal con ambiente cultural en el centro de Mérida, ideal para quienes buscan explorar la historia y el arte local.','Calle Centro Cultural #1010',8,12,400.00),(135,'Casa de Huéspedes en Santiago','Casa de huéspedes en el tradicional barrio de Santiago en Mérida, perfecta para una experiencia auténtica.','Calle Santiago #1111',8,12,700.00),(136,'Loft Moderno en el Centro Histórico','Loft moderno en el vibrante centro histórico de San Luis Potosí, cerca de plazas y monumentos.','Av. Principal #123',9,12,700.00),(137,'Hotel en Zona Universitaria','Hotel cómodo en la zona universitaria de San Luis Potosí, ideal para viajeros académicos y de negocios.','Calle Zona Universitaria #456',9,12,1000.00),(138,'Departamento Ejecutivo en Lomas','Departamento ejecutivo en la exclusiva zona de Lomas de San Luis Potosí, perfecto para estancias largas.','Av. Lomas #789',9,12,1200.00),(139,'Hostal en el Barrio de Tequis','Hostal con ambiente bohemio en el pintoresco barrio de Tequisquiapan en San Luis Potosí, ideal para mochileros.','Calle Tequis #1010',9,12,400.00),(140,'Casa de Huéspedes en Tangamanga','Casa de huéspedes en la zona natural de Tangamanga en San Luis Potosí, perfecta para quienes aman la naturaleza.','Calle Tangamanga #1111',9,12,600.00),(141,'Casa Colonial en el Centro Histórico','Casa colonial restaurada en el encantador centro histórico de Aguascalientes, cerca de plazas y museos.','Calle Principal #123',10,14,800.00),(142,'Hotel Boutique en la Zona Dorada','Hotel boutique de lujo en la exclusiva Zona Dorada de Aguascalientes, ideal para viajeros sofisticados.','Av. Zona Dorada #456',10,14,1500.00),(143,'Departamento Moderno en Villa Teresa','Departamento moderno en la zona residencial de Villa Teresa en Aguascalientes, perfecto para estancias largas.','Calle Villa Teresa #789',10,14,1200.00),(144,'Hostal en el Barrio de San Marcos','Hostal con ambiente juvenil en el tradicional barrio de San Marcos en Aguascalientes, ideal para mochileros.','Calle San Marcos #1010',10,14,400.00),(145,'Casa de Huéspedes en la Colonia España','Casa de huéspedes en la tranquila Colonia España de Aguascalientes, perfecta para una estancia relajante.','Calle Colonia España #1111',10,14,600.00),(146,'Loft Moderno en el Centro Histórico','Loft moderno en el vibrante centro histórico de Hermosillo, cerca de plazas y monumentos.','Av. Principal #123',11,14,700.00),(147,'Hotel en Zona Comercial','Hotel cómodo en la zona comercial de Hermosillo, ideal para viajeros de negocios y placer.','Calle Zona Comercial #456',11,14,1000.00),(148,'Departamento Ejecutivo en Las Lomas','Departamento ejecutivo en la exclusiva zona de Las Lomas en Hermosillo, perfecto para estancias largas.','Av. Las Lomas #789',11,16,1200.00),(149,'Hostal en el Barrio de la Villa','Hostal con ambiente juvenil en el pintoresco barrio de la Villa en Hermosillo, ideal para mochileros.','Calle Villa #1010',11,16,400.00),(150,'Casa de Huéspedes en la Colonia Centro','Casa de huéspedes en la tranquila Colonia Centro de Hermosillo, perfecta para una estancia relajante.','Calle Colonia Centro #1111',11,16,600.00),(151,'Casa Colonial en el Centro Histórico','Casa colonial restaurada en el encantador centro histórico de Saltillo, cerca de plazas y museos.','Calle Principal #123',12,16,800.00),(152,'Hotel Boutique en la Zona Norte','Hotel boutique de lujo en la exclusiva Zona Norte de Saltillo, ideal para viajeros sofisticados.','Av. Zona Norte #456',12,16,1500.00),(153,'Departamento Moderno en Villa Bonita','Departamento moderno en la zona residencial de Villa Bonita en Saltillo, perfecto para estancias largas.','Calle Villa Bonita #789',12,16,1200.00),(154,'Hostal en el Barrio de San Isidro','Hostal con ambiente juvenil en el tradicional barrio de San Isidro en Saltillo, ideal para mochileros.','Calle San Isidro #1010',12,16,400.00),(155,'Casa de Huéspedes en la Colonia Satélite','Casa de huéspedes en la tranquila Colonia Satélite de Saltillo, perfecta para una estancia relajante.','Calle Colonia Satélite #1111',12,16,600.00),(156,'Loft Moderno en el Centro Histórico','Loft moderno en el vibrante centro histórico de Mexicali, cerca de plazas y monumentos.','Av. Principal #123',14,16,700.00),(157,'Hotel en Zona Comercial','Hotel cómodo en la zona comercial de Mexicali, ideal para viajeros de negocios y placer.','Calle Zona Comercial #456',14,16,1000.00),(158,'Departamento Ejecutivo en Las Lomas','Departamento ejecutivo en la exclusiva zona de Las Lomas en Mexicali, perfecto para estancias largas.','Av. Las Lomas #789',14,16,1200.00),(159,'Hostal en el Barrio de la Villa','Hostal con ambiente juvenil en el pintoresco barrio de la Villa en Mexicali, ideal para mochileros.','Calle Villa #1010',14,16,400.00),(160,'Casa de Huéspedes en la Colonia Centro','Casa de huéspedes en la tranquila Colonia Centro de Mexicali, perfecta para una estancia relajante.','Calle Colonia Centro #1111',14,16,600.00),(161,'Casa Colonial en el Centro Histórico','Casa colonial restaurada en el encantador centro histórico de Culiacán, cerca de plazas y museos.','Calle Principal #123',15,16,800.00),(162,'Hotel Boutique en la Zona Dorada','Hotel boutique de lujo en la exclusiva Zona Dorada de Culiacán, ideal para viajeros sofisticados.','Av. Zona Dorada #456',15,16,1500.00),(163,'Departamento Moderno en Villa Teresa','Departamento moderno en la zona residencial de Villa Teresa en Culiacán, perfecto para estancias largas.','Calle Villa Teresa #789',15,16,1200.00),(164,'Hostal en el Barrio de San Isidro','Hostal con ambiente juvenil en el tradicional barrio de San Isidro en Culiacán, ideal para mochileros.','Calle San Isidro #1010',15,18,400.00),(165,'Casa de Huéspedes en la Colonia España','Casa de huéspedes en la tranquila Colonia España de Culiacán, perfecta para una estancia relajante.','Calle Colonia España #1111',15,18,600.00),(166,'Loft Moderno en el Centro Histórico','Loft moderno en el vibrante centro histórico de Chihuahua, cerca de plazas y monumentos.','Av. Principal #123',16,18,700.00),(167,'Hotel en Zona Comercial','Hotel cómodo en la zona comercial de Chihuahua, ideal para viajeros de negocios y placer.','Calle Zona Comercial #456',16,18,1000.00),(168,'Departamento Ejecutivo en Las Lomas','Departamento ejecutivo en la exclusiva zona de Las Lomas en Chihuahua, perfecto para estancias largas.','Av. Las Lomas #789',16,18,1200.00),(169,'Hostal en el Barrio de la Villa','Hostal con ambiente juvenil en el pintoresco barrio de la Villa en Chihuahua, ideal para mochileros.','Calle Villa #1010',16,18,400.00),(170,'Casa de Huéspedes en la Colonia Centro','Casa de huéspedes en la tranquila Colonia Centro de Chihuahua, perfecta para una estancia relajante.','Calle Colonia Centro #1111',16,18,600.00),(171,'Casa Colonial en el Centro Histórico','Casa colonial restaurada en el encantador centro histórico de Durango, cerca de plazas y museos.','Calle Principal #123',17,18,800.00),(172,'Hotel Boutique en la Zona Dorada','Hotel boutique de lujo en la exclusiva Zona Dorada de Durango, ideal para viajeros sofisticados.','Av. Zona Dorada #456',17,18,1500.00),(173,'Departamento Moderno en Villa Teresa','Departamento moderno en la zona residencial de Villa Teresa en Durango, perfecto para estancias largas.','Calle Villa Teresa #789',17,18,1200.00),(174,'Hostal en el Barrio de San Isidro','Hostal con ambiente juvenil en el tradicional barrio de San Isidro en Durango, ideal para mochileros.','Calle San Isidro #1010',17,18,400.00),(175,'Casa de Huéspedes en la Colonia España','Casa de huéspedes en la tranquila Colonia España de Durango, perfecta para una estancia relajante.','Calle Colonia España #1111',17,18,600.00),(176,'Loft Moderno en el Centro Histórico','Loft moderno en el vibrante centro histórico de Toluca, cerca de plazas y monumentos.','Av. Principal #123',18,18,700.00),(177,'Hotel en Zona Comercial','Hotel cómodo en la zona comercial de Toluca, ideal para viajeros de negocios y placer.','Calle Zona Comercial #456',18,18,1000.00),(178,'Departamento Ejecutivo en Las Lomas','Departamento ejecutivo en la exclusiva zona de Las Lomas en Toluca, perfecto para estancias largas.','Av. Las Lomas #789',18,18,1200.00),(179,'Hostal en el Barrio de la Villa','Hostal con ambiente juvenil en el pintoresco barrio de la Villa en Toluca, ideal para mochileros.','Calle Villa #1010',18,18,400.00),(180,'Casa de Huéspedes en la Colonia Centro','Casa de huéspedes en la tranquila Colonia Centro de Toluca, perfecta para una estancia relajante.','Calle Colonia Centro #1111',18,20,600.00),(181,'Casa Colonial en el Centro Histórico','Casa colonial restaurada en el encantador centro histórico de Querétaro, cerca de plazas y museos.','Calle Principal #123',19,20,800.00),(182,'Hotel Boutique en la Zona Dorada','Hotel boutique de lujo en la exclusiva Zona Dorada de Querétaro, ideal para viajeros sofisticados.','Av. Zona Dorada #456',19,20,1500.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendario_disponibilidad_propiedad`
--

LOCK TABLES `calendario_disponibilidad_propiedad` WRITE;
/*!40000 ALTER TABLE `calendario_disponibilidad_propiedad` DISABLE KEYS */;
INSERT INTO `calendario_disponibilidad_propiedad` VALUES (1,1,'2024-06-01',1),(2,1,'2024-06-02',1),(3,1,'2024-06-03',0),(4,1,'2024-06-04',1),(5,1,'2024-06-05',1),(6,2,'2024-06-01',0),(7,2,'2024-06-02',1),(8,2,'2024-06-03',1),(9,2,'2024-06-04',0),(10,2,'2024-06-05',1),(11,3,'2024-06-01',1),(12,3,'2024-06-02',1),(13,3,'2024-06-03',1),(14,3,'2024-06-04',1),(15,3,'2024-06-05',0),(16,1,'2024-06-01',1),(17,1,'2024-06-02',1),(18,1,'2024-06-03',0),(19,1,'2024-06-04',1),(20,1,'2024-06-05',1),(21,2,'2024-06-01',0),(22,2,'2024-06-02',1),(23,2,'2024-06-03',1),(24,2,'2024-06-04',0),(25,2,'2024-06-05',1),(26,3,'2024-06-01',1),(27,3,'2024-06-02',1),(28,3,'2024-06-03',1),(29,3,'2024-06-04',1),(30,3,'2024-06-05',0),(31,4,'2024-06-01',1),(32,4,'2024-06-02',0),(33,4,'2024-06-03',1),(34,4,'2024-06-04',0),(35,4,'2024-06-05',1),(36,5,'2024-06-01',1),(37,5,'2024-06-02',1),(38,5,'2024-06-03',0),(39,5,'2024-06-04',1),(40,5,'2024-06-05',0),(41,6,'2024-06-01',0),(42,6,'2024-06-02',1),(43,6,'2024-06-03',1),(44,6,'2024-06-04',1),(45,6,'2024-06-05',1),(46,7,'2024-06-01',1),(47,7,'2024-06-02',0),(48,7,'2024-06-03',1),(49,7,'2024-06-04',0),(50,7,'2024-06-05',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudad`
--

LOCK TABLES `ciudad` WRITE;
/*!40000 ALTER TABLE `ciudad` DISABLE KEYS */;
INSERT INTO `ciudad` VALUES (1,'Chihuahua',141),(2,'Ciudad de México',141),(3,'Guadalajara',141),(4,'Monterrey',141),(5,'Puebla',141),(6,'Tijuana',141),(7,'León',141),(8,'Juárez',141),(9,'Zapopan',141),(10,'Mérida',141),(11,'San Luis Potosí',141),(12,'Aguascalientes',141),(13,'Hermosillo',141),(14,'Saltillo',141),(15,'Mexicali',141),(16,'Culiacán',141),(17,'Chihuahua',141),(18,'Durango',141),(19,'Toluca',141),(20,'Querétaro',141),(21,'Acapulco',141),(22,'Veracruz',141),(23,'Cancún',141),(24,'Pachuca',141),(25,'Morelia',141),(26,'Oaxaca',141),(27,'Campeche',141),(28,'Tuxtla Gutiérrez',141),(29,'La Paz',141),(30,'Colima',141),(31,'Guadalajara',141),(32,'Mazatlán',141),(33,'Cuernavaca',141),(34,'Piedras Negras',141),(35,'Poza Rica',141),(36,'Nuevo Laredo',141),(37,'San Cristóbal de las Casas',141),(38,'Ciudad del Carmen',141),(39,'Tampico',141),(40,'Matamoros',141),(41,'Xalapa',141),(42,'Tlaxcala',141),(43,'Villahermosa',141),(44,'Reynosa',141),(45,'Chetumal',141),(46,'Tepic',141),(47,'Monclova',141),(48,'San Juan del Río',141),(49,'Comitán de Domínguez',141),(50,'Saint-Dié-des-Vosges',71);
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
INSERT INTO `favoritos` VALUES (1,1,1,'2024-05-29 05:15:51'),(2,1,2,'2024-05-29 05:15:51'),(3,1,3,'2024-05-29 05:15:51'),(4,1,4,'2024-05-29 05:15:51'),(5,1,5,'2024-05-29 05:15:51'),(6,2,6,'2024-05-29 05:15:51'),(7,2,7,'2024-05-29 05:15:51'),(8,2,8,'2024-05-29 05:15:51'),(9,2,9,'2024-05-29 05:15:51'),(10,2,10,'2024-05-29 05:15:51'),(11,3,11,'2024-05-29 05:15:51'),(12,3,12,'2024-05-29 05:15:51'),(13,3,13,'2024-05-29 05:15:51'),(14,3,14,'2024-05-29 05:15:51'),(15,3,15,'2024-05-29 05:15:51'),(16,4,16,'2024-05-29 05:15:51'),(17,4,17,'2024-05-29 05:15:51'),(18,4,18,'2024-05-29 05:15:51'),(19,4,19,'2024-05-29 05:15:51'),(20,4,20,'2024-05-29 05:15:51'),(21,5,21,'2024-05-29 05:15:51'),(22,5,22,'2024-05-29 05:15:51'),(23,5,23,'2024-05-29 05:15:51'),(24,5,24,'2024-05-29 05:15:51'),(25,5,25,'2024-05-29 05:15:51'),(26,6,26,'2024-05-29 05:15:51'),(27,6,27,'2024-05-29 05:15:51'),(28,6,28,'2024-05-29 05:15:51'),(29,6,29,'2024-05-29 05:15:51'),(30,6,30,'2024-05-29 05:15:51'),(31,7,31,'2024-05-29 05:15:51'),(32,7,32,'2024-05-29 05:15:51'),(33,7,33,'2024-05-29 05:15:51'),(34,7,34,'2024-05-29 05:15:51'),(35,7,35,'2024-05-29 05:15:51'),(36,8,36,'2024-05-29 05:15:51'),(37,8,37,'2024-05-29 05:15:51'),(38,8,38,'2024-05-29 05:15:51'),(39,8,39,'2024-05-29 05:15:51'),(40,8,40,'2024-05-29 05:15:51'),(41,9,41,'2024-05-29 05:15:51'),(42,9,42,'2024-05-29 05:15:51'),(43,9,43,'2024-05-29 05:15:51'),(44,9,44,'2024-05-29 05:15:51'),(45,9,45,'2024-05-29 05:15:51'),(46,10,46,'2024-05-29 05:15:51'),(47,10,47,'2024-05-29 05:15:51'),(48,10,48,'2024-05-29 05:15:51'),(49,10,49,'2024-05-29 05:15:51'),(50,10,50,'2024-05-29 05:15:51');
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ActualizarNumeroFavoritos` AFTER INSERT ON `favoritos` FOR EACH ROW BEGIN
    UPDATE alojamiento
    SET numero_favoritos = (SELECT COUNT(*) FROM favoritos WHERE id_alojamiento = NEW.id_alojamiento)
    WHERE id_alojamiento = NEW.id_alojamiento;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` VALUES (9,'2024-05-29','2024-06-03',NULL,NULL),(10,'2024-05-29','2024-06-03',NULL,NULL),(11,'2024-05-29','2024-06-03',NULL,NULL),(12,'2024-05-29','2024-06-03',NULL,NULL),(13,'2024-05-29','2024-06-03',NULL,NULL);
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ActualizarDisponibilidadAlojamiento` AFTER INSERT ON `reserva` FOR EACH ROW BEGIN
    UPDATE calendario_disponibilidad_propiedad
    SET disponible = 0
    WHERE id_alojamiento = NEW.id_alojamiento
    AND fecha BETWEEN NEW.fecha_inicio AND NEW.fecha_fin;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `NotificarArrendatarioReserva` AFTER INSERT ON `reserva` FOR EACH ROW BEGIN
    DECLARE v_nombre_arrendatario VARCHAR(100);
    
    -- Obtener el nombre del arrendatario
    SELECT nombre INTO v_nombre_arrendatario
    FROM usuario
    WHERE id_usuario = (SELECT id_anfitrion FROM alojamiento WHERE id_alojamiento = NEW.id_alojamiento);

    -- Enviar notificación al arrendatario (código simulado)
    INSERT INTO notificaciones (mensaje, destinatario)
    VALUES (CONCAT('Se ha realizado una reserva en su alojamiento por el cliente ', NEW.id_huesped, '.'), v_nombre_arrendatario);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `RegistrarAccionUsuario` AFTER INSERT ON `reserva` FOR EACH ROW BEGIN
    INSERT INTO registros_auditoria (accion, usuario_id, fecha)
    VALUES ('Nueva reserva creada', NEW.id_huesped, NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacciones`
--

LOCK TABLES `transacciones` WRITE;
/*!40000 ALTER TABLE `transacciones` DISABLE KEYS */;
INSERT INTO `transacciones` VALUES (1,41,'tarjeta_credito',250.00),(2,42,'tarjeta_debito',180.50),(3,43,'tarjeta_credito',300.00),(4,44,'tarjeta_debito',150.75),(5,45,'tarjeta_credito',280.00),(6,46,'tarjeta_debito',200.25),(7,47,'tarjeta_credito',320.00),(8,48,'tarjeta_debito',220.50),(9,49,'tarjeta_credito',350.00),(10,50,'tarjeta_debito',180.25),(11,51,'tarjeta_credito',270.00),(12,52,'tarjeta_debito',190.75),(13,53,'tarjeta_credito',290.00),(14,54,'tarjeta_debito',210.50),(15,55,'tarjeta_credito',310.00),(16,56,'tarjeta_debito',230.25),(17,57,'tarjeta_credito',330.00),(18,58,'tarjeta_debito',240.50),(19,59,'tarjeta_credito',360.00),(20,60,'tarjeta_debito',250.75),(21,11,'tarjeta_credito',250.00),(22,12,'tarjeta_debito',180.50),(23,13,'tarjeta_credito',300.00),(24,14,'tarjeta_debito',150.75),(25,15,'tarjeta_credito',280.00),(26,16,'tarjeta_debito',200.25),(27,17,'tarjeta_credito',320.00),(28,18,'tarjeta_debito',220.50),(29,19,'tarjeta_credito',350.00),(30,20,'tarjeta_debito',180.25),(31,21,'tarjeta_credito',270.00),(32,22,'tarjeta_debito',190.75),(33,23,'tarjeta_credito',290.00),(34,24,'tarjeta_debito',210.50),(35,25,'tarjeta_credito',310.00),(36,26,'tarjeta_debito',230.25),(37,27,'tarjeta_credito',330.00),(38,28,'tarjeta_debito',240.50),(39,29,'tarjeta_credito',360.00),(40,30,'tarjeta_debito',250.75),(41,36,'tarjeta_credito',270.00),(42,37,'tarjeta_debito',190.75),(43,38,'tarjeta_credito',290.00),(44,39,'tarjeta_debito',210.50),(45,40,'tarjeta_credito',310.00),(46,41,'tarjeta_debito',230.25),(47,42,'tarjeta_credito',330.00),(48,43,'tarjeta_debito',240.50),(49,44,'tarjeta_credito',350.00),(50,45,'tarjeta_debito',250.75),(51,46,'tarjeta_credito',280.00),(52,47,'tarjeta_debito',200.25),(53,48,'tarjeta_credito',320.00),(54,49,'tarjeta_debito',220.50),(55,50,'tarjeta_credito',360.00),(56,51,'tarjeta_debito',180.25),(57,52,'tarjeta_credito',300.00),(58,53,'tarjeta_debito',150.75),(59,54,'tarjeta_credito',250.00),(60,55,'tarjeta_debito',180.50),(61,31,'tarjeta_credito',250.00),(62,31,'tarjeta_debito',180.50),(63,32,'tarjeta_credito',300.00),(64,32,'tarjeta_debito',150.75),(65,33,'tarjeta_credito',280.00),(66,33,'tarjeta_debito',200.25),(67,34,'tarjeta_credito',320.00),(68,34,'tarjeta_debito',220.50),(69,35,'tarjeta_credito',350.00),(70,35,'tarjeta_debito',180.25),(71,41,'tarjeta_credito',250.00),(72,42,'tarjeta_debito',180.50),(73,43,'tarjeta_credito',300.00),(74,44,'tarjeta_debito',150.75),(75,45,'tarjeta_credito',280.00),(76,46,'tarjeta_debito',200.25),(77,47,'tarjeta_credito',320.00),(78,48,'tarjeta_debito',220.50),(79,49,'tarjeta_credito',350.00),(80,50,'tarjeta_debito',180.25),(81,51,'tarjeta_credito',270.00),(82,52,'tarjeta_debito',190.75),(83,53,'tarjeta_credito',290.00),(84,54,'tarjeta_debito',210.50),(85,55,'tarjeta_credito',310.00),(86,56,'tarjeta_debito',230.25),(87,57,'tarjeta_credito',330.00),(88,58,'tarjeta_debito',240.50),(89,59,'tarjeta_credito',360.00),(90,60,'tarjeta_debito',250.75),(91,11,'tarjeta_credito',250.00),(92,12,'tarjeta_debito',180.50),(93,13,'tarjeta_credito',300.00),(94,14,'tarjeta_debito',150.75),(95,15,'tarjeta_credito',280.00),(96,16,'tarjeta_debito',200.25),(97,17,'tarjeta_credito',320.00),(98,18,'tarjeta_debito',220.50),(99,19,'tarjeta_credito',350.00),(100,20,'tarjeta_debito',180.25),(101,21,'tarjeta_credito',270.00),(102,22,'tarjeta_debito',190.75),(103,23,'tarjeta_credito',290.00),(104,24,'tarjeta_debito',210.50),(105,25,'tarjeta_credito',310.00),(106,26,'tarjeta_debito',230.25),(107,27,'tarjeta_credito',330.00),(108,28,'tarjeta_debito',240.50),(109,29,'tarjeta_credito',360.00),(110,30,'tarjeta_debito',250.75),(111,36,'tarjeta_credito',270.00),(112,37,'tarjeta_debito',190.75),(113,38,'tarjeta_credito',290.00),(114,39,'tarjeta_debito',210.50),(115,40,'tarjeta_credito',310.00),(116,41,'tarjeta_debito',230.25),(117,42,'tarjeta_credito',330.00),(118,43,'tarjeta_debito',240.50),(119,44,'tarjeta_credito',350.00),(120,45,'tarjeta_debito',250.75),(121,46,'tarjeta_credito',280.00),(122,47,'tarjeta_debito',200.25),(123,48,'tarjeta_credito',320.00),(124,49,'tarjeta_debito',220.50),(125,50,'tarjeta_credito',360.00),(126,51,'tarjeta_debito',180.25),(127,52,'tarjeta_credito',300.00),(128,53,'tarjeta_debito',150.75),(129,54,'tarjeta_credito',250.00),(130,55,'tarjeta_debito',180.50),(131,31,'tarjeta_credito',250.00),(132,31,'tarjeta_debito',180.50),(133,32,'tarjeta_credito',300.00),(134,32,'tarjeta_debito',150.75),(135,33,'tarjeta_credito',280.00),(136,33,'tarjeta_debito',200.25),(137,34,'tarjeta_credito',320.00),(138,34,'tarjeta_debito',220.50),(139,35,'tarjeta_credito',350.00),(140,35,'tarjeta_debito',180.25);
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
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Felix','Fenix','felix@correo.com','Street 123',141,1,'felix123','Cliente','2024-05-27'),(2,'Jose','Hernandez','jose@correo.com','Steet 1234',141,1,'felix1234','Arrendatario','2024-05-27'),(3,'María','García','maria@email.com','Calle Principal 456',141,1,'maria123','Cliente','2024-05-28'),(4,'Pedro','Martínez','pedro@email.com','Avenida Central 789',141,2,'pedro123','Cliente','2024-05-28'),(5,'Ana','López','ana@email.com','Plaza Mayor 321',141,3,'ana123','Arrendatario','2024-05-28'),(6,'Juan','Hernández','juan@email.com','Paseo de las Flores 987',141,4,'juan123','Arrendatario','2024-05-28'),(7,'Sofía','Pérez','sofia@email.com','Avenida Revolución 654',141,5,'sofia123','Cliente','2024-05-28'),(8,'Carlos','Gómez','carlos@email.com','Boulevard Independencia 753',141,6,'carlos123','Arrendatario','2024-05-28'),(9,'Luisa','Rodríguez','luisa@email.com','Callejón del Sol 852',141,7,'luisa123','Cliente','2024-05-28'),(10,'Javier','González','javier@email.com','Avenida Reforma 159',141,8,'javier123','Arrendatario','2024-05-28'),(11,'Laura','Díaz','laura@email.com','Pasaje Colón 753',141,9,'laura123','Cliente','2024-05-28'),(12,'Andrés','Martínez','andres@email.com','Avenida Juárez 357',141,10,'andres123','Arrendatario','2024-05-28'),(13,'Valeria','Sánchez','valeria@email.com','Calle Nueva 456',141,11,'valeria123','Cliente','2024-05-28'),(14,'Pablo','Ramírez','pablo@email.com','Avenida Principal 789',141,12,'pablo123','Arrendatario','2024-05-28'),(15,'Daniela','Torres','daniela@email.com','Plaza Central 321',141,13,'daniela123','Cliente','2024-05-28'),(16,'Martín','Flores','martin@email.com','Paseo del Río 987',141,14,'martin123','Arrendatario','2024-05-28'),(17,'Lucía','Herrera','lucia@email.com','Avenida del Sol 654',141,15,'lucia123','Cliente','2024-05-28'),(18,'Diego','López','diego@email.com','Boulevard de la Independencia 753',141,16,'diego123','Arrendatario','2024-05-28'),(19,'Gabriela','Gómez','gabriela@email.com','Callejón de la Luna 852',141,17,'gabriela123','Cliente','2024-05-28'),(20,'Alejandro','Hernández','alejandro@email.com','Pasaje de las Estrellas 159',141,18,'alejandro123','Arrendatario','2024-05-28'),(21,'Fernanda','Martínez','fernanda@email.com','Avenida Morelos 753',141,19,'fernanda123','Cliente','2024-05-28'),(22,'Roberto','Díaz','roberto@email.com','Calle de la Paz 357',141,20,'roberto123','Arrendatario','2024-05-28'),(23,'Juan','García','juan.garcia@example.com','Av. Revolución 123',141,1,'juancito123','Cliente','2024-05-29'),(24,'María','López','maria.lopez@example.com','Calle Principal 456',141,1,'maria456','Cliente','2024-05-29'),(25,'Carlos','Martínez','carlos.martinez@example.com','Blvd. Constitución 789',141,1,'carlitos789','Cliente','2024-05-29'),(26,'Ana','Hernández','ana.hernandez@example.com','Av. Hidalgo 321',141,1,'ana321','Cliente','2024-05-29'),(27,'Pedro','Sánchez','pedro.sanchez@example.com','Calle Juárez 987',141,1,'pedrito987','Cliente','2024-05-29'),(28,'Luisa','Gómez','luisa.gomez@example.com','Av. Reforma 654',141,1,'luisita654','Cliente','2024-05-29'),(29,'Javier','Díaz','javier.diaz@example.com','Calle Libertad 234',141,1,'javier234','Cliente','2024-05-29'),(30,'Laura','Pérez','laura.perez@example.com','Av. Morelos 876',141,1,'laura876','Cliente','2024-05-29'),(31,'Alejandro','Rodríguez','alejandro.rodriguez@example.com','Calle Independencia 543',141,1,'alejandro543','Cliente','2024-05-29'),(32,'Gabriela','Flores','gabriela.flores@example.com','Blvd. Madero 210',141,1,'gabriela210','Cliente','2024-05-29'),(33,'Roberto','Gutiérrez','roberto.gutierrez@example.com','Av. Zaragoza 789',141,1,'roberto789','Cliente','2024-05-29'),(34,'Sofía','Torres','sofia.torres@example.com','Calle 5 de Mayo 432',141,1,'sofia432','Cliente','2024-05-29'),(35,'Daniel','Ortega','daniel.ortega@example.com','Blvd. López Mateos 567',141,1,'daniel567','Cliente','2024-05-29'),(36,'Fernanda','Ramírez','fernanda.ramirez@example.com','Av. Cuauhtémoc 876',141,1,'fernanda876','Cliente','2024-05-29'),(37,'Ricardo','Reyes','ricardo.reyes@example.com','Calle Allende 543',141,1,'ricardo543','Cliente','2024-05-29'),(38,'Verónica','Morales','veronica.morales@example.com','Av. Miguel Hidalgo 210',141,1,'veronica210','Cliente','2024-05-29'),(39,'José','Chávez','jose.chavez@example.com','Calle Colón 789',141,1,'jose789','Cliente','2024-05-29'),(40,'Paula','Vargas','paula.vargas@example.com','Blvd. Insurgentes 432',141,1,'paula432','Cliente','2024-05-29'),(41,'Martín','Jiménez','martin.jimenez@example.com','Av. Universidad 567',141,1,'martin567','Cliente','2024-05-29'),(42,'Elena','Suárez','elena.suarez@example.com','Calle Revillagigedo 876',141,1,'elena876','Cliente','2024-05-29'),(43,'Sophie','Martin','sophie.martin@example.com','Rue de la Liberté 123',73,1,'sophie123','Cliente','2024-05-29'),(44,'Maxime','Lefevre','maxime.lefevre@example.com','Avenue des Champs 456',73,1,'maxime456','Cliente','2024-05-29'),(45,'Elena','Kovalenko','elena.kovalenko@example.com','Ulitsa Lenina 789',181,1,'elena789','Cliente','2024-05-29'),(46,'Mateusz','Nowak','mateusz.nowak@example.com','Aleja Jana Pawla II 321',172,1,'mateusz321','Cliente','2024-05-29'),(47,'Marta','Garcia','marta.garcia@example.com','Calle de Alcala 987',123,1,'marta987','Cliente','2024-05-29'),(48,'Antonio','Russo','antonio.russo@example.com','Via Roma 654',122,1,'antonio654','Cliente','2024-05-29'),(49,'Julia','Andersen','julia.andersen@example.com','Gammel Kongevej 234',58,1,'julia234','Cliente','2024-05-29'),(50,'Lukas','Novak','lukas.novak@example.com','Opletalova 876',61,1,'lukas876','Cliente','2024-05-29'),(51,'Maria','Silva','maria.silva@example.com','Rua de Santa Catarina 543',17,1,'maria543','Cliente','2024-05-29'),(52,'Piotr','Nowakowski','piotr.nowakowski@example.com','Aleja Solidarnosci 210',172,1,'piotr210','Cliente','2024-05-29'),(53,'Emma','Dubois','emma.dubois@example.com','Rue du Faubourg 789',73,1,'emma789','Cliente','2024-05-29'),(54,'Oscar','Jensen','oscar.jensen@example.com','Vesterbrogade 432',57,1,'oscar432','Cliente','2024-05-29'),(55,'Sofia','Santos','sofia.santos@example.com','Avenida da Liberdade 567',17,1,'sofia567','Cliente','2024-05-29'),(56,'Nikolai','Ivanov','nikolai.ivanov@example.com','Ulitsa Gagarina 876',195,1,'nikolai876','Cliente','2024-05-29'),(57,'Isabella','Ferrari','isabella.ferrari@example.com','Via Giuseppe Verdi 543',122,1,'isabella543','Cliente','2024-05-29'),(58,'Johan','Lund','johan.lund@example.com','Kungsgatan 210',193,1,'johan210','Cliente','2024-05-29'),(59,'Laura','Moreno','laura.moreno@example.com','Carrer de Balmes 789',64,1,'laura789','Cliente','2024-05-29'),(60,'Alexander','Kuznetsov','alexander.kuznetsov@example.com','Ulitsa Lenina 432',195,1,'alexander432','Cliente','2024-05-29'),(61,'Emilie','Berger','emilie.berger@example.com','Rue de Rivoli 567',73,1,'emilie567','Cliente','2024-05-29'),(62,'Viktor','Jensen','viktor.jensen@example.com','Nørre Voldgade 876',57,1,'viktor876','Cliente','2024-05-29'),(130,'José de Jesús','HERNANDEZ VAZQUEZ','johernandezvaz@gmail.com','36 Avenue Ernest Colin',71,50,'contrasena','Cliente','2024-05-29');
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

-- Dump completed on 2024-06-02 19:25:12
