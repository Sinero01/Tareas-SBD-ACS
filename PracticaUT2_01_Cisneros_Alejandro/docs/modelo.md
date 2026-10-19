## 2. Diseñar las colecciones

### 2.1. Colecciones y propositos

- categories: Almacenar las categoríasdel catálogo para filtrado, navegación y menús.
- products: Almacenar los productos, sus variantes y sus propiedades.
- reviews: Almacenar las reseñas de los clientes.
- users: Almacenar los usuarios y sus permisos.

![esquema de la base de datos](evidencias/mermaid.png)

### 2.2. Documentos de ejemplo

#### Categories

```json
{
  "_id": "electronica",
  "name": "Electrónica",
  "status": "active",
  "createdAt": { "$date": "2026-01-15T10:00:00.000Z" },
  "updatedAt": { "$date": "2026-01-15T10:00:00.000Z" }
}
```

#### Products

```json
{
  "_id": { "$oid": "6644f1a2e4b0a1c2d3e4f502" },
  "name": "Auriculares Inalámbricos Pro",
  "brand": "TechAudio",
  "category_id": "electronica",
  "price": { "$numberDecimal": "79.99" },
  "status": "active",
  "variants": [
    {
      "abrv": "NEG-STD",
      "stock": 45
    },
    {
      "abrv": "BLA-STD",
      "stock": 12
    }
  ],
  "createdAt": { "$date": "2026-03-01T12:00:00.000Z" },
  "updatedAt": { "$date": "2026-04-12T16:20:00.000Z" }
}
```

#### Users

```json

{
  "_id": { "$oid": "6644f1a2e4b0a1c2d3e4f501" },
  "email": "carlos.garcia@example.com",
  "password": "$2b$12$e8YkZ8r3H9XbYjW5qP0O1uK9uS0tW6vR1qL2mN3oP4qR5sT6uV7wX",
  "role": "customer",
  "createdAt": { "$date": "2026-02-10T08:30:00.000Z" },
  "updatedAt": { "$date": "2026-02-10T08:30:00.000Z" }
}

```

#### Reviews

```json
{
  "_id": { "$oid": "6644f1a2e4b0a1c2d3e4f503" },
  "product_id": { "$oid": "6644f1a2e4b0a1c2d3e4f502" },
  "user_id": { "$oid": "6644f1a2e4b0a1c2d3e4f501" },
  "rating": 5,
  "comment": "Excelente cancelación de ruido y duración de batería.",
  "status": "approved",
  "createdAt": { "$date": "2026-04-15T09:15:30.000Z" },
  "updatedAt": { "$date": "2026-04-15T10:00:00.000Z" }
}

```

### 2.3. Decisión de Modelado

- Incrustacion dentro de productos: ya que un producto puede tener varias variantes, y cada una de ellas puede tener diferente disponibilidad y esto se tiene que mostrar. Y asu vez posee una baja cardinalidad ya que las varianes no suelen superar las 10.
- Referencia: Una review tiene que tener una referencia a el producto el cual se esta valorando y por quien se valora.

### 2.4. Estrategia para IDs

- identficadores de objetos: ObjectId es autogenerado por MongoDB, y es un identificador que garantiza que sea único en el sistema.
- Fechas: Datos BSON para poder hacer consultas de fechas, y para poder ordenar por fecha.
- Estados: Para poder clasificar productos y usuarios .

### 2.5. Limites

-Limite de 16MB por documento. Los productos ocupan mucho menos espacio aproximadamente unos 4KB.
-Evitar Arrays anidados. ya que las reviews de usuarios se extraeon de otra coleccion su producto especifico evitando que sean infinitos.
