import 'package:image_picker/image_picker.dart';

class Services {
  final String name, description;
  final String price;
  bool availibility;
  List<XFile>? images;

  Services(
      {required this.name,
      required this.price,
      required this.description,
      required this.images,
      this.availibility = true});

  void toggleisDone() {
    availibility = !availibility;
  }
}

List<Services> servicesTask = [];
