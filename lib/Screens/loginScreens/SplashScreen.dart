import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hall_bookify/Screens/mainScreens/MainMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'getStartedScreen.dart';

String savedPhoneData = "";

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //todo : convert stateful to stateless. Ask if (init can be converted to Provider).
  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                savedPhoneData == "" ? getStartedScreen() : MainMenu()));
      });
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedPhoneNumber = sharedPreferences.getString("PHONE");
    setState(() {
      savedPhoneData = obtainedPhoneNumber!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFFBF36F6),
              Color(0xFF9D3FDB),
              Color(0xFF5253A3),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * .5,
                  child: Image.asset(
                    'assets/images/fyplogo.png',
                    //color: Colors.white,
                  ),
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
