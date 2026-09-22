# Tareas-SBD
Tareas de Sistemas de Big Data
### Alejandro Cisneros Santos

## Práctica 01: Análisis de una red de sensores de calidad del aire

### Actividad 1 Comprender el problema

- **¿Quién utilizará estos datos?**
El ayuntamiento
- **¿Que decisiones se pueden tomar con ellos?** 
Se Pueden tomar decisiones para la seguridad de la zona donde esten ubicados los sensores, ya sean por riegos de incendios o por riegos de inundaciones. Y saber a la saber la hora del incidente y la ubicación de este
- **¿Que diferencia hay entre una alerta inmediata y un informe histórico?** 
Un informe histórico se puede utilizar para recolectar datos de riesgo o si existe un posible fallo en el sensor, mientras que una alerta inmediata se usa para informar en que sensor produjo un incidente

### Actividad 2 cobertura y calidad
- **Identifica dos problemas de calidad y explica sus consecuencias.**
1. Huecos temporales, si un sensor esta x tiempo sin dar señales puede que en ese periodo de tiempo ocurra un icidente y hasta que no vuelva a dar señales en la zona de dicho sensor ,la asistencia necesaria llegue tarde 

2. Unidades incorrectas, al no tener la unidad de medición correcta, puede probar fallos enviando alarmas cuando no ocurre ningun incidento o que no envie ninguna alarma cuando este ocurriendo un incidente

- **Indica qué distrito necesita mayor atención y justifica tu respuesta.**
Pueden ser tanto el distrito D6 como el D4, el D6 es un distrito sin vigilancia actualmente y un terreno con mucha superficie y el D4 es un distrito con mucha población y a su vez  mucha actividad registrada dentro de este

- **Elige una anomalía y explica si la corregirías, la marcarías como dudosa o la excluirías.**
EL hecho de que haya valores extremos y esten fuera de de rango fisico, lo revisaría o lo marcaria como dudoso y si este es un valor que es imposible que lo marque lo excluiría

### Actividad 3 Comparar arquitecturas

<table>
  <tr>
    <th>Criterio</th>
    <th>Batch</th>
    <th>Streaming</th>
  </tr>
  <tr>
    <td>Rapidez para generar alertas</td>
    <td>Minutos horas</td>
    <td>segundos pocos minutos</td>
  </tr>
  <tr>
    <td>Coste y complejidad</td>
    <td>Menores</td>
    <td>Mayores</td>
  </tr>
  <tr>
    <td>Informes históricos</td>
    <td>Muy adecuados</td>
    <td>adecuados pero complejos</td>
    </tr>
    <tr>
      <td>Picos de datos</td>
      <td>datos por lotes</td>
      <td>al llegar</td>
    </tr>
</table>

#### indica qué alternativa usarías para las alertas y cuál para los informes históricos.

- Para las  alertas usaría streaming, ya que es de mayor velociad y una alerta necesitas que sea de manera inmediata.

- Para los informes historicos usaría batch dado que tienen una menor compleidad y no es algo que necesites generar al momento.

### Actividad 4 Elaborar una recomendación
Dentro de las zonas que ya mencioné anteriormente como las zonas que necesitan mayor atención, podemos priorizar la zona D4 dado que es un distrito con una alta actividad y  una población en una zona no tan grande.

#### Recomendaciones:
Bajar la actividad automovilista de coches de altas emisiones en la zona D4 durante las horas de mayor actividad. Promocionar el uso de bicicletas y transporte público en lugar de coche personal.

Razones para dichas recomendaciones:
- alta poblacion y trafico
- Zona de actividad indutrial

El problema seguira existiendo dado a que seguira siendo una zona de alta contaminación, pero se con las recomendiones se podría a reducir dicha contaminación.

como medida de privacidad, se podría excluir el añadir las cordenadas de en el historico para que no se sepan con exactitud las rutas de los habitantes de la zona.