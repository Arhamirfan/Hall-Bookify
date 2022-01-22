import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hall_bookify/Controller/property_card.dart';
import 'package:hall_bookify/Models/Products.dart';
import 'package:hall_bookify/Widgets/input_widget.dart';

class HomePage extends StatelessWidget {
  //TODO: Make constructor here and pass name of loggedin user and after converting map to product class pass that too in constructor..
  @override
  Widget build(BuildContext context) {
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
                  'Hello \$user!',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Let\'s find the best for you',
                  style: TextStyle(
                    fontSize: 22.0,
                    height: 1.3,
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
                      "New Properties",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                //TODO: get data in main menu and add map to product array list then make a streambuilder or here instead of listview.seperated
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 15.0,
                    );
                  },
                  itemCount: sampleProperties.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return productCard(
                      sampleProperties[index],
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

//Button for logout
// Flexible(
//   child: Padding(
//     padding:
//         const EdgeInsets.only(bottom: 10.0, left: 25, right: 25),
//     child: Container(
//       height: MediaQuery.of(context).size.height * .08,
//       width: MediaQuery.of(context).size.width,
//       child: loginButton(
//           buttontext: 'LOGOUT',
//           buttonColour: Colors.black,
//           buttontextColour: Colors.white,
//           onpressed: () async {
//             final SharedPreferences sharedpreference =
//                 await SharedPreferences.getInstance();
//             sharedpreference.remove('PHONE');
//             //TODO: also apply check for facebook and google login
//             Navigator.popUntil(
//                 context, ModalRoute.withName(SplashScreen.id));
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => getStartedScreen()));
//           }),
//     ),
//   ),
// )
