import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/loginButtons.dart';
import 'package:hall_bookify/Screens/loginScreens/registerPhoneNameData.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../../Constants.dart';

class phoneOTPverification extends StatefulWidget {
  static const String id = 'phoneOTPverification';
  phoneOTPverification({required this.phoneno});
  final String phoneno;

  @override
  _phoneOTPverificationState createState() => _phoneOTPverificationState();
}

class _phoneOTPverificationState extends State<phoneOTPverification> {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  String _verificationCode = "";
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  int _start = 60;
  late Timer _timer;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  _verifyphone() async {
    await auth.verifyPhoneNumber(
        phoneNumber: widget.phoneno,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              print('successfully logged in automatically');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => nameRegistration(
                      phoneNumber: widget.phoneno,
                    ),
                  ),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          setState(() {
            _verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _verifyphone();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter the 6-digit code send to you at',
                    style: klargeblackText,
                  ),
                  Text(widget.phoneno, style: kxlblackText),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: PinPut(
                      fieldsCount: 6,
                      withCursor: true,
                      textStyle:
                          const TextStyle(fontSize: 25.0, color: Colors.black),
                      eachFieldWidth: 40.0,
                      eachFieldHeight: 55.0,
                      //onSubmit: (String pin) => _showSnackBar(pin),
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: pinPutDecoration,
                      selectedFieldDecoration: pinPutDecoration,
                      followingFieldDecoration: pinPutDecoration,
                      pinAnimationType: PinAnimationType.fade,
                      onSubmit: (pin) {
                        try {
                          auth
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode,
                                      smsCode: pin))
                              .then((value) async {
                            if (value.user != null) {
                              print('logged in manually, can proceed to home');
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => nameRegistration(
                                      phoneNumber: widget.phoneno,
                                    ),
                                  ),
                                  (route) => false);
                            }
                          });
                        } catch (e) {
                          FocusScope.of(context).unfocus();
                          _scaffoldkey.currentState!.showSnackBar(
                              SnackBar(content: Text('invalid OTP')));
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Resend code in 00:$_start',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
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
