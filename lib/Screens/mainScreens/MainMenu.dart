import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:hall_bookify/Controller/MainDrawer.dart';
import 'package:hall_bookify/Models/DatabaseManager.dart';
import 'package:hall_bookify/Screens/HomeScreen/HomePage.dart';
import 'package:hall_bookify/Screens/mainScreens/Favourites/favouritePage.dart';
import 'package:hall_bookify/Screens/mainScreens/SearchProduct/searchProductMain.dart';
import 'package:hall_bookify/Screens/mainScreens/addProducts/addProductMain.dart';
import 'package:hall_bookify/Screens/mainScreens/profileManagement.dart';

class MainMenu extends StatefulWidget {
  static const String id = 'MainMenu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final NavigationKey = GlobalKey<CurvedNavigationBarState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
    fetchUserInfo();
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
