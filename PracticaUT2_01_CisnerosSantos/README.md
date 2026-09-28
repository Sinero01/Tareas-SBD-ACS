## Tarea 01:Diseña una base de datos documental con MongoDB

### Definir el problema y los accesos

#### 1. Escenario elegido y usuarios

- Escenario: Catálogo de comercio electrónico variable: productos, categorías, variantes, stock y reseñas. Justifica incrustación, referencias, índices y agregaciones.

- Usuarios: Cliente, Administrador

#### 2. Preguntas 
Consultas a realizar sobre la base de datos:

1. Cliente realiza una consulta sobre los productos que hay en una categoría

2. cliente o administrador realiza una consulta sobre las reseñas de un producto

3. Administrador realiza una  consulta sobre el stock de un producto

4. Cliente o administrador realiza una consulta de agrupar productos segun su puntuacion

5. Cliente realiza una consulta sobre las variantes de un producto 

#### 3. Los datos que se leen y escriben con mayor frecuencia.

Los datos a los que mas se accederan seran:
- Productos
- Categorías
- reseñas
- Stock

#### 4. Tabla que relacione las preguntas con las colecciones

| Pregunta | Coleccion  | Filtro     | Usuario       |
|----------|------------|------------|---------------|
| 1        | Categorias |            | Todos         |
| 2        | Productos  | producto   | Todos         |
| 3        | Productos  | stock      | Administrador |
| 4        | Productos  | Puntuacion | Todos         |
| 5        | Productos  | producto   | Todos         |
| 6        |            |            |               |






