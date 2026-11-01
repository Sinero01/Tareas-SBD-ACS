// 1. Especies 
MERGE (e1:Especie {nombre: "Perro"})
MERGE (e2:Especie {nombre: "Gato"})
MERGE (e3:Especie {nombre: "Conejo"});

// 2. Protectoras 
MERGE (p1:Protectora {id: "PROT-01"})
ON CREATE SET 
    p1.nombre = "Huellas del Valle",
    p1.capacidad_maxima = 30,
    p1.telefono_contacto = "600111222",
    p1.codigo_postal = "10001",
    p1.admite_cuidados_medicos = true;

MERGE (p2:Protectora {id: "PROT-02"})
ON CREATE SET 
    p2.nombre = "Refugio San Roque",
    p2.capacidad_maxima = 20,
    p2.telefono_contacto = "600222333",
    p2.codigo_postal = "10003",
    p2.admite_cuidados_medicos = false;

MERGE (p3:Protectora {id: "PROT-03"})
ON CREATE SET 
    p3.nombre = "Acogidas Extremadura",
    p3.capacidad_maxima = 15,
    p3.telefono_contacto = "600333444",
    p3.codigo_postal = "10600",
    p3.admite_cuidados_medicos = true;

MERGE (p4:Protectora {id: "PROT-04"})
ON CREATE SET 
    p4.nombre = "Santuario La Serena",
    p4.capacidad_maxima = 25,
    p4.telefono_contacto = "600444555",
    p4.codigo_postal = "06400",
    p4.admite_cuidados_medicos = false;

// 3. Veterinarias
MERGE (v1:Veterinaria {id: "VET-01"})
ON CREATE SET 
    v1.nombre = "Clínica Veterinaria San Antón",
    v1.especialidad = "Medicina General";

MERGE (v2:Veterinaria {id: "VET-02"})
ON CREATE SET 
    v2.nombre = "Centro Etológico Canino y Felino",
    v2.especialidad = "Etología";

// 4. Animales rescatados
MERGE (a1:Animal {id: "A-01"})
ON CREATE SET 
    a1.nombre = "Rocky",
    a1.estado = "DISPONIBLE",
    a1.nivel_energia = "MEDIO",
    a1.fecha_rescate = date("2026-01-15"),
    a1.necesidades_especiales = false,
    a1.edad_aprox = 3;

MERGE (a2:Animal {id: "A-02"})
ON CREATE SET 
    a2.nombre = "Luna",
    a2.estado = "DISPONIBLE",
    a2.nivel_energia = "BAJO",
    a2.fecha_rescate = date("2026-02-10"),
    a2.necesidades_especiales = true,
    a2.edad_aprox = 5;

MERGE (a3:Animal {id: "A-03"})
ON CREATE SET 
    a3.nombre = "Thor",
    a3.estado = "EN_ACOGIDA",
    a3.nivel_energia = "ALTO",
    a3.fecha_rescate = date("2025-11-05"),
    a3.necesidades_especiales = false,
    a3.edad_aprox = 1;

MERGE (a4:Animal {id: "A-04"})
ON CREATE SET 
    a4.nombre = "Mimi",
    a4.estado = "ADOPTADO",
    a4.nivel_energia = "MEDIO",
    a4.fecha_rescate = date("2025-08-20"),
    a4.necesidades_especiales = false,
    a4.edad_aprox = 2;

// 5. Adoptantes
MERGE (ad1:Adoptante {id: "USR-01"})
ON CREATE SET 
    ad1.nombre = "Carlos Gómez",
    ad1.tipo_vivienda = "PISO",
    ad1.horas_solo = 4,
    ad1.experiencia_previa = true,
    ad1.codigo_postal = "10001";

MERGE (ad2:Adoptante {id: "USR-02"})
ON CREATE SET 
    ad2.nombre = "Elena Rivas",
    ad2.tipo_vivienda = "CASA_CON_JARDIN",
    ad2.horas_solo = 2,
    ad2.experiencia_previa = false,
    ad2.codigo_postal = "10003";
MERGE (ad3:Adoptante {id: "USR-03"})
ON CREATE SET 
    ad3.nombre = "Marcos Peña",
    ad3.tipo_vivienda = "CHALET",
    ad3.horas_solo = 1,
    ad3.experiencia_previa = true,
    ad3.codigo_postal = "06400";

// Pertinencia de especie
MATCH (a:Animal {id: "A-01"}), (e:Especie {nombre: "Perro"})
MERGE (a)-[:PERTENECE_A]->(e);

MATCH (a:Animal {id: "A-02"}), (e:Especie {nombre: "Gato"})
MERGE (a)-[:PERTENECE_A]->(e);

MATCH (a:Animal {id: "A-03"}), (e:Especie {nombre: "Perro"})
MERGE (a)-[:PERTENECE_A]->(e);

MATCH (a:Animal {id: "A-04"}), (e:Especie {nombre: "Gato"})
MERGE (a)-[:PERTENECE_A]->(e);

// Compatibilidad con otras especies
MATCH (a:Animal {id: "A-01"}), (e:Especie {nombre: "Gato"})
MERGE (a)-[r:COMPATIBLE_CON]->(e)
ON CREATE SET r.grado = "ALTO", r.validado_por_etologo = true;

