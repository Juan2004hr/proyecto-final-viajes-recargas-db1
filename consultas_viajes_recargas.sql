-- ============================
-- TALLER FINAL - BASE DE DATOS
-- ============================

-- 1. AUDITORÍA DEL ESTADO DE TARJETAS

CREATE TABLE auditoria_tarjetas (
    id SERIAL PRIMARY KEY,
    tarjeta_id INT,
    estado_anterior TEXT,
    estado_nuevo TEXT,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO auditoria_tarjetas (tarjeta_id, estado_anterior, estado_nuevo, fecha_cambio) VALUES
(1, 'activa', 'bloqueada', '2024-06-15'),
(1, 'bloqueada', 'activa', '2024-08-20'),
(2, 'bloqueada', 'suspendida', '2024-12-05'),
(3, 'activa', 'bloqueada', '2025-01-10'),
(3, 'bloqueada', 'activa', '2025-02-01'),
(3, 'activa', 'suspendida', '2025-03-15'),
(4, 'suspendida', 'activa', '2025-04-10');

-- Consultas:
-- Cambios por mes del último año
SELECT TO_CHAR(fecha_cambio, 'YYYY-MM') AS mes, COUNT(*) AS total_cambios
FROM auditoria_tarjetas
WHERE fecha_cambio >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY mes
ORDER BY mes;

-- Top 5 tarjetas con más cambios
SELECT tarjeta_id, COUNT(*) AS total_cambios
FROM auditoria_tarjetas
GROUP BY tarjeta_id
ORDER BY total_cambios DESC
LIMIT 5;

-- 2. PROMOCIONES EN RECARGAS

CREATE TABLE promociones (
    promocion_id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    descripcion TEXT
);

ALTER TABLE recargas
ADD COLUMN promocion_id INTEGER,
ADD CONSTRAINT fk_promocion FOREIGN KEY (promocion_id) REFERENCES promociones(promocion_id);

INSERT INTO promociones (nombre, descripcion) VALUES
('BONO_2000', 'Recarga con bono de 2000 pesos'),
('DESCUENTO_10', 'Descuento del 10%'),
('2x1', 'Recarga dos por el precio de una'),
('BONUS_EXTRA', 'Bonus extra por temporada'),
('RECARGA_DOBLE', 'Recarga doble en días festivos');

-- Asignar promociones
UPDATE recargas SET promocion_id = 1 WHERE recarga_id % 5 = 0;
UPDATE recargas SET promocion_id = 2 WHERE recarga_id % 5 = 1;
UPDATE recargas SET promocion_id = 3 WHERE recarga_id % 5 = 2;
UPDATE recargas SET promocion_id = 4 WHERE recarga_id % 5 = 3;
UPDATE recargas SET promocion_id = 5 WHERE recarga_id % 5 = 4;

-- Consultas:
SELECT r.recarga_id, r.fecha, r.monto, p.nombre AS promocion, p.descripcion
FROM recargas r
JOIN promociones p ON r.promocion_id = p.promocion_id;

SELECT p.nombre AS promocion, SUM(r.monto) AS total_recargado
FROM recargas r
JOIN promociones p ON r.promocion_id = p.promocion_id
WHERE r.fecha >= CURRENT_DATE - INTERVAL '3 months'
GROUP BY p.nombre;

SELECT * FROM promociones WHERE LOWER(nombre) LIKE '%bonus%';

-- 3. DISPOSITIVOS DE VALIDACIÓN

CREATE TABLE dispositivos_validacion (
    dispositivo_id SERIAL PRIMARY KEY,
    tipo VARCHAR(50),
    descripcion TEXT
);

INSERT INTO dispositivos_validacion (tipo, descripcion) VALUES
('torniquete', 'Torniquete estación A'),
('torniquete', 'Torniquete estación B'),
('móvil', 'Validador móvil zona norte'),
('móvil', 'Validador móvil zona sur');

ALTER TABLE viajes
ADD COLUMN dispositivo_id INTEGER,
ADD CONSTRAINT fk_dispositivo FOREIGN KEY (dispositivo_id) REFERENCES dispositivos_validacion(dispositivo_id);

-- Asignación a viajes
UPDATE viajes SET dispositivo_id = 3 WHERE viaje_id BETWEEN 1 AND 3;
UPDATE viajes SET dispositivo_id = 4 WHERE viaje_id BETWEEN 4 AND 6;
UPDATE viajes SET dispositivo_id = 1 WHERE viaje_id BETWEEN 7 AND 8;
UPDATE viajes SET dispositivo_id = 2 WHERE viaje_id BETWEEN 9 AND 10;

-- Consultas:
SELECT * FROM viajes WHERE dispositivo_id IS NULL;

SELECT v.*
FROM viajes v
JOIN dispositivos_validacion d ON v.dispositivo_id = d.dispositivo_id
WHERE d.tipo ILIKE 'móvil' AND v.fecha BETWEEN '2025-04-01' AND '2025-04-30';

SELECT d.dispositivo_id, d.tipo, COUNT(*) AS total_validaciones
FROM viajes v
JOIN dispositivos_validacion d ON v.dispositivo_id = d.dispositivo_id
GROUP BY d.dispositivo_id, d.tipo
ORDER BY total_validaciones DESC
LIMIT 1;

-- 4. MEJORA: INCIDENCIAS EN VIAJES

CREATE TABLE tipo_incidencia (
    tipo_id SERIAL PRIMARY KEY,
    descripcion VARCHAR(100)
);

INSERT INTO tipo_incidencia (descripcion) VALUES
('Falla en validador'),
('Tarjeta no leída'),
('Comportamiento inadecuado'),
('Demora en validación'),
('Problemas con saldo');

CREATE TABLE incidencias (
    incidencia_id SERIAL PRIMARY KEY,
    viaje_id INT REFERENCES viajes(viaje_id),
    tipo_id INT REFERENCES tipo_incidencia(tipo_id),
    descripcion TEXT,
    fecha_reporte TIMESTAMP DEFAULT NOW()
);

-- Insertar incidencias aleatorias (simulación)
INSERT INTO incidencias (viaje_id, tipo_id, descripcion)
SELECT v.viaje_id, (RANDOM() * 5 + 1)::INT, 'Incidencia simulada para análisis'
FROM viajes v
WHERE RANDOM() < 0.3;

-- Consultas:
SELECT t.descripcion AS tipo_incidencia, COUNT(*) AS total
FROM incidencias i
JOIN tipo_incidencia t ON i.tipo_id = t.tipo_id
GROUP BY t.descripcion
ORDER BY total DESC;

SELECT v.viaje_id, d.descripcion AS dispositivo, t.descripcion AS tipo_incidencia
FROM incidencias i
JOIN viajes v ON i.viaje_id = v.viaje_id
JOIN tipo_incidencia t ON i.tipo_id = t.tipo_id
JOIN dispositivos_validacion d ON v.dispositivo_id = d.dispositivo_id;

SELECT i.incidencia_id, v.viaje_id, t.descripcion AS tipo, i.fecha_reporte
FROM incidencias i
JOIN viajes v ON i.viaje_id = v.viaje_id
JOIN tipo_incidencia t ON i.tipo_id = t.tipo_id
WHERE i.fecha_reporte >= CURRENT_DATE - INTERVAL '15 days';

