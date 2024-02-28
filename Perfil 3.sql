-- Perfil 3.
-- Integrantes: José Miguel Ángel Castillo y Dennis Alejandro Gonzalez Carrillo.alter


-- Creación de la Base de Datos.

DROP DATABASE IF EXISTS Perfil3DJ;

CREATE DATABASE Perfil3DJ;

USE Perfil3DJ;


-- Creación de las tablas.

CREATE TABLE profesores(
	id_profesor INT PRIMARY KEY DEFAULT (UUID()),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL
);

CREATE TABLE alumnos(
	id_alumno INT PRIMARY KEY DEFAULT (UUID()),
    carnet_alumno VARCHAR(10),
    nombre_alumno VARCHAR(50),
    apellido_alumno VARCHAR(50),
	edad_alumno INT CHECK(edad_alumno >= 0)
);

CREATE TABLE materias(
	id_materia INT PRIMARY KEY DEFAULT (UUID()),
    nombre_materia VARCHAR(100) NOT NULL,
    grupo_materia INT NOT NULL,
	id_profesor INT DEFAULT (UUID()),
	cupos INT CHECK(cupos >= 0)
);

CREATE TABLE inscripciones(
	id_inscripcion INT PRIMARY KEY DEFAULT (UUID()),
    id_alumno INT DEFAULT (UUID()),
	id_materia INT DEFAULT (UUID()),
	fecha_inscripcion DATE DEFAULT (CURRENT_TIME()),
    estado enum('Activo', 'Inactivo') NOT NULL
);

CREATE TABLE calificaciones(
	id_calificacion INT PRIMARY KEY DEFAULT (UUID()) NOT NULL,
    id_inscripcion INT DEFAULT (UUID()),
	calificacion_final DECIMAL(5,2) CHECK(calificacion_final >= 0),
	fecha_calificacion DATE DEFAULT (CURRENT_TIME())
);


-- CONSTRAINTS.
-- FOREIGN KEY.
ALTER TABLE materias ADD CONSTRAINT fk_id_profesor_materias
FOREIGN KEY (id_profesor) REFERENCES profesores (id_profesor);

ALTER TABLE inscripciones ADD CONSTRAINT fk_id_alumno_inscripciones
FOREIGN KEY (id_alumno) REFERENCES alumnos (id_alumno);

ALTER TABLE inscripciones ADD CONSTRAINT fk_id_materia_inscripciones
FOREIGN KEY (id_materia) REFERENCES materias (id_materia);

ALTER TABLE calificaciones ADD CONSTRAINT fk_id_inscripcion_calificaciones
FOREIGN KEY (id_inscripcion) REFERENCES inscripciones(id_inscripcion);


-- UNIQUE.
ALTER TABLE profesores ADD CONSTRAINT uni_correo UNIQUE(correo_electronico);

ALTER TABLE alumnos ADD CONSTRAINT uni_carnet UNIQUE(carnet_alumno);


-- PROCEDURE.
-- Procedimiento almacenado para la inserccion de datos de todas las tablas.

DELIMITER //
 
CREATE PROCEDURE AgregarDatos(
    IN p_carnet_alumno VARCHAR(10),
    IN p_nombre_alumno VARCHAR(50),
    IN p_apellido_alumno VARCHAR(50),
    IN p_edad_alumno INT,
    IN p_nombre_profesor VARCHAR(100),
    IN p_apellido_profesor VARCHAR(100),
    IN p_correo_profesor VARCHAR(100),
    IN p_nombre_materia VARCHAR(100),
    IN p_grupo_materia INT,
    IN p_cupos INT,
    IN p_fecha_inscripcion DATE,
    IN p_estado_inscripcion ENUM('Activo', 'Inactivo'),
    IN p_calificacion_final DECIMAL(5,2),
    IN p_fecha_calificacion DATE
)
BEGIN
    DECLARE v_id_alumno INT;
    DECLARE v_id_profesor INT;
    DECLARE v_id_materia INT;
    DECLARE v_id_inscripcion INT;
 
    INSERT INTO alumnos (carnet_alumno, nombre_alumno, apellido_alumno, edad_alumno)
    VALUES (p_carnet_alumno, p_nombre_alumno, p_apellido_alumno, p_edad_alumno);
    SET v_id_alumno = LAST_INSERT_ID();
 
    INSERT INTO profesores (nombre, apellido, correo_electronico)
    VALUES (p_nombre_profesor, p_apellido_profesor, p_correo_profesor);
    SET v_id_profesor = LAST_INSERT_ID();
 
    INSERT INTO materias (nombre_materia, grupo_materia, id_profesor, cupos)
    VALUES (p_nombre_materia, p_grupo_materia, v_id_profesor, p_cupos);
    SET v_id_materia = LAST_INSERT_ID();
 
    INSERT INTO inscripciones (id_alumno, id_materia, fecha_inscripcion, estado)
    VALUES (v_id_alumno, v_id_materia, p_fecha_inscripcion, p_estado_inscripcion);
    SET v_id_inscripcion = LAST_INSERT_ID();
 

    INSERT INTO calificaciones (id_inscripcion, calificacion_final, fecha_calificacion)
    VALUES (v_id_inscripcion, p_calificacion_final, p_fecha_calificacion);
END //

DELIMITER ;


-- TRIGGER.
DELIMITER //
CREATE TRIGGER after_inscripcion_trigger AFTER INSERT ON inscripciones
FOR EACH ROW
BEGIN
    UPDATE materias
    SET cupos = cupos - 1
    WHERE id_materia = NEW.id_materia AND cupos > 0;
