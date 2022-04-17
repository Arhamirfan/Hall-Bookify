import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hall_bookify/Controller/loginButtons.dart';
import 'package:hall_bookify/Models/DatabaseCollections.dart';
import 'package:hall_bookify/Models/FireBaseData/ProfileDatabase.dart';
import 'package:hall_bookify/Models/phoneAuth.dart';
import 'package:hall_bookify/Screens/mainScreens/MainMenu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import 'ageConfirmation.dart';

class AccountVerification extends StatefulWidget {
  AccountVerification({required this.phoneNumber});
  static const String id = 'AccountVerification';
  final String phoneNumber;

  @override
  _AccountVerificationState createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {
  bool isUserAvailable = false;
  var userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    fetchDatabaseList().whenComplete(() async {
      //TODO: if going to main menu then add shared preference before going to main menu
      SharedPreferences sharedpreference =
          await SharedPreferences.getInstance();
      sharedpreference.setString("PHONE", widget.phoneNumber);
      print("Successfully saved PhoneShared Preference before validation");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => isUserAvailable == false
              ? nameRegistration(phoneNumber: widget.phoneNumber)
              : MainMenu()));
    });
  }

  Future fetchDatabaseList() async {
    bool resultant = await DatabaseManager().userExist(userID);
    if (resultant == true) {
      setState(() {
        isUserAvailable = true;
      });
    } else {
      setState(() {
        isUserAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xffffffff),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Checking User Existance ...',
              style: TextStyle(fontSize: 20),
              maxLines: 1,
            ),
            CircularProgressIndicator(
              color: Colors.purpleAccent,
            )
          ],
        ),
      ),
    ));
  }
}

class nameRegistration extends StatelessWidget {
  nameRegistration({required this.phoneNumber});
  static const String id = 'nameRegistration';
  String first = "",
      last = "",
      address = "",
      city = "",
      cnic = "",
      paymentmethod = "";
  final String phoneNumber;
  var userID = FirebaseAuth.instance.currentUser!.uid;
  //late final Function oncontextChanged;
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
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What\'s your name?',
                    style: kmlblackText,
                  ),
                  loginDetailsMethodName(context),
                  SizedBox(height: 20),
                  Text(
                    'Address',
                    style: kmlblackText,
                  ),
                  loginDetailsMethodAddress(context),
                  SizedBox(height: 20),
                  Text(
                    'CNIC',
                    style: kmlblackText,
                  ),
                  loginDetailsMethodcnic(context),
                  SizedBox(height: 20),
                  Text(
                    'Payment Method',
                    style: kmlblackText,
                  ),
                  loginDetailsMethodpayment(context),
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
                          print(address);
                          print(city);
                          print(cnic);
                          print(paymentmethod);
                          DatabaseService(uid: userID)
                              .registerCustomer(first, last, phoneNumber,
                                  address, city, cnic, userID, paymentmethod)
                              .then((value) async {
                            // SharedPreferences sharedpreference =
                            //     await SharedPreferences.getInstance();
                            // sharedpreference.setString("PHONE", phoneNumber);
                            // print("Successfully saved PhoneShared Preference");
                          });

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

  Row loginDetailsMethodName(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              onChanged: (value) {
                first = Provider.of<getnames>(context, listen: false)
                    .registerNames(value);
              },
              decoration: InputDecoration(
                hintText: 'First',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
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
                last = Provider.of<getnames>(context, listen: false)
                    .registerNames(value);
              },
              decoration: InputDecoration(
                hintText: 'Last',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row loginDetailsMethodAddress(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              onChanged: (value) {
                address = Provider.of<getnames>(context, listen: false)
                    .registerNames(value);
              },
              decoration: InputDecoration(
                hintText: '123/A Faisal Town',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              onChanged: (value) {
                city = Provider.of<getnames>(context, listen: false)
                    .registerNames(value);
              },
              decoration: InputDecoration(
                hintText: 'Lahore',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row loginDetailsMethodcnic(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              maxLength: 13,
              onChanged: (value) {
                cnic = Provider.of<getnames>(context, listen: false)
                    .registerNames(value);
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                hintText: 'XXXXX-XXXXXXX-X',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row loginDetailsMethodpayment(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              maxLength: 42,
              onChanged: (value) {
                paymentmethod = Provider.of<getnames>(context, listen: false)
                    .registerNames(value);
              },
              decoration: InputDecoration(
                hintText: '0xd486bA9998DA2d69CfcdCAf4cCe50Fdd99F77c71',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
