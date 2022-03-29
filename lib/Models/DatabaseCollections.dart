import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:hall_bookify/Models/Services.dart';
import 'package:hall_bookify/Models/sharedPreference/sharedPreference.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class DatabaseService {
  DatabaseService({required this.uid});

  late final String uid;
  List<String> DownloadURL = [];
  List<String> _imgurl = [];
  List<String> imgDownloadURL = [];
  List<String> get imgurl => _imgurl;

  set imgurl(List<String> value) {
    _imgurl = value;
  }

  final CollectionReference userCollection1 =
      FirebaseFirestore.instance.collection('usersData');
  final CollectionReference userCollection2 =
      FirebaseFirestore.instance.collection('Packages');

  final CollectionReference userCollection3 =
      FirebaseFirestore.instance.collection('AllPackages');

  final CollectionReference userCollection4 =
      FirebaseFirestore.instance.collection('Cart');

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

  Future registerPackages(String packageName, String location, String pkgnumber,
      List<Services> serviceTask, List<String> downloadURL) async {
    print("________service task SP end value:________" + pkgnumber);
    if (serviceTask.last.packageNumber <= 9) {
      //print(serviceTask.length);
      CollectionReference packageCollection =
          userCollection2.doc(uid).collection('package$pkgnumber');
      int count = 0;

      Map<String, dynamic> map2 = {};
      serviceTask.forEach((package) {
        map2['service$count'] = package.name;
        map2['price$count'] = package.price;
        map2['description$count'] = package.description;
        ++count;
      });
      map2.addAll({'package': packageName});
      map2.addAll({'location': location});
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

  Future registerAllPackages(String packageName, String location,
      List<Services> allproductTask, List<String> url, String uid) async {
    print("all products________________");
    print(uid);
    print(allproductTask);
    List<String> names = [];
    List<String> price = [];
    List<String> desc = [];
    List<bool> availibility = [];
    for (int i = 0; i < allproductTask.length; i++) {
      print(allproductTask[i].name);
      names.add(allproductTask[i].name);
      price.add(allproductTask[i].price);
      desc.add(allproductTask[i].description);
      availibility.add(allproductTask[i].availibility);
    }

    await userCollection3.doc().set({
      'package': packageName,
      'location': location,
      'services': names,
      'price': price,
      'description': desc,
      'availibility': availibility,
      'pictures': url,
      'uid': uid
    });
  }

  Future uploadPackagePictures(List<XFile>? images) async {
    sharedPreference sharedpref = new sharedPreference();
    int packageno = await sharedpref.getintfromSharedPreference(),
        packagenotosend = 0;
    packagenotosend = packageno;
    late firebase_storage.Reference ref;

    //imgref = FirebaseFirestore.instance.collection('imageURL');
    for (var img in images!) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref(uid)
          .child('Package${packagenotosend}/${Path.basename(img.path)}');
      await ref.putFile(File(img.path)).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgDownloadURL.add(value);
        });
      });
    }
    _imgurl = imgDownloadURL;
  }

  Future addToCartPackage(String buyer_uid, Map package, String total,
      String creatorFee, String subTotal) async {
    sharedPreferenceForCart sharedpreference = new sharedPreferenceForCart();
    int cart_no = await sharedpreference.getintfromSharedPreference();
    if (cart_no < 1) {
      print("--------Cart Details---------");
      print("Buyer : " + buyer_uid);
      print("Seller : " + package['uid']);
      print("Sub total : " + subTotal);

      await userCollection4.doc().set({
        'buyer uid': buyer_uid,
        'seller uid': package['uid'],
        'Package': package['package'],
        'Location': package['location'],
        'Services': package['services'],
        'Services Price': package['price'],
        'Total': total,
        'Creator Fee': creatorFee,
        'Sub Total': subTotal
      });

      sharedpreference.incrementCounter();
    } else {
      print('Sorry cannot add more item to cart');
    }
  }
}
