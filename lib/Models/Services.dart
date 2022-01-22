import 'package:image_picker/image_picker.dart';

class Services {
  final String name, description;
  final String price;
  final int packageNumber;
  bool availibility;
  List<XFile>? images;

  Services(
      {required this.name,
      required this.price,
      required this.description,
      required this.packageNumber,
      required this.images,
      this.availibility = true});

  void toggleisDone() {
    availibility = !availibility;
  }
}

List<Services> servicesTask = [];
