import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference profilelist =
      FirebaseFirestore.instance.collection("usersData");

  Stream<QuerySnapshot> get users {
    return profilelist.snapshots();
  }

  Future getCurrentUserData(String uid) async {
    try {
      DocumentSnapshot ds = await profilelist.doc(uid).get();
      String firstname = ds.get('firstname');
      String lastname = ds.get('lastname');
      String phoneno = ds.get('phoneno');
      String address = ds.get('address');
      String city = ds.get('city');
      return [firstname, lastname, phoneno, address, city];
    } catch (e) {
      print(e.toString());
      return null;
    }
    //how to get data in UI:onPressed() async { dynamic names = await DatabaseManager.getCurrentUserData(); if(names != null) { String firstname = names[0];} }
  }

  Future<bool> userExist(String uid) async {
    DocumentSnapshot ds = await profilelist.doc(uid).get();
    if (ds.exists) {
      print('Data with that ID exist');
      return true;
    } else {
      String userid = ds.get('userid');
      if (userid == null) {
        print("Data dont exist");
        return false;
      } else {
        print("Data with ID exist in db collection");
        return true;
      }
    }
  }

  Future updateUserData(String firstname, String lastname, String address,
      String city, String uid) async {
    return await profilelist.doc(uid).update({
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'city': city
    });
  }

  Future deleteUser(String uid) {
    return profilelist.doc(uid).delete();
  }

  Future getUsersList() async {
    List itemList = [];
    try {
      await profilelist.get().then((value) {
        value.docs.forEach((element) {
          itemList.add(element.data());
        });
      });
      return itemList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
