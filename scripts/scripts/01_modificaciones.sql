-- Script de modificaciones a tablas existentes
| Tabla                     | Propósito                                                | Campos clave                           |
| ------------------------- | -------------------------------------------------------- | -------------------------------------- |
| `auditoria_tarjetas`      | Historial de cambios de estado en tarjetas               | `id`, `tarjeta_id`                     |
| `promociones`             | Registro de promociones aplicadas a recargas             | `promocion_id`                         |
| `dispositivos_validacion` | Tipos de dispositivos utilizados en validaciones         | `dispositivo_id`                       |
| `tipo_incidencia`         | Tipos comunes de problemas durante viajes                | `tipo_id`                              |
| `incidencias`             | Registro de fallas o situaciones anómalas durante viajes | `incidencia_id`, `viaje_id`, `tipo_id` |
| `viajes` (modificada)     | Se agregó `dispositivo_id`                               |                                        |
| `recargas` (modificada)   | Se agregó `promocion_id`                                 |                                        |
