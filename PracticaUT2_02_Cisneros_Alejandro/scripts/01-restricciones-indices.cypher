// 1. Restricción de unicidad para Animales 
CREATE CONSTRAINT constraint_animal_id IF NOT EXISTS
FOR (a:Animal)
REQUIRE a.id IS UNIQUE;

// 2. Restricción de unicidad para Adoptantes 
CREATE CONSTRAINT constraint_adoptante_id IF NOT EXISTS
FOR (ad:Adoptante)
REQUIRE ad.id IS UNIQUE;

// 3. Restricción de unicidad para Protectoras 
CREATE CONSTRAINT constraint_protectora_cif IF NOT EXISTS
FOR (p:Protectora)
REQUIRE p.id IS UNIQUE;

// 4. Restricción de unicidad para Especies 
CREATE CONSTRAINT constraint_especie_nombre IF NOT EXISTS
FOR (e:Especie)
REQUIRE e.nombre IS UNIQUE;

// 5. Restricción de unicidad para Veterinarias 
CREATE CONSTRAINT constraint_veterinaria_num IF NOT EXISTS
FOR (v:Veterinaria)
REQUIRE v.id IS UNIQUE;


// 1. Índice para filtrar animales por estado 
CREATE INDEX index_animal_estado IF NOT EXISTS
FOR (a:Animal)
ON (a.estado);

// 2. Índice compuesto para catálogo: filtra por estado y ordena por antigüedad de rescate
CREATE INDEX index_animal_catalogo IF NOT EXISTS
FOR (a:Animal)
ON (a.estado, a.fecha_rescate);

// 3. Índice por nivel de energía para matching rápido con el tipo de vivienda
CREATE INDEX index_animal_energia IF NOT EXISTS
FOR (a:Animal)
ON (a.nivel_energia);

// 4. Índice geográfico por código postal para búsqueda de protectoras cercanas
CREATE INDEX index_protectora_cp IF NOT EXISTS
FOR (p:Protectora)
ON (p.codigo_postal);

// 5. Índice geográfico por código postal para adoptantes
CREATE INDEX index_adoptante_cp IF NOT EXISTS
FOR (ad:Adoptante)
ON (ad.codigo_postal);