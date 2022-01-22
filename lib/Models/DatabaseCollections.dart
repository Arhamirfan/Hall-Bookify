import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hall_bookify/Models/Services.dart';
import 'package:hall_bookify/Models/sharedPreference.dart';

class DatabaseService {
  DatabaseService({required this.uid});

  final String uid;

  final CollectionReference userCollection1 =
      FirebaseFirestore.instance.collection('usersData');
  final CollectionReference userCollection2 =
      FirebaseFirestore.instance.collection('Packages');

  Future registerCustomer(String firstname, String lastname, String phoneno,
      String address, String city, String cnic, String userID) async {
    return await userCollection1.doc(uid).set({
      'firstname': firstname,
      'lastname': lastname,
      'phoneno': phoneno,
      'address': address,
      'city': city,
      'cnic': cnic,
      'role': 'customer',
      'userid': userID
    });
  }

  Future registerPackages(String pkgnumber, List<Services> serviceTask,
      List<String> downloadURL) async {
    print("________service task SP end value:________" + pkgnumber);
    if (serviceTask.last.packageNumber <= 9) {
      //print(serviceTask.length);
      CollectionReference packageCollection =
          userCollection2.doc(uid).collection('package$pkgnumber');
      int count = 0;

      Map<String, dynamic> map2 = {};
      serviceTask.forEach((package) {
        map2['name$count'] = package.name;
        map2['price$count'] = package.price;
        map2['description$count'] = package.description;
        ++count;
      });
      map2.addAll({'pictures': downloadURL});
      map2.addAll({'uid': '$uid'});
      print(map2);
      await packageCollection.doc().set(map2);

      sharedPreference sharedpref = new sharedPreference();
      sharedpref.incrementCounter();
    } else {
      print("Cannot add more than 10 products");
    }
  }
}
