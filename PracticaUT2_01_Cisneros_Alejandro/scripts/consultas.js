print("\n--- 1. Productos de 'Electrónica' con precio < 100 € ---");
db.products.find(
  {
    category_name: "Electrónica",
    price: { $lt: NumberDecimal("100.00") },
    status: "active"
  },
  { name: 1, brand: 1, price: 1, _id: 0 }
).sort({ price: 1 });

print("\n--- 2. Productos que coinciden con 'televisión' en el nombre ---");
db.products.find(
  {
    $text: { $search: "televisión" },
    status: "active"
  },
  { name: 1, brand: 1, price: 1, score: { $meta: "textScore" }, _id: 0 }
).sort({ score: { $meta: "textScore" } });

print("\n--- 3. Productos casi agotados (stock entre 1 y 5 unidades) ---");
db.products.find(
  {
    "variants.stock": { $gt: 0, $lte: 5 },
    status: "active"
  },
  { name: 1, brand: 1, "variants.abrv": 1, "variants.stock": 1, _id: 0 }
);

print("\n--- 4. Reseñas con valoración positiva (rating >= 4) ---");
db.reviews.find(
  {
    rating: { $gte: 4 },
    status: "approved"
  },
  { user_name: 1, rating: 1, title: 1, comment: 1, _id: 0 }
).sort({ rating: -1, created_at: -1 });

print("\n--- 5. Variantes de un producto por su nombre ---");
db.products.findOne(
  { name: "Televisión Sony Bravia 4K Ultra HD" },
  { name: 1, variants: 1, _id: 0 }
);

print("\n--- 6. Productos disponibles de la marca 'Sony' (stock > 0) ---");
db.products.find(
  {
    brand: "Sony",
    "variants.stock": { $gt: 0 },
    status: "active"
  },
  { name: 1, price: 1, "variants.abrv": 1, "variants.stock": 1, _id: 0 }
);
// Prueba SIN índice 
db.products.find(
  { category_name: "Electrónica", price: { $lt: NumberDecimal("100.00") }, status: "active" }
).hint({ $natural: 1 }).explain("executionStats");
// Prueba con el índice compuesto creado
db.products.find(
  { category_name: "Electrónica", price: { $lt: NumberDecimal("100.00") }, status: "active" }
).sort({ price: 1 }).explain("executionStats");
//Filtro combinado y paginacion
db.products.find(
  { category_name: "Electrónica", status: "active", price: { $gte: NumberDecimal("10.00") } },
  { name: 1, price: 1, brand: 1 }
)
.sort({ price: 1, _id: 1 })
.skip(0)
.limit(10);
//. Consulta de Referencia con $lookup
db.products.aggregate([
  {
    $match: { name: "Televisión Sony Bravia 4K Ultra HD" }
  },
  {
    $lookup: {
      from: "reviews",
      localField: "_id",
      foreignField: "product_id",
      as: "detailed_reviews"
    }
  },
  {
    $project: {
      name: 1,
      brand: 1,
      price: 1,
      "variants.abrv": 1,
      "variants.stock": 1,
      "detailed_reviews.user_name": 1,
      "detailed_reviews.rating": 1,
      "detailed_reviews.comment": 1
    }
  }
]);
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