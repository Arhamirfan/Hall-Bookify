import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/loginButtons.dart';
import 'package:hall_bookify/Screens/loginScreens/SplashScreen.dart';
import 'package:hall_bookify/Screens/loginScreens/getStartedScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatelessWidget {
  static const String id = 'MainMenu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        //TODO: also apply check fir facebook and google login
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