END;
//
DELIMITER ;
 
 
-- INSERCIÓN DE DATOS
INSERT INTO profesores (id_profesor, nombre, apellido, correo_electronico) VALUES
    (1, 'Willfredo', 'Granados', 'Willfredo@gmail.com'),
    (2, 'Ricardo', 'Perez', 'Riacrdo@gmail.com'),
    (3, 'Carranza', 'Lopez', 'Carranza@gmail.com'),
    (4, 'Anderson', 'Perez', 'Anderson@gmail.com'),
    (5, 'Juan', 'Rodriguez', 'juanz@gmail.com'),
    (6, 'Maria', 'Gomez', 'maria@gmail.com'),
    (7, 'Pedro', 'Hernandez', 'pedro@gmail.com'),
    (8, 'Sofia', 'Diaz', 'sofia@gmail.com'),
    (9, 'Eduardo', 'Torres', 'eduardo@gmail.com'),
    (10, 'Isabel', 'Santos', 'isabel@gmail.com'),
    (11, 'Fernando', 'Ramirez', 'fernando@gmail.com'),
    (12, 'Gabriela', 'Castro', 'gabriela@gmail.com'),
    (13, 'Miguel', 'Fernandez', 'miguel@gmail.com'),
    (14, 'Alejandra', 'Rojas', 'alejandra@gmail.com'),
    (15, 'Diana', 'Gutierrez', 'diana@gmail.com');
 
 
INSERT INTO alumnos (id_alumno, carnet_alumno, nombre_alumno, apellido_alumno, edad_alumno) VALUES
    (1, '20220440', 'Dennis', 'Gonzalez', 20),
    (2, '20220235', 'Jose', 'Angel', 22),
    (3, '20220315', 'Anderson', 'Coto', 21),
    (4, '20220412', 'Cesar', 'Lopez', 23),
    (5, '20220505', 'Daniel', 'Perez', 24),
    (6, '20220620', 'Juan', 'Rodriguez', 25),
    (7, '20220703', 'Fernando', 'Gomez', 22),
    (8, '20220818', 'Axel', 'Hernandez', 19),
    (9, '20220901', 'Lenny', 'Diaz', 21),
    (10, '20221011', 'Eduardo', 'Torres', 24),
    (11, '20221130', 'Rebbeca', 'Lopez', 22),
    (12, '20221205', 'Fernando', 'Ramirez', 23),
    (13, '20221314', 'Gabriela', 'Castro', 20),
    (14, '20221425', 'Miguel', 'Fernandez', 25),
    (15, '20221508', 'Alejandra', 'Rojas', 22);
 
 
INSERT INTO materias (id_materia, nombre_materia, grupo_materia, id_profesor, cupos) VALUES
    (1, 'Matemáticas', 101, 1, 5),
    (2, 'Física', 102, 2, 8),
    (3, 'Química', 103, 3, 6),
    (4, 'Biología', 104, 4, 10),
    (5, 'Historia', 105, 5, 7),
    (6, 'Inglés', 106, 6, 12),
    (7, 'Arte', 107, 7, 9),
    (8, 'Educación Física', 108, 8, 15),
    (9, 'Programación', 109, 9, 11),
    (10, 'Literatura', 110, 10, 14),
    (11, 'Geografía', 111, 11, 8),
    (12, 'Economía', 112, 12, 13),
    (13, 'Psicología', 113, 13, 10),
    (14, 'Sociología', 114, 14, 16),
    (15, 'Filosofía', 115, 15, 10);
 
INSERT INTO inscripciones (id_inscripcion, id_alumno, id_materia, fecha_inscripcion, estado) VALUES
    (1, 1, 1, '2024-01-11', 'Activo'),
    (2, 2, 1, '2024-01-11', 'Inactivo'),
    (3, 3, 1, '2024-01-11', 'Activo'),
    (4, 4, 1, '2024-01-11', 'Inactivo'),
    (5, 5, 1, '2024-01-11', 'Activo'),
    (6, 6, 1, '2024-01-11', 'Activo'),
    (7, 7, 1, '2024-01-11', 'Inactivo'),
    (8, 8, 1, '2024-01-11', 'Activo'),
    (9, 9, 1, '2024-01-11', 'Activo'),
    (10, 10, 1, '2024-01-11', 'Inactivo'),
    (11, 11, 1, '2024-01-11', 'Activo'),
    (12, 12, 1, '2024-01-11', 'Activo'),
    (13, 13, 1, '2024-01-11', 'Inactivo'),
    (14, 14, 1, '2024-01-11', 'Activo'),
    (15, 15, 1, '2024-01-11', 'Inactivo');
 
 INSERT INTO calificaciones (id_calificacion, id_inscripcion, calificacion_final, fecha_calificacion) VALUES
    (1, 1, 8.5, '2024-02-28'),
    (2, 2, 7.2, '2024-02-28'),
    (3, 3, 9.7, '2024-02-28'),
    (4, 4, 6.3, '2024-02-28'),
    (5, 5, 8.9, '2024-02-28'),
    (6, 6, 7.6, '2024-02-28'),
    (7, 7, 9.2, '2024-02-28'),
    (8, 8, 8.7, '2024-02-28'),
    (9, 9, 8.4, '2024-02-28'),
    (10, 10, 7.9, '2024-02-28'),
    (11, 11, 9.1, '2024-02-28'),
    (12, 12, 7.8, '2024-02-28'),
    (13, 13, 8.4, '2024-02-28'),
    (14, 14, 8.3, '2024-02-28'),
    (15, 15, 9.6, '2024-02-28');
 
SELECT * FROM profesores;
SELECT * FROM alumnos; 
SELECT * FROM materias;
SELECT * FROM inscripciones;
SELECT * FROM calificaciones;