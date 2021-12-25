import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/MainDrawer.dart';
import 'package:hall_bookify/Controller/loginButtons.dart';
import 'package:hall_bookify/Models/DatabaseManager.dart';
import 'package:hall_bookify/Screens/loginScreens/SplashScreen.dart';
import 'package:hall_bookify/Screens/loginScreens/getStartedScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  static const String id = 'MainMenu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = "",
      firstname = "",
      lastname = "",
      phoneno = "",
      address = "",
      city = "",
      cnic = "";
  List userProfileList = [];
  @override
  void initState() {
    fetchUserInfo();
    super.initState();
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
    print(" It is also working...");
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
      body: Container(
        color: Color(0xffffffff),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the Main Menu Page',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 10.0, left: 25, right: 25),
                child: Container(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width,
                  child: loginButton(
                      buttontext: 'LOGOUT',
                      buttonColour: Colors.black,
                      buttontextColour: Colors.white,
                      onpressed: () async {
                        final SharedPreferences sharedpreference =
                            await SharedPreferences.getInstance();
                        sharedpreference.remove('PHONE');
                        //TODO: also apply check for facebook and google login
                        Navigator.popUntil(
                            context, ModalRoute.withName(SplashScreen.id));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => getStartedScreen()));
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
