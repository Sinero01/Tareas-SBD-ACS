## 5  Comparación técnica, seguridad y copias

### 5.1 Comparativa técnica

| Criterio                        | SQL Relacional                                                   | Neo4j (Cypher)                                               |
|---------------------------------|------------------------------------------------------------------|--------------------------------------------------------------|
| Estructuras intermedias         | Obligatorio crear 2 tablas puente para relaciones M:N            | Innecesarias; las aristas conectan nodos directamente        |
| Operaciones de cruce            | 6 JOIN (4 de navegación + 2 de resolución de atributos/negación) | 0 JOIN (navegación por punteros directos)                    |
| Verificación de exclusión       | LEFT JOIN ... WHERE sa.id IS NULL (genera matriz temporal)       | NOT (ad)-[:SOLICITA_ADOPCION]->(a) (comprueba puntero local) |
| Dependencia del tamaño de la BD | Se degrada al crecer las tablas de relaciones                    | Constante; depende solo del subgrafo recorrido               |

### 5.2 opias de seguridad y restauración

``` js
// Generar el archivo binario comprimido (.dump)
neo4j-admin database dump neo4j --to-path=/var/backups/neo4j/
//Cargar el volcado sobreescribiendo el estado actual
neo4j-admin database load neo4j --from-path=/var/backups/neo4j/ --overwrite-destination=true

```

### 5.3 Seguridad y permisos

Para garantizar el principio de mínimo privilegio (PoLP) y cumplir con la normativa de protección de datos (RGPD), se establecen dos perfiles de acceso bien diferenciados en Neo4j:

- admin (Administrador): Control operativo total sobre el motor de base de datos, administración de esquema (índices y constraints), creación de usuarios y operaciones de mantenimiento.

- app_mobile_reader (Usuario de consulta móvil): Rol de solo lectura restringido para la API pública o aplicación móvil, limitado estrictamente a los nodos y propiedades del catálogo visible, sin acceso a datos personales de adoptantes ni diagnósticos confidenciales.

### 5.4 Cuándo NO usar Neo4j

- Analítica masiva y reporting contable (OLAP)

  - Caso: Calcular totales, medias o balances financieros sobre millones de facturas y gastos veterinarios.

  - Por qué falla: Neo4j optimiza la navegación entre nodos locales, no el escaneo secuencial de millones de registros planos (sum, avg), volviéndose lento y consumiendo mucha memoria.

  - Alternativa: Bases de datos columnares (ClickHouse, BigQuery) o relacionales (PostgreSQL), diseñadas para comprimir y agregar columnas completas a alta velocidad.

- Documentos jerárquicos y fichas no estructuradas

  - Caso: Historiales veterinarios completos con textos libres, analíticas de sangre con parámetros variables y recetas en formato JSON.

  - Por qué falla: En grafos obliga a fragmentar en miles de noditos innecesarios (creando problemas de supernodos) o a guardar texto/JSON ciego dentro de propiedades sin poder indexar bien.

  - Alternativa: Bases de datos documentales (MongoDB), que guardan y devuelven todo el expediente anidado en una sola lectura por ID.
