
# Tarea 01:Diseña una base de datos documental con MongoDB

## 1.Definir el problema y los accesos

### 1.1. Escenario elegido y usuarios

- Escenario: Catálogo de comercio electrónico variable: productos, categorías, variantes, stock y reseñas. Justifica incrustación, referencias, índices y agregaciones.

- Usuarios: Cliente, Administrador

### 1.2. Preguntas

Consultas a realizar sobre la base de datos:

1. ¿Que productos de la categoria "electronica" tienen un precio inferior a 100 €?

2. ¿Productos que coiciden con la palabra "televisión" en el nombre?

3. ¿Qué productos estan casi agotados?

4. ¿Que reseñas tienen un valoración positiva?

5. ¿Cuales son las variantes de un producto?

6. ¿Cuales son los productos disponibles de una marca?

### 1.3. Los datos que se leen y escriben con mayor frecuencia

Los datos a los que mas se accederan seran:

- Productos
- Categorías

Los datos a los que mas se escribira seran:

- Reseñas
- Nombre de producto

### 1.4. Tabla que relacione las preguntas con las colecciones

| Pregunta | Coleccion  | Filtro                | Acceso        |
|----------|------------|-----------------------|---------------|
| 1        | Productos  | Categoria/precio      | Cliente       |
| 2        | Productos  | marca                 | Cliente       |
| 3        | Productos  | stock                 | Administrador |
| 4        | reviews    | Puntuacion            | Todos         |
| 5        | Productos  | Idobjeto/variante     | Todos         |
| 6        | Productos  | Marca                 | Cliente       |

#### Índices

Para las pregunta 1 {catgeoria,precio y estado}
Para la pregunta 2 {nombre}
Para la pregunta 3 {stock}
Para la pregunta 4 {productoID y rating}
Para la pregunta 6 {marca}

### 1.5. Requisitos de seguridad

Seguridad: Ciframos todo el tráfico entre la aplicación y el clúster de Atlas usando TLS/SSL para evitar intercepciones, y forzamos contraseñas seguras para la autenticación de usuarios.

Privacidad (RGPD): Al ser información sensible, datos personales como emails y direcciones de entrega se anonimizan obligatoriamente antes de exportar la base de datos a entornos de pruebas o desarrollo.

Disponibilidad: Nos apoyamos en la arquitectura de Replica Set de MongoDB Atlas; si un nodo falla, el sistema conmuta automáticamente a una réplica para que la tienda siga operativa sin perder ventas.

Escalabilidad: Diseñamos el modelo de datos y las relaciones de forma preventiva para optimizar el espacio y no acercarnos nunca al límite de 16 MB por documento en MongoDB.
