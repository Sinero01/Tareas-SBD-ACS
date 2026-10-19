# Tarea 02 - Cisneros Alejandro

## 1 Definir el problema

### 1.1 Escenario elegido

- Escenario: Red de adopción de mascotas: Animales rescatados, protectoras, casas de acogida y adoptantes. Resuelve la asignación más compatible según espacio y convivencia

-Participantes:las protectoras que rescatan los animales y los usuarios que los acogen de las protectoras o los llevan a estas.

### 1.2 Preguntas

- 1 ¿Cual es el centro de acogida más cercano?

- 2 ¿Que animales se pueden adoptar?

- 3 ¿Hay hueco para acoger más animaes?

- 4 ¿Cual es el centro de acogida con mayor cantidad de animales?

- 5 ¿Que enfermedades o lesiones poseen los animales?

- 6 ¿Requisitos para adoptar un animal?

### 1.3  Datos y recorridos que se sonsultaran con mayor frecuencia frente a los que se registran puntualmente

-Lecturas masivas: La informacion de los animales, junto con la informacion de sus protectoras y los recorridos de un usuario siga a x centros de acogida y este sugiera aniamles propios ara adoptar.

-Registros puntuales: Un usuario al registrarse en la aplicacion, y seguir a un centro de acogida, registro de un animal a un centro de acogida.

### 1.4  Requisitos de seguridad, disponibilidad ,privacidad de los datos y prevision de crecimiento de la red

1. Seguridad:Conexiones cifradas mediante TLS.

2. Privacidad:Los usuarios pueden configurar su perfil.AL darse de baja se eliminan su preferencias y datos personales.

3. Disponibilidad: Clúster de Neo4j en alta disponibilidad con replicación Raft, garantizando que el streaming no sufra interrupciones si cae una instancia de lectura.

## 2 Diseñar el grafo de nodos y relaciones

### 2.1 Etiquetas de los nodos

1. Animal: Nombre, raza. color, sexo, edad, salud,
2. Protectora: Nombre, localizacion, animales, huecos totales.
3. Adoptante: Nombre, localizacion, preferencia, Especificaciones de vivienda o zona de adopcion.

### 2.2 tipos de relaciones

### 2.3 justificacion

### 2.4 Estrategia para identidicadores único y tipo de datos compatibles con Cypher

### 2.5 Limites y riesgos del modelo
