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

  // Future registerpackagetesting(String uid, List<Services> serviceTask) async {
  //   sharedPreference sp = new sharedPreference();
  //   //SharedPreferences sharedpref = await SharedPreferences.getInstance();
  //   //final startupNumber = sharedpref.getInt('startNumber');
  //   //int counter = await sp.getintfromSharedPreference();
  //   //print("counter value:" + counter.toString());
  //   //print("startupNUmber SP:" + startupNumber.toString());
  //   sp.resetCounter();
  //   print(uid);
  //   print(serviceTask.length);
  //   print(serviceTask[0].packageNumber);
  //   for (var items in serviceTask) {
  //     print(items.name);
  //   }
  // }

  Future registerPackages(String pkgnumber, List<Services> serviceTask) async {
    //sharedPreference sp = new sharedPreference();
    //int counter = await sp.getintfromSharedPreference();
    print("________service task SP end value:________" + pkgnumber);
    if (serviceTask.last.packageNumber <= 9) {
      //print(serviceTask.length);
      CollectionReference packageCollection =
          userCollection2.doc(uid).collection('package$pkgnumber');
      int count = 0;
      //
      // await Future.forEach(serviceTask, (item) async {
      //   await packageCollection.doc().set({
      //     'name$count': '${item.name}',
      //     'price$count': '${item.price}',
      //     'description$count': '${item.description}',
      //     'packagenumber$count': '${item.packageNumber}',
      //     'uid': '${uid}'
      //   });
      // });
      Map<String, dynamic> map2 = {};
      serviceTask.forEach((package) {
        map2['name$count'] = package.name;
        map2['price$count'] = package.price;
        map2['description$count'] = package.description;
        ++count;
      });
      map2.addAll({'uid': '$uid'});
      print(map2);
      await packageCollection.doc().set(map2);

      sharedPreference sharedpref = new sharedPreference();
      sharedpref.incrementCounter();

      // Map<String, dynamic> data =
      //     new Map<String, dynamic>.from(json.decode(response.body));
      //print(data['name']);
      // for (var item in serviceTask) {
      //   print(item.name);
      //   await packageCollection.doc().set({
      //     'name$count': '${item.name}',
      //     'price$count': '${item.price}',
      //     'description$count': '${item.description}',
      //     'packagenumber$count': '${item.packageNumber}',
      //     'uid': '${uid}'
      //   }).then((value) {
      //     ++count;
      //   });
      // }
      //TODO (resolved)solve error:Concurrent modification during iteration: Instance(length:0) of '_GrowableList'. sol: set list to maps then add to db
      //getting this error bcz await in loop stops list and loop continues-> put wait in loop or google how to use async in loop
    } else {
      print("Cannot add more than 10 products");
    }
  }
}
