import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/loginButtons.dart';
import 'package:hall_bookify/Models/phoneAuth.dart';
import 'package:hall_bookify/Screens/loginScreens/phoneOTPverification.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import 'registerSocialMedia.dart';

class registerPhone extends StatelessWidget {
  static const String id = 'registerPhone';

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
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your mobile number',
                    style: kmlblackboldText,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, registerSocialMedia.id);
                      },
                      child: Text(
                        'Or connect with social →',
                        maxLines: 1,
                        style: klargeblueText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'By continuing you may receive an SMS for verification. Message and data rates may apply.',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width,
                      child: loginButton(
                        buttontext: 'Next',
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
                            print('Verifying phone no ..');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
