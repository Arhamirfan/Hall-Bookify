import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/loginButtons.dart';
import 'package:hall_bookify/Models/FirebaseService.dart';
import 'package:hall_bookify/Models/phoneAuth.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import 'ageConfirmation.dart';

class nameRegistration extends StatelessWidget {
  nameRegistration({required this.phoneNumber});
  static const String id = 'nameRegistration';
  String first = "", last = "";
  final String phoneNumber;
  var userID = FirebaseAuth.instance.currentUser!.uid;
  late final Function oncontextChanged;
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
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What\'s your name?',
                    style: kmlblackText,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            onChanged: (value) {
                              first =
                                  Provider.of<getnames>(context, listen: false)
                                      .registerNames(value);
                              //todo: add getnames class in main Provider then call function here
                            },
                            decoration: InputDecoration(
                              hintText: 'First',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            onChanged: (value) {
                              last =
                                  Provider.of<getnames>(context, listen: false)
                                      .registerNames(value);
                              //todo: add getnames class in main Provider then call function here
                            },
                            decoration: InputDecoration(
                              hintText: 'Last',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      //edit configurations : add additional requirements: --no-sound-null-safety
                      child: Text('currently logged in user id : $userID'),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width,
                  child: loginButton(
                      buttontext: 'Next',
                      buttonColour: Colors.black,
                      buttontextColour: Colors.white,
                      onpressed: () {
                        try {
                          print(first);
                          print(last);
                          DatabaseService(uid: userID)
                              .registerOrUpdateData2(first, last, phoneNumber);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ageConfirmation(),
                              ));
                        } catch (e) {
                          print(e);
                        }
                      }),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
