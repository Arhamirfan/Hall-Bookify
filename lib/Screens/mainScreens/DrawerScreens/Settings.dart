import 'package:flutter/material.dart';
import 'package:hall_bookify/Screens/mainScreens/ManagementScreens/customerSupport.dart';

import '../ManagementScreens/PackageAvailability.dart';
import '../ManagementScreens/packageConfirmation.dart';
import '../SearchProduct/Searches/ViewAllPackages.dart';
import '../profileManagement.dart';

class SettingsScreen extends StatelessWidget {
  var uid;
  String firstname, lastname, phoneno, address, city;
  SettingsScreen(
      {required this.uid,
      required this.firstname,
      required this.lastname,
      required this.phoneno,
      required this.address,
      required this.city});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Icon(Icons.person_outline),
                    SizedBox(width: 10),
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                        title: Text('Profile management'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ProfileManagement(
                                  firstname: firstname,
                                  lastname: lastname,
                                  phoneno: phoneno,
                                  address: address,
                                  city: city,
                                  uid: uid);
                            },
                          ));
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.card_travel),
                    SizedBox(width: 10),
                    Text(
                      "Packages",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                        title: Text('View packages'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return new ViewAllPackages(length: 6);
                            },
                          ));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                        title: Text('Confirm package request'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          print('Package owner: ' + uid);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return new PackageConfirmation(logedinID: uid);
                            },
                          ));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                        title: Text('Change package availability'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          print('Package owner: ' + uid);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return new PackageAvailability(logedinID: uid);
                            },
                          ));
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.question_answer_outlined),
                    SizedBox(width: 10),
                    Text(
                      "Support",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                        title: Text('FAQ'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return new CustomerSupport();
                            },
                          ));
                        },
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
