//consulta basica 
MERGE (a:Animal {id: "A-05"})
ON CREATE SET 
    a.nombre = "Kira",
    a.estado = "DISPONIBLE",
    a.nivel_energia = "MEDIO",
    a.fecha_rescate = date("2026-03-30"),
    a.necesidades_especiales = false,
    a.edad_aprox = 2
ON MATCH SET 
    a.estado = "DISPONIBLE",
    a.nivel_energia = "MEDIO"

WITH a
MATCH (e:Especie {nombre: "Perro"})
MATCH (p:Protectora {id: "PROT-01"})

MERGE (a)-[:PERTENECE_A]->(e)
MERGE (a)-[r:ALOJADO_EN]->(p)
ON CREATE SET 
    r.desde = date("2026-03-30")

// 1 salto
MATCH (p:Protectora {id: "PROT-01"})<-[r:ALOJADO_EN]-(a:Animal)
RETURN 
    p.nombre AS protectora,
    a.id AS animal_id,
    a.nombre AS animal_nombre,
    a.estado AS estado_actual,
    a.nivel_energia AS nivel_energia,
    r.desde AS fecha_ingreso
ORDER BY a.nombre ASC;

//varios saltos

MATCH (ad:Adoptante)-[:CONVIVE_CON]->(e:Especie)<-[c:COMPATIBLE_CON]-(a:Animal)
WHERE a.estado = "DISPONIBLE"
  AND NOT (ad)-[:SOLICITA_ADOPCION]->(a)
OPTIONAL MATCH (a)-[:ALOJADO_EN]->(p:Protectora)
RETURN 
    ad.nombre AS adoptante,
    e.nombre AS especie_en_casa,
    a.id AS animal_id,
    a.nombre AS animal_recomendado,
    c.grado AS grado_compatibilidad,
    p.nombre AS protectora
ORDER BY ad.nombre ASC;

//Recomendacion por afinidad


MATCH (ad:Adoptante {id: "USR-01"})-[:SOLICITA_ADOPCION]->(a1:Animal)
MATCH (a1)<-[:SUPERVISA]-(v:Veterinaria)-[:SUPERVISA]->(a2:Animal)
WHERE a1 <> a2 
  AND a2.estado = "DISPONIBLE"
RETURN 
    ad.nombre AS adoptante,
    a1.nombre AS animal_de_interes,
    v.nombre AS veterinaria_en_comun,
    a2.id AS animal_recomendado_id,
    a2.nombre AS animal_recomendado,
    a2.estado AS estado,
    a2.nivel_energia AS energia;

// Camino mas corto

MATCH (origen:Protectora {id: "PROT-01"}), (destino:Protectora {id: "PROT-04"})
MATCH camino = shortestPath((origen)-[:COLABORA_CON*]-(destino))
RETURN 
    [n IN nodes(camino) | n.nombre] AS ruta_colaboracion,
    length(camino) AS saltos_grados_separacion;