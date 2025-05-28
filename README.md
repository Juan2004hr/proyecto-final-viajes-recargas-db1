# Proyecto Final – Sistema de Viajes y Recargas

## 📌 Funcionalidades implementadas

1. Auditoría del estado de las tarjetas
2. Promociones aplicadas en recargas
3. Registro de dispositivos de validación
4. Mejora adicional: Registro de incidencias de viaje

## 📂 Instrucciones para ejecutar los scripts

1. Ejecutar `01_modificaciones.sql`
2. Ejecutar `02_creacion_tablas.sql`
3. Ejecutar `03_carga_datos.sql`
4. Ejecutar consultas por grupo:
   - `04_consultas_auditoria.sql`
   - `05_consultas_promociones.sql`
   - `06_consultas_dispositivos.sql`
   - `07_consultas_mejora_adicional.sql`

## 📐 Diagrama ER (Mermaid)

```mermaid
erDiagram
    TARJETAS ||--o{ AUDITORIA_TARJETAS : contiene
    RECARGAS }o--|| PROMOCIONES : usa
    VIAJES }o--|| DISPOSITIVOS_VALIDACION : valida
    VIAJES ||--o{ INCIDENCIAS : presenta
    INCIDENCIAS ||--|| TIPO_INCIDENCIA : clasificada_como


---

### ⬆️ 5. Sube tu proyecto a GitHub

#### 1. Inicia un repositorio local
```bash
git init
git add .
git commit -m "Proyecto final completo"
