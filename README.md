# Proyecto Final - Sistema de Viajes y Recargas (Base de Datos)

## Descripción general

Este proyecto implementa mejoras funcionales sobre una base de datos existente de viajes y recargas. Las mejoras incluyen:

1. Auditoría de cambios de estado de tarjetas.
2. Registro de promociones en recargas.
3. Registro de dispositivos de validación.
4. Mejora adicional: [describir aquí].

---

## Estructura de scripts

| Archivo | Propósito |
|--------|-----------|
| `01_modificaciones.sql` | Cambios en tablas existentes. |
| `02_creacion_tablas.sql` | Nuevas tablas para las mejoras. |
| `03_carga_datos.sql` | Inserción de datos para pruebas (100 registros). |
| `04_consultas.sql` | Consultas SQL de validación. |

---

## Instrucciones de uso

1. Ejecutar `01_modificaciones.sql`
2. Ejecutar `02_creacion_tablas.sql`
3. Ejecutar `03_carga_datos.sql`
4. Ejecutar `04_consultas.sql` para validar

---

## Diagramas ER (código Mermaid)

```mermaid
erDiagram
    TARJETA ||--o{ ESTADO_TARJETA : tiene
    TARJETA {
        int id
        string numero
    }
    ESTADO_TARJETA {
        int id
        date fecha
        string estado
    }
