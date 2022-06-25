import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:hall_bookify/Screens/mainScreens/Favourites/FavouriteProducts.dart';

class Favourite extends StatefulWidget {
  String userid;
  Favourite({required this.userid});
  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String loggedinUser = "";

  fetchinfo() async {
    final User user = await _auth.currentUser!;
    setState(() {
      loggedinUser = user.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchinfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Favourite Packages",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final User user = await _auth.currentUser!;
                      setState(() {
                        loggedinUser = user.uid;
                      });
                      print(loggedinUser);
                    },
                    child: Text(
                      "Reload",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromRGBO(255, 136, 0, 1),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Click button below to retrieve Favourite packages.'),
                    FlatButton(
                      onPressed: () async {
                        await fetchinfo();
                        print(loggedinUser);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return FavouriteProducts(
                                loggedinUser: loggedinUser);
                          },
                        ));
                      },
                      child: Text('Get Packages', style: kmediumwhiteText),
                      color: Colors.purpleAccent,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
