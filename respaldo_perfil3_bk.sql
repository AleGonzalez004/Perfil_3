-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: Perfil3DJ
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

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
-- Table structure for table `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumnos` (
  `id_alumno` int(11) NOT NULL DEFAULT uuid(),
  `carnet_alumno` varchar(10) DEFAULT NULL,
  `nombre_alumno` varchar(50) DEFAULT NULL,
  `apellido_alumno` varchar(50) DEFAULT NULL,
  `edad_alumno` int(11) DEFAULT NULL CHECK (`edad_alumno` >= 0),
  PRIMARY KEY (`id_alumno`),
  UNIQUE KEY `uni_carnet` (`carnet_alumno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumnos`
--

LOCK TABLES `alumnos` WRITE;
/*!40000 ALTER TABLE `alumnos` DISABLE KEYS */;
INSERT INTO `alumnos` VALUES (1,'20220440','Dennis','Gonzalez',20),(2,'20220235','Jose','Angel',22),(3,'20220315','Anderson','Coto',21),(4,'20220412','Cesar','Lopez',23),(5,'20220505','Daniel','Perez',24),(6,'20220620','Juan','Rodriguez',25),(7,'20220703','Fernando','Gomez',22),(8,'20220818','Axel','Hernandez',19),(9,'20220901','Lenny','Diaz',21),(10,'20221011','Eduardo','Torres',24),(11,'20221130','Rebbeca','Lopez',22),(12,'20221205','Fernando','Ramirez',23),(13,'20221314','Gabriela','Castro',20),(14,'20221425','Miguel','Fernandez',25),(15,'20221508','Alejandra','Rojas',22);
/*!40000 ALTER TABLE `alumnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calificaciones`
--

DROP TABLE IF EXISTS `calificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calificaciones` (
  `id_calificacion` int(11) NOT NULL DEFAULT uuid(),
  `id_inscripcion` int(11) DEFAULT uuid(),
  `calificacion_final` decimal(5,2) DEFAULT NULL CHECK (`calificacion_final` >= 0),
  `fecha_calificacion` date DEFAULT curtime(),
  PRIMARY KEY (`id_calificacion`),
  KEY `fk_id_inscripcion_calificaciones` (`id_inscripcion`),
  CONSTRAINT `fk_id_inscripcion_calificaciones` FOREIGN KEY (`id_inscripcion`) REFERENCES `inscripciones` (`id_inscripcion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificaciones`
--

LOCK TABLES `calificaciones` WRITE;
/*!40000 ALTER TABLE `calificaciones` DISABLE KEYS */;
INSERT INTO `calificaciones` VALUES (1,1,8.50,'2024-02-28'),(2,2,7.20,'2024-02-28'),(3,3,9.70,'2024-02-28'),(4,4,6.30,'2024-02-28'),(5,5,8.90,'2024-02-28'),(6,6,7.60,'2024-02-28'),(7,7,9.20,'2024-02-28'),(8,8,8.70,'2024-02-28'),(9,9,8.40,'2024-02-28'),(10,10,7.90,'2024-02-28'),(11,11,9.10,'2024-02-28'),(12,12,7.80,'2024-02-28'),(13,13,8.40,'2024-02-28'),(14,14,8.30,'2024-02-28'),(15,15,9.60,'2024-02-28');
/*!40000 ALTER TABLE `calificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscripciones`
--

DROP TABLE IF EXISTS `inscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inscripciones` (
  `id_inscripcion` int(11) NOT NULL DEFAULT uuid(),
  `id_alumno` int(11) DEFAULT uuid(),
  `id_materia` int(11) DEFAULT uuid(),
  `fecha_inscripcion` date DEFAULT curtime(),
  `estado` enum('Activo','Inactivo') NOT NULL,
  PRIMARY KEY (`id_inscripcion`),
  KEY `fk_id_alumno_inscripciones` (`id_alumno`),
  KEY `fk_id_materia_inscripciones` (`id_materia`),
  CONSTRAINT `fk_id_alumno_inscripciones` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`id_alumno`),
  CONSTRAINT `fk_id_materia_inscripciones` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscripciones`
--

LOCK TABLES `inscripciones` WRITE;
/*!40000 ALTER TABLE `inscripciones` DISABLE KEYS */;
INSERT INTO `inscripciones` VALUES (1,1,1,'2024-01-11','Activo'),(2,2,1,'2024-01-11','Inactivo'),(3,3,1,'2024-01-11','Activo'),(4,4,1,'2024-01-11','Inactivo'),(5,5,1,'2024-01-11','Activo'),(6,6,1,'2024-01-11','Activo'),(7,7,1,'2024-01-11','Inactivo'),(8,8,1,'2024-01-11','Activo'),(9,9,1,'2024-01-11','Activo'),(10,10,1,'2024-01-11','Inactivo'),(11,11,1,'2024-01-11','Activo'),(12,12,1,'2024-01-11','Activo'),(13,13,1,'2024-01-11','Inactivo'),(14,14,1,'2024-01-11','Activo'),(15,15,1,'2024-01-11','Inactivo');
/*!40000 ALTER TABLE `inscripciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`edu_manage`@`localhost`*/ /*!50003 TRIGGER after_inscripcion_trigger AFTER INSERT ON inscripciones
FOR EACH ROW
BEGIN
    UPDATE materias
    SET cupos = cupos - 1
    WHERE id_materia = NEW.id_materia AND cupos > 0;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `materias`
--

DROP TABLE IF EXISTS `materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materias` (
  `id_materia` int(11) NOT NULL DEFAULT uuid(),
  `nombre_materia` varchar(100) NOT NULL,
  `grupo_materia` int(11) NOT NULL,
  `id_profesor` int(11) DEFAULT uuid(),
  `cupos` int(11) DEFAULT NULL CHECK (`cupos` >= 0),
  PRIMARY KEY (`id_materia`),
  KEY `fk_id_profesor_materias` (`id_profesor`),
  CONSTRAINT `fk_id_profesor_materias` FOREIGN KEY (`id_profesor`) REFERENCES `profesores` (`id_profesor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
INSERT INTO `materias` VALUES (1,'Matemáticas',101,1,0),(2,'Física',102,2,8),(3,'Química',103,3,6),(4,'Biología',104,4,10),(5,'Historia',105,5,7),(6,'Inglés',106,6,12),(7,'Arte',107,7,9),(8,'Educación Física',108,8,15),(9,'Programación',109,9,11),(10,'Literatura',110,10,14),(11,'Geografía',111,11,8),(12,'Economía',112,12,13),(13,'Psicología',113,13,10),(14,'Sociología',114,14,16),(15,'Filosofía',115,15,10);
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesores`
--

DROP TABLE IF EXISTS `profesores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profesores` (
  `id_profesor` int(11) NOT NULL DEFAULT uuid(),
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo_electronico` varchar(100) NOT NULL,
  PRIMARY KEY (`id_profesor`),
  UNIQUE KEY `uni_correo` (`correo_electronico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesores`
--

LOCK TABLES `profesores` WRITE;
/*!40000 ALTER TABLE `profesores` DISABLE KEYS */;
INSERT INTO `profesores` VALUES (1,'Willfredo','Granados','Willfredo@gmail.com'),(2,'Ricardo','Perez','Riacrdo@gmail.com'),(3,'Carranza','Lopez','Carranza@gmail.com'),(4,'Anderson','Perez','Anderson@gmail.com'),(5,'Juan','Rodriguez','juanz@gmail.com'),(6,'Maria','Gomez','maria@gmail.com'),(7,'Pedro','Hernandez','pedro@gmail.com'),(8,'Sofia','Diaz','sofia@gmail.com'),(9,'Eduardo','Torres','eduardo@gmail.com'),(10,'Isabel','Santos','isabel@gmail.com'),(11,'Fernando','Ramirez','fernando@gmail.com'),(12,'Gabriela','Castro','gabriela@gmail.com'),(13,'Miguel','Fernandez','miguel@gmail.com'),(14,'Alejandra','Rojas','alejandra@gmail.com'),(15,'Diana','Gutierrez','diana@gmail.com');
/*!40000 ALTER TABLE `profesores` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-28 11:31:27
