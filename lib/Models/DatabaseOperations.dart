// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:hall_bookify/Models/sharedPreference/sharedPreference.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOperations {
  var buyerData;
  var packageData;
  Map<dynamic, dynamic> sellerData = {};
  final CollectionReference userCollection1 =
      FirebaseFirestore.instance.collection('usersData');

  final CollectionReference userCollection2 =
      FirebaseFirestore.instance.collection('Packages');

  final CollectionReference userCollection3 =
      FirebaseFirestore.instance.collection('AllPackages');

  final CollectionReference userCollection4 =
      FirebaseFirestore.instance.collection('Cart');

  Future getBuyerData(String buyerUid) async {
    //print('buyer data');
    await userCollection1
        .where('userid', isEqualTo: buyerUid)
        .get()
        .then((QuerySnapshot querysnapshot) {
      querysnapshot.docs.forEach((element) {
        buyerData = element.data() as Map;
      });
    });
    //print(buyerData);
  }

  Future getSellerData(String sellerUid) async {
    //print('seller Data');
    await userCollection1
        .where('userid', isEqualTo: sellerUid)
        .get()
        .then((QuerySnapshot querysnapshot) {
      querysnapshot.docs.forEach((element) {
        sellerData = element.data() as Map;
      });
    });
    //print(sellerData);
  }

  Future getAndUpdatePackageData(String packageName) async {
    await userCollection3
        .where('package', isEqualTo: packageName)
        .get()
        .then((QuerySnapshot querysnapshot) {
      querysnapshot.docs.forEach((element) {
        packageData = element.data() as Map;
        userCollection3.doc(element.id).update({'package_availibility': false});
      });
    });
  }
}
