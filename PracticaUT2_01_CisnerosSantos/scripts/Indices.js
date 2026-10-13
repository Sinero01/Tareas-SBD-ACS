db.categories.createIndex({ name: 1 }, { unique: true });

db.products.createIndex({ category_name: 1, price: 1, status: 1 });
db.products.createIndex({ name: "text"});
db.products.createIndex({ "variants.stock": 1 });
db.products.createIndex({ brand: 1, status: 1 });

db.reviews.createIndex({ product_id: 1, rating: -1});
db.reviews.createIndex({ rating: -1, status: 1 });