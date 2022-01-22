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
      'https://firebasestorage.googleapis.com/v0/b/hall-bookify.appspot.com/o/YWHeWyyv1YNjZvyFAKxhWB0lT6m2%2FPackage0%2Fimage_picker4582458011361677597.jpg?alt=media&token=92ffb1f3-86ec-44b5-b7bc-65c1dc8d53cd'),
  Product(
      'hall',
      'this is description,this is description,this is description,this is description,this is description,this is description,this is description',
      '68//8 old civil line',
      '7500',
      'https://firebasestorage.googleapis.com/v0/b/hall-bookify.appspot.com/o/YWHeWyyv1YNjZvyFAKxhWB0lT6m2%2FPackage0%2Fimage_picker4582458011361677597.jpg?alt=media&token=92ffb1f3-86ec-44b5-b7bc-65c1dc8d53cd')
];
