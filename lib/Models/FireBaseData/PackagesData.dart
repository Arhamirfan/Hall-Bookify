import 'package:cloud_firestore/cloud_firestore.dart';

class PackagesData {
  final CollectionReference userCollection2 =
      FirebaseFirestore.instance.collection('Packages');

  Future getCurrentUserPackages(String uid) async {
    QuerySnapshot<Map<String, dynamic>> pkg;
    var alldata;
    List packg = [];
    for (int i = 0; i < 10; i++) {
      try {
        pkg = await userCollection2.doc(uid).collection('package$i').get();
        if (pkg.docs.isNotEmpty) {
          alldata = pkg.docs.map((doc) => doc.data()).toList();
          packg.add(alldata);
          print(packg);
          // for (var doc in pkg.docs) {
          //   print("counter running: " + i.toString());
          //   getcurrentuserPackage = doc.data();
          // }
        } else {
          print("Document data not exist in Package " + i.toString());
          break;
        }
      } catch (NullException) {
        print(NullException.toString());
        break;
      }
    }
    print("_______________List result_________________");
    print(packg);
  }

  Future getCurrentUserSinglePackagesDetail(String uid, int number) async {
    QuerySnapshot<Map<String, dynamic>> pkg;
    var alldata;
    List packg = [];
    Map<String, dynamic>? getcurrentuserPackage;
    try {
      pkg = await userCollection2.doc(uid).collection('package$number').get();
      if (pkg.docs.isNotEmpty) {
        alldata = pkg.docs.map((doc) => doc.data()).toList();
        packg.add(alldata);
        print(packg);
        for (var doc in pkg.docs) {
          getcurrentuserPackage = doc.data();
        }
      } else {
        print("Document data not exist in Package " + number.toString());
      }
    } catch (NullException) {
      print(NullException.toString());
    }
    print("_______________Map result_________________");
    print(getcurrentuserPackage);
    print("_______________List result_________________");
    print(packg);
  }
}
