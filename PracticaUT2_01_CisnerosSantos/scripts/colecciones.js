//Creación de colecciones y validaciones
db.createCollection("categories", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "status"],
      properties: {
        name: { bsonType: "string" },
        status: { enum: ["active", "inactive"] }
      }
    }
  }
});
db.createCollection("products", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "brand", "category_name", "price", "status", "variants"],
      properties: {
        name: { bsonType: "string" },
        brand: { bsonType: "string" },
        category_name: { bsonType: "string" },
        price: { bsonType: "decimal" },
        status: { enum: ["active", "inactive"] },
        variants: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["abrv", "stock"],
            properties: {
              abrv: { bsonType: "string" },
              stock: { bsonType: "int", minimum: 0 }
            }
          }
        }
      }
    }
  }
});
db.createCollection("reviews", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["product_id", "rating", "status"],
      properties: {
        product_id: { bsonType: "objectId" },
        rating: { bsonType: "int", minimum: 1, maximum: 5 },
        status: { enum: ["approved", "pending", "rejected"] }
      }
    }
  }
});