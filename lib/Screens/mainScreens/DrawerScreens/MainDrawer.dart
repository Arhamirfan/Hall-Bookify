import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:hall_bookify/Screens/loginScreens/SplashScreen.dart';
import 'package:hall_bookify/Screens/loginScreens/getStartedScreen.dart';
import 'package:hall_bookify/Screens/mainScreens/Cart/Cart.dart';
import 'package:hall_bookify/Screens/mainScreens/DrawerScreens/orderStatus.dart';
import 'package:hall_bookify/Screens/mainScreens/Favourites/FavouriteProducts.dart';
import 'package:hall_bookify/Screens/mainScreens/profileManagement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/sharedPreference/sharedPreference.dart';

class MainDrawer extends StatelessWidget {
  var uid;
  String firstname, lastname, phoneno, address, city, cnic;
  MainDrawer(
      {required this.uid,
      required this.firstname,
      required this.lastname,
      required this.phoneno,
      required this.address,
      required this.city,
      required this.cnic});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFBF36F6),
                      Color(0xFF9D3FDB),
                      Color(0xFF5253A3),
                    ],
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .3,
                padding: EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Material(
                                  color: Colors.transparent, // Button color
                                  child: InkWell(
                                    splashColor: Colors.grey, // Splash color
                                    onTap: () {},
                                    child: SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: Icon(Icons.person,
                                            color: Colors.white, size: 50)),
                                  ),
                                ),
                              ),
                              //Text('Image', style: kmediumwhiteText),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(firstname + " " + lastname,
                                    style: klargewhiteText),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(thickness: 1, color: Colors.grey),
                      GestureDetector(
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
                        child: ListTile(
                          leading: Icon(Icons.person_outline_sharp,
                              color: Colors.white),
                          title: Text('Profile', style: kmediumwhiteText),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Other Tabs',
                          style: kmediumblackText,
                        ),
                        ListTile(
                            leading: Icon(Icons.favorite_outline_rounded,
                                color: Colors.purpleAccent),
                            title: Text(
                              'Favourities',
                              style: kmediumblackText,
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return FavouriteProducts(loggedinUser: uid);
                                },
                              ));
                            }),
                        ListTile(
                            leading: Icon(Icons.shopping_cart_outlined,
                                color: Colors.purpleAccent),
                            title: Text(
                              'Cart',
                              style: kmediumblackText,
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Cart();
                                },
                              ));
                            }),
                        ListTile(
                            leading: Icon(Icons.shopping_basket_outlined,
                                color: Colors.purpleAccent),
                            title: Text(
                              'Order Status',
                              style: kmediumblackText,
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return orderStatus();
                                },
                              ));
                            }),
                        ListTile(
                            leading: Icon(Icons.help_outline,
                                color: Colors.purpleAccent),
                            title: Text(
                              'Help Center',
                              style: kmediumblackText,
                            ),
                            onTap: () {}),
                        SizedBox(height: 20),
                        Text(
                          'Settings',
                          style: kmediumblackText,
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            //empty phone logged in info in shared preference
                            final SharedPreferences sharedpreference =
                                await SharedPreferences.getInstance();
                            sharedpreference.remove('PHONE');

                            //empty cart..
                            sharedPreferenceForCart sharedprefer =
                                new sharedPreferenceForCart();
                            sharedprefer.resetCounter();
                            var collection =
                                FirebaseFirestore.instance.collection('Cart');
                            var snapshots = await collection.get();
                            for (var doc in snapshots.docs) {
                              await doc.reference.delete();
                            }
                            //exit app previous screens
                            Navigator.popUntil(
                                context, ModalRoute.withName(SplashScreen.id));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => getStartedScreen()));
                          },
                          child: Text(
                            'Logout',
                            style: kmediumblackText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(thickness: 2),
                  Text(
                    'Stay Connected With Hall Bookify',
                    style: kmediumblackText,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Legal',
                        style: kmediumblackText,
                      ),
                      Text(
                        'v1.00',
                        style: kmediumgreyText,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
