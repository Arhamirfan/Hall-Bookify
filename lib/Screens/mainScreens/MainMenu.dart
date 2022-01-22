import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:hall_bookify/Controller/MainDrawer.dart';
import 'package:hall_bookify/Models/FireBaseData/PackagesData.dart';
import 'package:hall_bookify/Models/FireBaseData/ProfileDatabase.dart';
import 'package:hall_bookify/Screens/mainScreens/Favourites/favouritePage.dart';
import 'package:hall_bookify/Screens/mainScreens/SearchProduct/searchProductMain.dart';
import 'package:hall_bookify/Screens/mainScreens/addProducts/addProductMain.dart';
import 'package:hall_bookify/Screens/mainScreens/profileManagement.dart';

import 'HomeScreen/HomePage.dart';

class MainMenu extends StatefulWidget {
  static const String id = 'MainMenu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final NavigationKey = GlobalKey<CurvedNavigationBarState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PackagesData packagesData = new PackagesData();
  int index = 0;
  String uid = "",
      firstname = "",
      lastname = "",
      phoneno = "",
      address = "",
      city = "",
      cnic = "";
  List userProfileList = [];
  late var screens;
  @override
  void initState() {
    //showLoaderDialog(context);
    fetchUserInfo();
    fetchPackageData();
    //Navigator.pop(context);
    super.initState();
    screens = [
      HomePage(),
      SearchProduct(),
      AddProduct(),
      Favourite(),
      ProfileManagement(
          firstname: firstname,
          lastname: lastname,
          phoneno: phoneno,
          address: address,
          city: city,
          uid: uid)
    ];
  }

  fetchUserInfo() async {
    final User user = await _auth.currentUser!;
    uid = user.uid;
    dynamic userData = await DatabaseManager().getCurrentUserData(uid);
    if (userData != null) {
      setState(() {
        firstname = userData[0];
        lastname = userData[1];
        phoneno = userData[2];
        address = userData[3];
        city = userData[4];
      });
    } else {
      print("Error reteriving data from current user data");
    }
    print(firstname + lastname + phoneno + address + city);
  }

  fetchPackageData() async {
    final User user = await _auth.currentUser!;
    uid = user.uid;
    await packagesData.getCurrentUserSinglePackagesDetail(uid, 0);
    //printed:
//    I/flutter (21088): counter running: 0
//    I/flutter (21088): {price0: 35600, uid: YWHeWyyv1YNjZvyFAKxhWB0lT6m2, name1: Suite , name0: Hall, description0: hall has a capacity of 500 persons and can be divided into two portions., price1: 6900, pictures: [https://firebasestorage.googleapis.com/v0/b/hall-bookify.appspot.com/o/YWHeWyyv1YNjZvyFAKxhWB0lT6m2%2FPackage0%2Fimage_picker4582458011361677597.jpg?alt=media&token=92ffb1f3-86ec-44b5-b7bc-65c1dc8d53cd, https://firebasestorage.googleapis.com/v0/b/hall-bookify.appspot.com/o/YWHeWyyv1YNjZvyFAKxhWB0lT6m2%2FPackage0%2Fimage_picker7331333904342445571.jpg?alt=media&token=c3751831-9ed8-4867-b53b-4499cc0c3bfd, https://firebasestorage.googleapis.com/v0/b/hall-bookify.appspot.com/o/YWHeWyyv1YNjZvyFAKxhWB0lT6m2%2FPackage0%2Fimage_picker1464174500567090805.jpg?alt=media&token=3d8a1662-54fd-48e6-8b86-b4bd043fb396], description1: A northern area suite for private weddings and can be used for parties and other purposes.}
//    I/flutter (21088): counter running: 1
//    I/flutter (21088): {price0: 356000, uid: YWHeWyyv1YNjZvyFAKxhWB0lT6m2, name0: Hall 2, description0: hall has a capacity of 500 persons and can be divided into two portions., pictures: [https://firebasestorage.googleapis.com/v0/b/hall-bookify.appspot.com/o/YWHeWyyv1YNjZvyFAKxhWB0lT6m2%2FPackage1%2Fimage_picker6359957767450469050.jpg?alt=media&token=f68e8ad9-00da-4664-a69f-d490ebc565aa]}
    //  I/flutter (21088): Document data not exist in Package 2
//    I/flutter (21088): {price0: 356000, uid: YWHeWyyv1YNjZvyFAKxhWB0lT6m2, name0: Hall 2, description0: hall has a capacity of 500 persons and can be divided into two portions., pictures: [https://firebasestorage.googleapis.com/v0/b/hall-bookify.appspot.com/o/YWHeWyyv1YNjZvyFAKxhWB0lT6m2%2FPackage1%2Fimage_picker6359957767450469050.jpg?alt=media&token=f68e8ad9-00da-4664-a69f-d490ebc565aa]}
  }
  //
  //TODO:  to implement: For admin, if loggedin user role is 'role':'admin' then call fetch database list function
  // fetchDatabaseList() async {
  //   dynamic resultant = await DatabaseManager().getUsersList();
  //   if (resultant == null) {
  //     print("Unable to reterive data");
  //   } else {
  //     userProfileList = resultant;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: MainDrawer(
            uid: uid,
            firstname: firstname,
            lastname: lastname,
            phoneno: phoneno,
            address: address,
            city: city,
            cnic: cnic),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.purple),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(
          'Hall Bookify',
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.purple,
              ))
        ],
      ),
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          key: NavigationKey,
          height: 60,
          color: Colors.purpleAccent,
          backgroundColor: Colors.transparent,
          items: bottomNavItems,
          index: index,
          onTap: (value) {
            setState(() {
              this.index = value;
              //navigate by button to go to pages of curved navigation bar
              //onPressed(){
              //nav key defined at top
              //final NavigationKey = GlobalKey<CurvedNavigationBarState>();
              //final navigationState = navigationKey.currentState!;
              //navigationState = setPage(0);
              //}
            });
          },
        ),
      ),
    );
  }
}
