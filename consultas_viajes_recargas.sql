1)Obtener la cantidad total de recargas que a realizado el usuario con id 5
SELECT COUNT(*) AS total_recargas
FROM recargas r
JOIN tarjetas t ON r.tarjeta_id = t.tarjeta_id
WHERE t.usuario_id = 5;

Obtener el monto gastado en recargas que ha realizado el usuario “Stiven Muñoz”
SELECT SUM(r.monto) AS total_gastado
FROM recargas r
JOIN tarjetas t ON r.tarjeta_id = t.tarjeta_id
JOIN usuarios u ON t.usuario_id = u.usuario_id
WHERE u.nombre = 'Stiven' AND u.apellido = 'Muñoz';

Puntos de recarga en Chapinero y San Cristóbal
SELECT l.nombre AS localidad, COUNT(*) AS total_puntos
FROM puntos_recarga p
JOIN localidades l ON p.localidad_id = l.localidad_id
WHERE l.nombre IN ('Chapinero', 'San Cristóbal')
GROUP BY l.nombre;

Estación con más ingresos en viajes (2023)
SELECT e.nombre AS estacion, SUM(t.valor) AS total_ingresos
FROM viajes v
JOIN tarifas t ON v.tarifa_id = t.tarifa_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
WHERE EXTRACT(YEAR FROM v.fecha) = 2023
GROUP BY e.nombre
ORDER BY total_ingresos DESC
LIMIT 1;

Localidad con más ingresos en viajes (2023)
SELECT l.nombre AS localidad, SUM(t.valor) AS ingresos
FROM viajes v
JOIN tarifas t ON v.tarifa_id = t.tarifa_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
JOIN localidades l ON e.localidad_id = l.localidad_id
WHERE EXTRACT(YEAR FROM v.fecha) = 2023
GROUP BY l.nombre
ORDER BY ingresos DESC
LIMIT 1;

Monto total de ingresos de la estación ‘Estación Sur Chapinero 1’
SELECT SUM(t.valor) AS ingresos
FROM viajes v
JOIN tarifas t ON v.tarifa_id = t.tarifa_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
WHERE e.nombre = 'Estación Sur Chapinero 1';

Viajes realizados por la usuaria Diana Díaz
SELECT COUNT(*) AS cantidad_viajes
FROM viajes v
JOIN tarjetas t ON v.tarjeta_id = t.tarjeta_id
JOIN usuarios u ON t.usuario_id = u.usuario_id
WHERE u.nombre = 'Diana' AND u.apellido = 'Díaz';

Veces que Luis Pinto ha abordado en Estación Sur El Virrey 2
SELECT COUNT(*) AS cantidad_abordajes
FROM viajes v
JOIN tarjetas t ON v.tarjeta_id = t.tarjeta_id
JOIN usuarios u ON t.usuario_id = u.usuario_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
WHERE u.nombre = 'Luis' AND u.apellido = 'Pinto'
AND e.nombre = 'Estación Sur El Virrey 2';

Dinero gastado por Walter Castaño en ‘Plaza Santa Isabel 6’
SELECT SUM(tar.valor) AS monto_gastado
FROM viajes v
JOIN tarjetas ta ON v.tarjeta_id = ta.tarjeta_id
JOIN usuarios u ON ta.usuario_id = u.usuario_id
JOIN tarifas tar ON v.tarifa_id = tar.tarifa_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
WHERE u.nombre = 'Walter' AND u.apellido = 'Castaño'
  AND e.nombre = 'Plaza Santa Isabel 6';

Top 5 usuarios que más han gastado en viajes
SELECT u.nombre, u.apellido, SUM(t.valor) AS total_gastado
FROM usuarios u
JOIN tarjetas ta ON u.usuario_id = ta.usuario_id
JOIN viajes v ON ta.tarjeta_id = v.tarjeta_id
JOIN tarifas t ON v.tarifa_id = t.tarifa_id
GROUP BY u.nombre, u.apellido
ORDER BY total_gastado DESC
LIMIT 5;

Top 5 usuarios que más gastaron en ‘Plaza Santa Isabel 6’
SELECT u.nombre, u.apellido, SUM(t.valor) AS total_gastado
FROM viajes v
JOIN tarjetas ta ON v.tarjeta_id = ta.tarjeta_id
JOIN usuarios u ON ta.usuario_id = u.usuario_id
JOIN tarifas t ON v.tarifa_id = t.tarifa_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
WHERE e.nombre = 'Plaza Santa Isabel 6'
GROUP BY u.nombre, u.apellido
ORDER BY total_gastado DESC
LIMIT 5;

Usuario con más viajes en 2023
SELECT u.nombre, u.apellido, COUNT(*) AS total_viajes
FROM viajes v
JOIN tarjetas t ON v.tarjeta_id = t.tarjeta_id
JOIN usuarios u ON t.usuario_id = u.usuario_id
WHERE EXTRACT(YEAR FROM v.fecha) = 2023
GROUP BY u.nombre, u.apellido
ORDER BY total_viajes DESC
LIMIT 1;

