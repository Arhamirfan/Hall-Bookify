import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/loginButtons.dart';
import 'package:hall_bookify/Models/phoneAuth.dart';
import 'package:hall_bookify/Screens/loginScreens/phoneOTPverification.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';

class registerSocialMediaData extends StatelessWidget {
  static const String id = 'registerSocialMediaData';

  registerSocialMediaData(
      {required this.firstname, required this.lastname, required this.email});

  final String firstname, lastname, email;
  @override
  Widget build(BuildContext context) {
    String phoneNumber = Provider.of<phoneAuthentication>(context).phoneNumber;
    String phoneIsoCode =
        Provider.of<phoneAuthentication>(context).phoneIsoCode;
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
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm your information',
                    style: kmlblackText,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            readOnly: true,
                            controller: TextEditingController()
                              ..text = firstname,
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
                            readOnly: true,
                            controller: TextEditingController()
                              ..text = lastname,
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      readOnly: true,
                      controller: TextEditingController()..text = email,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: InternationalPhoneInput(
                      onPhoneNumberChange:
                          Provider.of<phoneAuthentication>(context)
                              .onPhoneNumberChange,
                      initialPhoneNumber: phoneNumber,
                      initialSelection: phoneIsoCode,
                      showCountryCodes: true,
                      hintText: '3206522050',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 6,
                          child: Wrap(
                            children: [
                              smagePrivacyChecker,
                            ],
                          )),
                      Expanded(
                        flex: 2,
                        child: loginButton(
                            buttontext: '→',
                            buttonColour: Colors.black,
                            buttontextColour: Colors.white,
                            onpressed: () {
                              if (phoneNumber != "") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return phoneOTPverification(
                                        phoneno: phoneNumber);
                                  },
                                ));
                                print('goto next screen and verify phone no');
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
