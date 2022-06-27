// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:hall_bookify/Models/sharedPreference/sharedPreference.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOperations {
  var buyerData;
  var packageData;
  var receiptData;
  Map<dynamic, dynamic> sellerData = {};

  final CollectionReference userCollection1 =
      FirebaseFirestore.instance.collection('usersData');

  final CollectionReference userCollection2 =
      FirebaseFirestore.instance.collection('Packages');

  final CollectionReference userCollection3 =
      FirebaseFirestore.instance.collection('AllPackages');

  final CollectionReference userCollection4 =
      FirebaseFirestore.instance.collection('Cart');

  final CollectionReference userCollection5 =
      FirebaseFirestore.instance.collection('Receipt');

  final CollectionReference userCollection6 =
      FirebaseFirestore.instance.collection('Favourities');

  final CollectionReference userCollection7 =
      FirebaseFirestore.instance.collection('review');

  Future addToFavourities(String buyerID, Map package) async {
    package['buyeruid'] = buyerID;
    return await userCollection6.doc().set(package);
  }

  Future deleteFavourities() async {
    var collection = FirebaseFirestore.instance.collection('Favourities');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Future removeFromReview(String docsID) async {
    await userCollection7
        .doc(docsID)
        .delete()
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
  }

  Future approveFromReview(String docsID) async {
    await userCollection7.doc(docsID).update({'status': 'approved'});
  }

  Future resumeService(String docsID) async {
    await userCollection3.doc(docsID).update({'package_availability': true});
  }

  Future stopService(String docsID) async {
    await userCollection3.doc(docsID).update({'package_availability': false});
  }

  Future removeFromCart(String docsID) async {
    await userCollection4
        .doc(docsID)
        .delete()
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
  }

  Future updateAddToCart(String docsID) async {
    await userCollection4.doc(docsID).update({'addtocart': false});
  }

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

  // Future getAndUpdatePackageData(String packageName) async {
  //   await userCollection3
  //       .where('package', isEqualTo: packageName)
  //       .get()
  //       .then((QuerySnapshot querysnapshot) {
  //     querysnapshot.docs.forEach((element) {
  //       packageData = element.data() as Map;
  //       userCollection3.doc(element.id).update({'package_availibility': false});
  //     });
  //   });
  // }

  Future getReceiptData(String invoiceNumber) async {
    //print('seller Data');
    await userCollection5
        .where('invoicenumber', isEqualTo: invoiceNumber)
        .get()
        .then((QuerySnapshot querysnapshot) {
      querysnapshot.docs.forEach((element) {
        receiptData = element.data() as Map;
      });
    });
    //print(sellerData);
  }

  Future getpackageDataAndAddRatings(
      String packagename, double ratingstars, String rating_description) async {
    //print('seller Data');
    var packageDocumentId;
    await userCollection3
        .where('package', isEqualTo: packagename)
        .get()
        .then((QuerySnapshot querysnapshot) {
      querysnapshot.docs.forEach((element) {
        receiptData = element.data() as Map;
        packageDocumentId = element.id;
      });
    });
    await userCollection3.doc(packageDocumentId).set(
        {'rating_stars': ratingstars, 'rating_description': rating_description},
        SetOptions(merge: true)).then((value) {
      print('successfully added ratings');
    }).onError((error, stackTrace) {
      print(error.toString());
    });
    //print(sellerData);
  }
  // Future<Map<dynamic, dynamic>> getPackageByName(String packageName) async {
  //   Map<dynamic, dynamic> SearchedPackages = {};
  //   print('send name:' + packageName);
  //   await userCollection3
  //       .where('package', isEqualTo: packageName)
  //       .get()
  //       .then((QuerySnapshot querysnapshot) {
  //     querysnapshot.docs.forEach((element) {
  //       print(element.data());
  //       SearchedPackages = element.data() as Map;
  //     });
  //   });
  //   return SearchedPackages;
  // }
}