MATCH (a:Animal {id: "A-01"}), (e:Especie {nombre: "Perro"})
MERGE (a)-[r:COMPATIBLE_CON]->(e)
ON CREATE SET r.grado = "ALTO", r.validado_por_etologo = true;

MATCH (a:Animal {id: "A-03"}), (e:Especie {nombre: "Perro"})
MERGE (a)-[r:COMPATIBLE_CON]->(e)
ON CREATE SET r.grado = "MEDIO", r.validado_por_etologo = false;

// Convivencia actual de adoptantes
MATCH (ad:Adoptante {id: "USR-01"}), (e:Especie {nombre: "Gato"})
MERGE (ad)-[r:CONVIVE_CON]->(e)
ON CREATE SET r.cantidad = 1;

MATCH (ad:Adoptante {id: "USR-02"}), (e:Especie {nombre: "Perro"})
MERGE (ad)-[r:CONVIVE_CON]->(e)
ON CREATE SET r.cantidad = 1;
// Seguimiento a protectoras
MATCH (ad:Adoptante {id: "USR-01"}), (p:Protectora {id: "PROT-01"})
MERGE (ad)-[r:SIGUE_A]->(p)
ON CREATE SET r.desde = date("2026-03-01");

MATCH (ad:Adoptante {id: "USR-02"}), (p:Protectora {id: "PROT-02"})
MERGE (ad)-[r:SIGUE_A]->(p)
ON CREATE SET r.desde = date("2026-03-15");

MATCH (ad:Adoptante {id: "USR-03"}), (p:Protectora {id: "PROT-04"})
MERGE (ad)-[r:SIGUE_A]->(p)
ON CREATE SET r.desde = date("2026-01-20");

// Ubicación y custodia actual de animales
MATCH (a:Animal {id: "A-01"}), (p:Protectora {id: "PROT-01"})
MERGE (a)-[r:ALOJADO_EN]->(p)
ON CREATE SET r.desde = date("2026-01-15");

MATCH (a:Animal {id: "A-02"}), (p:Protectora {id: "PROT-01"})
MERGE (a)-[r:ALOJADO_EN]->(p)
ON CREATE SET r.desde = date("2026-02-10");

MATCH (a:Animal {id: "A-03"}), (p:Protectora {id: "PROT-02"})
MERGE (a)-[r:ALOJADO_EN]->(p)
ON CREATE SET r.desde = date("2026-03-01");

// Historial de traslados previos
MATCH (a:Animal {id: "A-03"}), (p:Protectora {id: "PROT-03"})
MERGE (a)-[r:ESTUVO_EN]->(p)
ON CREATE SET 
    r.desde = date("2025-11-05"),
    r.hasta = date("2026-02-28"),
    r.motivo = "Derivación por saturación de plazas";

// Red de convenios y colaboración entre protectoras
MATCH (p1:Protectora {id: "PROT-01"}), (p2:Protectora {id: "PROT-02"})
MERGE (p1)-[r:COLABORA_CON]->(p2)
ON CREATE SET r.distancia_km = 12, r.activa = true;

MATCH (p1:Protectora {id: "PROT-01"}), (p3:Protectora {id: "PROT-03"})
MERGE (p1)-[r:COLABORA_CON]->(p3)
ON CREATE SET r.distancia_km = 78, r.activa = true;

MATCH (p3:Protectora {id: "PROT-03"}), (p4:Protectora {id: "PROT-04"})
MERGE (p3)-[r:COLABORA_CON]->(p4)
ON CREATE SET r.distancia_km = 110, r.activa = true;
// Historial y supervisión veterinaria
MATCH (v:Veterinaria {id: "VET-01"}), (a:Animal {id: "A-01"})
MERGE (v)-[r:SUPERVISA]->(a)
ON CREATE SET 
    r.fecha = date("2026-01-20"),
    r.diagnostico = "Desparasitación y vacunación al día",
    r.tratamiento = "Ninguno";

MATCH (v:Veterinaria {id: "VET-02"}), (a:Animal {id: "A-01"})
MERGE (v)-[r:SUPERVISA]->(a)
ON CREATE SET 
    r.fecha = date("2026-02-01"),
    r.diagnostico = "Apto para convivencia con felinos",
    r.tratamiento = "Pautas de presentación gradual";

MATCH (v1:Veterinaria {id: "VET-01"}), (a2:Animal {id: "A-02"})
MERGE (v1)-[r:SUPERVISA]->(a2)
ON CREATE SET 
    r.fecha = date("2026-02-20"), 
    r.diagnostico = "Gingivitis leve tratada", 
    r.tratamiento = "Limpieza bucal y dieta blanda";
// Solicitudes y adopciones definitivas
MATCH (ad:Adoptante {id: "USR-01"}), (a:Animal {id: "A-01"})
MERGE (ad)-[r:SOLICITA_ADOPCION]->(a)
ON CREATE SET 
    r.fecha = date("2026-03-25"),
    r.estado = "PENDIENTE";

MATCH (a:Animal {id: "A-04"}), (ad:Adoptante {id: "USR-02"})
MERGE (a)-[r:ADOPTADO_POR]->(ad)
ON CREATE SET 
    r.fecha_adopcion = date("2026-02-15");

    MATCH (a4:Animal {id: "A-02"}), (ad3:Adoptante {id: "USR-03"})
MERGE (a4)-[r:ADOPTADO_POR]->(ad3)
ON CREATE SET 
    r.fecha_adopcion = date("2025-11-15");