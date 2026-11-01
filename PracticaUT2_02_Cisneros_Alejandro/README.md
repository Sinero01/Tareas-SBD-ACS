# Tarea 02 - Cisneros Alejandro

## 1 Definir el problema

### 1.1 Escenario elegido

- Escenario: Red de adopción de mascotas: Animales rescatados, protectoras, casas de acogida y adoptantes. Resuelve la asignación más compatible según espacio y convivencia

- Participantes:

  - Adoptante: Usuario que busca un animal para adoptar

  - Protectora: Lugar Temporal donde se encuentra el animal mientras encuentra una adopción

  - Veterinario: Profesional que certifica el estado de salud del animal y la compatibilidad de convivencia del animal con otros animales.

  - Motor de Recomendación: Analiza los adoptantes y recomienda animales segun su preferencia, compatibilidad de convivencia y cercania a la protectora.

### 1.2 Preguntas

1. ¿Qué animales disponibles para adopción son compatibles con las especies de animales que ya conviven en el hogar del adoptante?

2. ¿Qué protectoras tienen capacidad disponible?

3. ¿Cual es el historial de traslados de un animal(Por que protectoras ha pasado)?

4. ¿Cuáles son los animales compatibles con un adoptante que llevan más tiempo esperando adopción?

5. ¿Qué enfermedades, lesiones o tratamientos tienen registrados los animales y qué veterinario los certificó??

6. ¿Cual es la protectora más cercana con capacidad disponible para derivar o traladar un animal?

### 1.3  Datos y recorridos que se sonsultaran con mayor frecuencia frente a los que se registran puntualmente

- Lecturas masivas:

  - Exploración de datos animales y protectoras.

  - Sugerencias y seguimiento de centros.
  
  - Comprobaciones de compatibilidad.

- Registros puntuales:

  - Registro de nuevos usuarios.

  - Acciones de seguimiento.

  - Alta de animal rescatado y traslado.

### 1.4  Requisitos de seguridad, disponibilidad ,privacidad de los datos y prevision de crecimiento de la red

1. Seguridad:Conexiones cifradas mediante TLS.

2. Privacidad:Los usuarios pueden configurar su perfil. Al darse de baja se eliminan su preferencias y datos personales.

3. Disponibilidad: Clúster de Neo4j en alta disponibilidad con replicación Raft, garantizando que el streaming no sufra interrupciones si cae una instancia de lectura.

4. Crecimiento escalable: Escalabilidad proyectada para decenas de miles de animales y adoptantes anuales. Dado que el historial de traslados de un animal es lineal y corto (pocos saltos), las lecturas y caminos se mantienen en milisegundos sin degradación de memoria.
