import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hall_bookify/Controller/property_card.dart';
import 'package:hall_bookify/Models/FireBaseData/PackagesData.dart';
import 'package:hall_bookify/Screens/mainScreens/HomeScreen/ViewAllPage.dart';
import 'package:hall_bookify/Widgets/input_widget.dart';

class HomePage extends StatelessWidget {
  final String firstname;
  HomePage({required this.firstname});
  TextEditingController _cityController = TextEditingController();
  PackagesData package = new PackagesData();

  @override
  Widget build(BuildContext context) {
    PackagesData tosetlength = new PackagesData();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  firstname != '' ? 'Hello $firstname!' : 'Let\'s get started!',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Pick best, Stay relaxed',
                  style: TextStyle(
                    fontSize: 18.0,
                    height: 1.1,
                    color: Color.fromRGBO(22, 27, 40, 70),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        height: 44.0,
                        hintText: "Search",
                        prefixIcon: FlutterIcons.search1_ant,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      height: 44,
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.purpleAccent,
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                            )),
                        onPressed: () {
                          //Helper.nextScreen(context, Filters());
                        },
                        child: GestureDetector(
                          onTap: () {
                            package.getallPackages();
                          },
                          child: Row(
                            children: [
                              Icon(
                                FlutterIcons.ios_options_ion,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Filters",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Packages",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return new ViewAllPackages(
                                length: tosetlength.totalPackages);
                          },
                        ));
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('AllPackages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print("length of DB collection data");
                        print(snapshot.data!.docs.length);

                        DocumentSnapshot data = snapshot.data!.docs[index];
                        final temp = snapshot.data!.docs[index].data() as Map;
                        tosetlength.totalPackages = snapshot.data!.docs.length;

                        print(temp['uid']);
                        print(temp['package']);
                        return productCard2(temp);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
