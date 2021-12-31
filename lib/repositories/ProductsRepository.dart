import 'package:onmarket_task/models/Product.dart';

class ProductsRepository{

  List<Product>  fetchAllProducts() {

    return [
      new Product(urlToImage: "assets/images/spelt_noodles.png",
          title: "Biona Organic Spelt Noodles", price: 2.99, weight:250, id:0),
      new Product(urlToImage: "assets/images/spelt_italian.png",
          title: "Biona Organic Spelt Fusili Brown", price: 2.35, discount: 30,weight:500, id: 1),
      new Product(urlToImage: "assets/images/spelt_spaghetti.png",
          title: "Biona Organic Whole Spelt Spaghetti", price: 2.35,discount: 50, weight:500, id: 2),
      new Product(urlToImage: "assets/images/spelt_tagliatelle.png",
          title: "Biona Organic Spelt Spinach Artisan Tagliatelle", price: 1.99, weight:250, id:3),
      new Product(urlToImage: "assets/images/spelt_penne.png",
          title: "Biona Organic Whole Spelt Penne", price: 2.35, weight:500, id:4),
      new Product(urlToImage: "assets/images/spelt_tagliatelle.png",
          title: "Biona Organic Spelt Spinach Artisan Tagliatelle", price: 1.99, discount: 15,
          weight:250, id:5),
      new Product(urlToImage: "assets/images/spelt_fusilli.png",
          title: "Biona Organic Spelt Fusilli Tricolore", price: 1.99, weight:250, id:6),
    ];
  }
  
}