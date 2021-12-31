class Product {

  String urlToImage;
  String about;
  String title;
  double price;
  int discount;
  double weight;
  int id;


  Product({required this.urlToImage, required this.title, required this.price,this.discount=0
    ,required this.weight, required this.id,
    this.about = "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
        " sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        " Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip"
        " ex ea commodo consequat."
  });


}