import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService({required this.uid});

  final String uid;

  final CollectionReference userCollection2 =
      FirebaseFirestore.instance.collection('usersData');

  Future registerOrUpdateData2(
      String firstname, String lastname, String phoneno) async {
    return await userCollection2.doc(uid).set(
        {'firstname': firstname, 'lastname': lastname, 'phoneno': phoneno});
  }
}
