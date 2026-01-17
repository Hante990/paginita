-- Crear base de datos
CREATE DATABASE IF NOT EXISTS sistema_reportes;
USE sistema_reportes;

-- Tabla de reportes
CREATE TABLE IF NOT EXISTS reportes (
    id INT(11) NOT NULL AUTO_INCREMENT,
    color VARCHAR(20) NOT NULL,
    descripcion TEXT NOT NULL,
    direccion VARCHAR(255) DEFAULT NULL,
    latitud DECIMAL(10, 8) NOT NULL,
    longitud DECIMAL(11, 8) NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    palabras INT(11) NOT NULL,
    estado ENUM('pendiente', 'en_proceso', 'resuelto') DEFAULT 'pendiente',
    prioridad ENUM('baja', 'media', 'alta') DEFAULT 'media',
    PRIMARY KEY (id),
    INDEX idx_fecha (fecha_creacion),
    INDEX idx_estado (estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla para seguimiento de reportes
CREATE TABLE IF NOT EXISTS seguimiento_reportes (
    id INT(11) NOT NULL AUTO_INCREMENT,
    reporte_id INT(11) NOT NULL,
    accion VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (reporte_id) REFERENCES reportes(id) ON DELETE CASCADE,
    INDEX idx_reporte (reporte_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar datos de ejemplo
INSERT INTO reportes (color, descripcion, direccion, latitud, longitud, palabras, prioridad) VALUES
('azul', 'Fuga de agua en la tubería principal de la calle Reforma. El agua lleva fluyendo más de 24 horas y ya está afectando la estructura de la banqueta. Vecinos reportan que el flujo es constante y parece venir de una ruptura en la tubería de 6 pulgadas que abastece a varios edificios de la zona. La situación se ha vuelto crítica ya que el agua está llegando hasta la calzada, provocando encharcamientos peligrosos para los vehículos y peatones. Se requiere intervención urgente del departamento de aguas de la ciudad para evitar daños mayores a la infraestructura y posibles accidentes.', 'Av. Reforma 123, Ciudad de México', 19.43260770, -99.13320800, 120, 'alta'),
('amarillo', 'Acumulación excesiva de basura en el contenedor de la esquina. Los residuos se están desbordando y generando malos olores, además de atraer fauna nociva. La situación lleva así más de una semana y los vecinos estamos preocupados por las condiciones sanitarias. Se observa proliferación de moscas, roedores y otros vectores de enfermedades. El contenedor está completamente lleno y la basura se está dispersando por la calle debido al viento y a los animales. Urge que el servicio de recolección pase con mayor frecuencia o que se instalen contenedores adicionales.', 'Calle Insurgentes 456, Ciudad de México', 19.42604570, -99.16188070, 95, 'media');