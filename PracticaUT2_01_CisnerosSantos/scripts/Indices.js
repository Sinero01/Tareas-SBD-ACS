//Indices para buscar un categoria ya que son unicas
db.categories.createIndex({ name: 1 }, { unique: true });

//Indices para buscar productos por categoria, precio y estado, 
db.products.createIndex({ category_name: 1, price: 1, status: 1 });
//Filtrado por texto
db.products.createIndex({ name: "text"});
//Filtrado por stock y marcas
db.products.createIndex({ "variants.stock": 1 });
db.products.createIndex({ brand: 1, status: 1 });

//Indices para buscar reseñas por producto y estado 
db.reviews.createIndex({ product_id: 1, rating: -1});
db.reviews.createIndex({ rating: -1, status: 1 });
db.reviews.createIndex({ user_id: 1 });

//Indices para buscar usuarios por email
db.users.createIndex({ email: 1 }, { unique: true });