// categorias
const catElectronica = db.categories.insertOne({
  name: "Electrónica",
  status: "active",
  created_at: new Date()
});

const catHogar = db.categories.insertOne({
  name: "Hogar y Cocina",
  status: "active",
  created_at: new Date()
});

// Productos 
const prodTV = db.products.insertOne({
  name: "Televisión Sony Bravia 4K Ultra HD",
  brand: "Sony",
  description: "Televisión de alta resolución con panel LED y Dolby Vision.",
  category_id: catElectronica.insertedId,
  category_name: "Electrónica",
  price: NumberDecimal("89.99"),
  status: "active",
  specs: { pantalla_pulgadas: 43, puertos_hdmi: 3 },
  variants: [
    { abrv: "TV43-NEG", attributes: { color: "Negro" }, stock: NumberInt(2) },  // Casi agotado (P3)
    { abrv: "TV43-PLA", attributes: { color: "Plata" }, stock: NumberInt(12) }
  ],
  rating_summary: { average: 4.8, count: 2 },
  created_at: new Date()
});

const prodAudifonos = db.products.insertOne({
  name: "Auriculares Inalámbricos Sony Noise Cancelling",
  brand: "Sony",
  description: "Auriculares de diadema con cancelación activa de ruido.",
  category_id: catElectronica.insertedId,
  category_name: "Electrónica",
  price: NumberDecimal("45.50"),
  status: "active",
  specs: { duracion_bateria_horas: 30 },
  variants: [
    { abrv: "AUR-NEG", attributes: { color: "Negro" }, stock: NumberInt(25) }
  ],
  rating_summary: { average: 4.5, count: 1 },
  created_at: new Date()
});

const prodRobot = db.products.insertOne({
  name: "Aspirador Robot Xiaomi Smart Clean",
  brand: "Xiaomi",
  description: "Robot aspirador con navegación láser LiDAR.",
  category_id: catHogar.insertedId,
  category_name: "Hogar y Cocina",
  price: NumberDecimal("180.00"),
  status: "active",
  specs: { potencia_pa: 4000 },
  variants: [
    { abrv: "ROB-BLA", attributes: { color: "Blanco" }, stock: NumberInt(4) }   // Casi agotado (P3)
  ],
  rating_summary: { average: 3.2, count: 1 },
  created_at: new Date()
});

// Reseñas
db.reviews.insertMany([
  {
    product_id: prodTV.insertedId,
    user_name: "Marcos L.",
    rating: NumberInt(5),
    title: "Espectacular imagen",
    comment: "Se ve increíble y el sonido integrado es más que suficiente.",
    status: "approved",
    created_at: new Date("2026-03-01T10:00:00Z")
  },
  {
    product_id: prodTV.insertedId,
    user_name: "Elena G.",
    rating: NumberInt(4),
    title: "Muy buena compra",
    comment: "Cumple con creces, el mando a distancia es cómodo.",
    status: "approved",
    created_at: new Date("2026-03-05T12:30:00Z")
  },
  {
    product_id: prodRobot.insertedId,
    user_name: "Roberto P.",
    rating: NumberInt(2),
    title: "Se atasca con frecuencia",
    comment: "La potencia es buena pero se enreda con facilidad en cables.",
    status: "approved",
    created_at: new Date("2026-03-10T15:20:00Z")
  }
]);

//Prueba de inserción de datos erronea
db.products.insertOne({
  name: "Televisor Defectuoso Sin Marca",
  category_name: "Electrónica",
  price: 50.00, 
  status: "active",
  variants: [
    {
      abrv: "DEF-01",
      stock: NumberInt(-5) 
    }
  ]
});
//Pruebas de actualizacion de datos
db.products.updateOne(
  { name: "Aspirador Robot Xiaomi Smart Clean", "variants.abrv": "ROB-BLA", "variants.stock": { $gte: 1 } },
  { $inc: { "variants.$.stock": -1 } }
);

db.products.updateOne(
  { name: "Aspirador Robot Xiaomi Smart Clean" },
  {
    $set: {
      status: "inactive",
      deactivated_at: new Date(),
      deactivation_reason: "Descatalogado temporalmente por el administrador"
    }
  }
);
//Agregacion compleja
db.products.aggregate([
  // Etapa 1
  {
    $match: {
      category_name: "Electrónica",
      status: "active"
    }
  },

  // Etapa 2
  {
    $unwind: "$variants"
  },

  // Etapa 3
  {
    $lookup: {
      from: "reviews",
      let: { prodId: "$_id" },
      pipeline: [
        { $match: { $expr: { $and: [{ $eq: ["$product_id", "$$prodId"] }, { $eq: ["$status", "approved"] }] } } }
      ],
      as: "product_reviews"
    }
  },

  // Etapa 4
  {
    $group: {
      _id: "$brand",
      total_units_in_stock: { $sum: "$variants.stock" },
      avg_catalog_price: { $avg: "$price" },
      distinct_products: { $addToSet: "$name" }
    }
  },
  // Etapa 5
  {
    $facet: {
      inventory_ranking: [
        { $sort: { total_units_in_stock: -1 } }
      ],
      brand_summary: [
        {
          $group: {
            _id: null,
            total_brands: { $sum: 1 },
            global_units: { $sum: "$total_units_in_stock" }
          }
        }
      ]
    }
  }
]);