Viajes de usuarias en localidad Kennedy
SELECT COUNT(*) AS cantidad_viajes
FROM viajes v
JOIN tarjetas t ON v.tarjeta_id = t.tarjeta_id
JOIN usuarios u ON t.usuario_id = u.usuario_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
JOIN localidades l ON e.localidad_id = l.localidad_id
WHERE u.genero = 'femenino' AND l.nombre = 'Kennedy';

Usuario que más ha gastado en Kennedy (2023)
SELECT u.nombre, u.apellido, SUM(t.valor) AS total_gastado
FROM viajes v
JOIN tarjetas ta ON v.tarjeta_id = ta.tarjeta_id
JOIN usuarios u ON ta.usuario_id = u.usuario_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
JOIN localidades l ON e.localidad_id = l.localidad_id
JOIN tarifas t ON v.tarifa_id = t.tarifa_id
WHERE l.nombre = 'Kennedy' AND EXTRACT(YEAR FROM v.fecha) = 2023
GROUP BY u.nombre, u.apellido
ORDER BY total_gastado DESC
LIMIT 1;

5 localidades donde Mauricio García ha gastado más
SELECT l.nombre, SUM(t.valor) AS total_gastado
FROM viajes v
JOIN tarjetas ta ON v.tarjeta_id = ta.tarjeta_id
JOIN usuarios u ON ta.usuario_id = u.usuario_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
JOIN localidades l ON e.localidad_id = l.localidad_id
JOIN tarifas t ON v.tarifa_id = t.tarifa_id
WHERE u.nombre = 'Mauricio' AND u.apellido = 'García'
GROUP BY l.nombre
ORDER BY total_gastado DESC
LIMIT 5;

Usuarios que han gastado más de 25.000 en ‘Plaza Santa Isabel 6’
SELECT u.nombre, u.apellido, SUM(t.valor) AS total_gastado
FROM viajes v
JOIN tarjetas ta ON v.tarjeta_id = ta.tarjeta_id
JOIN usuarios u ON ta.usuario_id = u.usuario_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
JOIN tarifas t ON v.tarifa_id = t.tarifa_id
WHERE e.nombre = 'Plaza Santa Isabel 6'
GROUP BY u.nombre, u.apellido
HAVING SUM(t.valor) > 25000;

Estación con más ingresos en 2023
SELECT e.nombre, SUM(t.valor) AS total_ingresos
FROM viajes v
JOIN tarifas t ON v.tarifa_id = t.tarifa_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
WHERE EXTRACT(YEAR FROM v.fecha) = 2023
GROUP BY e.nombre
ORDER BY total_ingresos DESC
LIMIT 1;

Localidad con más ingresos en diciembre 2023
SELECT l.nombre, SUM(t.valor) AS total_ingresos
FROM viajes v
JOIN tarifas t ON v.tarifa_id = t.tarifa_id
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
JOIN localidades l ON e.localidad_id = l.localidad_id
WHERE EXTRACT(YEAR FROM v.fecha) = 2023 AND EXTRACT(MONTH FROM v.fecha) = 12
GROUP BY l.nombre
ORDER BY total_ingresos DESC
LIMIT 1;

Viajes en la localidad de Kennedy
SELECT COUNT(*) AS total_viajes
FROM viajes v
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
JOIN localidades l ON e.localidad_id = l.localidad_id
WHERE l.nombre = 'Kennedy';

5 localidades con más viajes en 2023
SELECT l.nombre, COUNT(*) AS total_viajes
FROM viajes v
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
JOIN localidades l ON e.localidad_id = l.localidad_id
WHERE EXTRACT(YEAR FROM v.fecha) = 2023
GROUP BY l.nombre
ORDER BY total_viajes DESC
LIMIT 5;

Año con más viajes registrados
SELECT EXTRACT(YEAR FROM fecha) AS anio, COUNT(*) AS total_viajes
FROM viajes
GROUP BY anio
ORDER BY total_viajes DESC
LIMIT 1;

Día con más viajes en Los Mártires
SELECT v.fecha, COUNT(*) AS total_viajes
FROM viajes v
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
JOIN localidades l ON e.localidad_id = l.localidad_id
WHERE l.nombre = 'Los Mártires'
GROUP BY v.fecha
ORDER BY total_viajes DESC
LIMIT 1;

Mes con más viajes en Los Mártires en 2023
SELECT EXTRACT(MONTH FROM v.fecha) AS mes, COUNT(*) AS total_viajes
FROM viajes v
JOIN estaciones e ON v.estacion_abordaje_id = e.estacion_id
JOIN localidades l ON e.localidad_id = l.localidad_id
WHERE l.nombre = 'Los Mártires' AND EXTRACT(YEAR FROM v.fecha) = 2023
GROUP BY mes
ORDER BY total_viajes DESC
LIMIT 1;