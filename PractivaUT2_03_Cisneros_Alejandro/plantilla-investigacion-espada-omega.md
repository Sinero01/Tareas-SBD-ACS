# Informe Pericial de Investigación Forense · Caso 07-OMEGA

- **Estudiante / Analista:** [Alejandro Cisneros]
- **Fecha de emisión:** [2026-11-09]
- **Caso:** Sustracción de la Espada Omega en ÁgoraCraft
- **Fuente de auditoría:** Tabla `EscapeRoomMinecraft` (Amazon DynamoDB, región `us-east-1`)

---

## 1. Dictamen pericial

> Resume las conclusiones de tu investigación (máximo 120 palabras), identificando quién cometió el robo, cuándo ocurrió, cómo aprovechó el fallo del servidor y cuál fue el destino final del objeto.

- CreeperKing:retira la espada de la camara del tesoro sobre las 22:15:18 y se la transfiere a Shadowpixel entre las 22:17:40 y las 22:17:44 estos usuarios son la misma persona ya que poseen la misma id
- Aprocha el fallo del servidor:no hay notificación de salida de la zona de la sala del tesoro
- destino final: Esta oculata en la mina abandonada

---

## 2. Cronología forense probada

Registra al menos 5 eventos clave demostrados fehacientemente con consultas a DynamoDB (incluye marcas de tiempo ISO exactas al segundo):

| Hora exacta (ISO) | ID Cuenta | Alias | Acción / Evento | Zona | Objeto y detalles clave |
|---|---|---|---|---|---|
| `2026-11-02T22:09:00` | `P011` | AdminSol | `DEPOSITAR_OBJETO` | `CamaraTesoro` | `ESPADA_OMEGA` (custodia inicial) |
|`2026-11-02T22:15:18`|`P007`|CreeperKing |`RETIRAR_OBJETO` | `CamaraTesoro`|`ESPADA_OMEGA` (Posesión del objeto tras abrir el cofre)  |
|`2026-11-02T22:16:10`| `P007`|CreeperKing | `SALIR_ZONA`|`Castillo` |(Abandona el castillo sin que exista log de abandonar la sala del tesoro) |
|`2026-11-02T22:17:40` |`P007` |CreeperKing |`TRANSFERIR_OBJETO` |`BosqueOscuro` |`ESPADA_OMEGA`(Cambio de custodia) |
|`2026-11-02T22:17:44` |`P009` | ShadowPixel|`RECIBIR_OBJETO` |`BosqueOscuro` | `ESPADA_OMEGA`(Cambio de custodia)|
|`2026-11-02T22:20:10` |`P009`| ShadowPixel| `OCULTAR_OBJETO`|`MinaAbandonada`|`ESPADA_OMEGA`(Lugar final de la espada) |

---

## 3. Identificación de responsabilidades

- **Autor material del robo:** [Alias:CreeperKing e ID de cuenta:P007]
- **Cómplice y receptador:** [Alias:ShadowPixel e ID de cuenta:P009]
- **Momento exacto del robo físico:** [22:15:18]
- **Momento oficial de denuncia y alarma:** [22:25:00]
- **Última ubicación conocida del objeto:** [MinaAbandonada]

---

## 4. Distinción forense: Hechos observados vs. Inferencias

- **Hecho probado (con evidencia en registros):**  
  CreeperKing entra a la sala del Tesoro, abre le cofre y adquiere la espada omega luego sale de la zona del castillo y en la zona del bosque oscuro le trasnfiere la espada a ShadoPixel el cual esconde la espada en la mina abandonada: estos son datos registrados y mostrados en la tabla ya detallada anteriormente

- **Inferencia lógica razonable:**  
  CreeperKing   abandona la sala del tesoro ya que Abandona el castillo posteriormente a estar en esta sala
  Creeperking y ShadowPixel son la misma persona o dos personas que estan juntas dado que poseen la misma direccion ip()

- **Limitación técnica del dato:**  
  La direccion ip muestra la conexión del dispositivo en una red mientras que la dirección mac si es la que identifica cada dispositivo físico

---

## 5. Análisis de eficiencia y Big Data en DynamoDB

1. **Operación de tipo Scan:**
   - ¿Qué consulta de tu investigación fue un `Scan`? la consulta sobre todo lo ocurrido dentro de un periodo de tiempo
   - *Consulta PartiQL:* 
   ```
   SELECT * FROM "EscapeRoomMinecraft"
   WHERE fechaHora BETWEEN '2026-11-02T22:10:00' AND '2026-11-02T22:20:00'
   ```
   - ¿Por qué el motor ejecutó un Scan y qué impacto tendría este patrón en una tabla con 500 millones de registros?
   - [Tu explicación técnica]

2. **Operación sobre Global Secondary Index (GSI):**
   - ¿Qué consulta utilizó el índice `PorObjeto`?La consulta sobre el objeto robado.
   - *Consulta PartiQL:* `SELECT ...`
   - ¿Qué ventaja técnica aportó la proyección `ALL` frente a consultar la tabla base?
   - [Tu explicación técnica]
