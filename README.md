# 🧾 Taller Final – Sistema de Gestión de Validaciones y Recargas

Este proyecto implementa mejoras estructurales en una base de datos para soportar nuevas funcionalidades: auditoría de tarjetas, gestión de promociones, trazabilidad de validaciones, e incidencias durante viajes.

---

## 📌 1. Funcionalidades implementadas

- **Auditoría del estado de las tarjetas:** registro de todos los cambios de estado (activa, bloqueada, etc.).
- **Promociones aplicadas en recargas:** integración de promociones (bonos y descuentos) en las recargas.
- **Registro de dispositivos de validación:** identificación del dispositivo usado para validar cada viaje.
- **Gestión de incidencias en viajes:** registro de problemas durante viajes para análisis operativo.

---

## ▶️ 2. Instrucciones para ejecutar los scripts

Todos los scripts están en la carpeta `scripts/`. Ejecútalos en este orden:

1. `01_create_tables.sql` – Creación de nuevas tablas:
   - `auditoria_tarjetas`, `promociones`, `dispositivos_validacion`, `tipo_incidencia`, `incidencias`.

2. `02_alter_tables.sql` – Modificación de tablas existentes:
   - Agregar columnas y claves foráneas a `viajes` y `recargas`.

3. `03_insert_data.sql` – Inserción de datos de ejemplo en todas las tablas nuevas.

4. `04_queries.sql` – Consultas para auditoría, estadísticas y análisis.

---

## 📊 3. Diagramas ER (Mermaid)

```mermaid
erDiagram
    TARJETAS ||--o{ AUDITORIA_TARJETAS : cambia_estado
    AUDITORIA_TARJETAS {
        int id
        int tarjeta_id
        string estado_anterior
        string estado_nuevo
        timestamp fecha_cambio
    }

    RECARGAS }o--|| PROMOCIONES : usa
    PROMOCIONES {
        int promocion_id
        string nombre
        string descripcion
    }

    VIAJES }o--|| DISPOSITIVOS_VALIDACION : validado_por
    DISPOSITIVOS_VALIDACION {
        int dispositivo_id
        string tipo
        string descripcion
    }

    INCIDENCIAS }o--|| VIAJES : ocurre_en
    INCIDENCIAS }o--|| TIPO_INCIDENCIA : es_de_tipo
    TIPO_INCIDENCIA {
        int tipo_id
        string descripcion
    }







