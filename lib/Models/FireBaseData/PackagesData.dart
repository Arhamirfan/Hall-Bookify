import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hall_bookify/Models/Products.dart';

class PackagesData {
  final CollectionReference userCollection2 =
      FirebaseFirestore.instance.collection('Packages');
  final CollectionReference userCollection3 =
      FirebaseFirestore.instance.collection('AllPackages');

  int totalPackages = 0;

  Future getallPackages() async {
    var collection = FirebaseFirestore.instance.collection('AllPackages');
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data;
    for (var doc in querySnapshot.docs) {
      data = doc.data();
    }
    print('getting data from document');
    print(data);
  }

  Future<List<AllProduct>> getAllProductEnteries(int index) async {
    List<AllProduct> productlist = [];
    QuerySnapshot snapshot;
    try {
      snapshot = await userCollection3.get();
      if (snapshot.docs.isNotEmpty) {
        var temp = snapshot.docs[index].data() as Map;
        temp.forEach((key, value) {
          // productlist.add(AllProduct(
          //     name: value['name'],
          //     description: value['name'],
          //     address: value['name'],
          //     price: value['name'],
          //     pictures: value['name'],
          //     uid: value['uid']));
        });
      }
    } catch (e) {
      print(e);
    }
    return productlist;
  }

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
    print("uid in db:" + uid);
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
