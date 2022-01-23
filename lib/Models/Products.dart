class Product {
  final String name;
  final String description;
  final String address;
  final String price;
  final String imagePath;

  Product(
      this.name, this.description, this.address, this.price, this.imagePath);
}

List<Product> sampleProperties = [
  Product('hall', 'this is description', '68//8 old civil line', '7500',
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
  Product(
      'hall',
      'this is description,this is description,this is description,this is description,this is description,this is description,this is description',
      '68//8 old civil line',
      '7500',
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
];

class AllProduct {
  final String uid;
  final List<String> availibility;
  final List<String> price;
  final List<String> name;
  final List<String> description;
  final List<String> pictures;

  AllProduct(
      {required this.uid,
      required this.availibility,
      required this.price,
      required this.name,
      required this.description,
      required this.pictures});
}

List<AllProduct> allProductList = [];
