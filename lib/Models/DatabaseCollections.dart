import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService({required this.uid});

  final String uid;

  final CollectionReference userCollection2 =
      FirebaseFirestore.instance.collection('usersData');

  Future registerCustomer(String firstname, String lastname, String phoneno,
      String address, String city, String cnic, String userID) async {
    return await userCollection2.doc(uid).set({
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
}
