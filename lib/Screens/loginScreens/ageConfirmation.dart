import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/loginButtons.dart';
import 'package:hall_bookify/Models/phoneAuth.dart';
import 'package:hall_bookify/Screens/mainScreens/MainMenu.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';

class ageConfirmation extends StatelessWidget {
  static const String id = 'ageConfirmation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 55.0, left: 25, right: 25, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                        child: Image.asset('assets/images/taskslist.png')),
                  ),
                  // Text(
                  //   'Choose an account',
                  //   style: kmlblackText,
                  // ),
                  Expanded(
                    child: ListTile(
                      title: agePrivacyChecker,
                      //Text('Check the box to indicate you\n are at least 18 years of age,\n agree to the Terms &\n Conditions and acknowledge\n the Private Policy.'),
                      trailing: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        value: Provider.of<getnames>(context).agerememberMe,
                        onChanged: (value) {
                          Provider.of<getnames>(context, listen: false)
                              .onageRememberMeChanged(value!);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width,
                  child: Provider.of<getnames>(context).agerememberMe == true
                      ? loginButton(
                          buttontext: 'Next',
                          buttonColour: Colors.black,
                          buttontextColour: Colors.white,
                          onpressed: () {
                            try {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainMenu(),
                                  ),
                                  (route) => false);
                            } catch (e) {
                              print(e);
                            }
                          })
                      : loginButton(
                          buttontext: 'Next',
                          buttonColour: Colors.white,
                          buttontextColour: Colors.grey,
                          onpressed: () {}),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
