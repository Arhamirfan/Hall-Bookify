import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:hall_bookify/Models/FacebookLogin.dart';
import 'package:hall_bookify/Models/GoogleLogin.dart';
import 'package:hall_bookify/Screens/loginScreens/registerSocialMediaData.dart';
import 'package:provider/provider.dart';

class registerSocialMedia extends StatelessWidget {
  static const String id = 'registerSocialMedia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Provider.of<Facebooklogin>(context).fblogOut();
              //Navigator.pop(context);
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
                    'Choose an account',
                    style: kmlblackText,
                  ),
                  ListTile(
                    onTap: () {
                      //todo: add loading
                      try {
                        final provider =
                            Provider.of<Facebooklogin>(context, listen: false);
                        provider.fblogin().whenComplete(() {
                          String firstname = provider.firstname;
                          String lastname = provider.lastname;
                          String email = provider.email;
                          // print(firstname);
                          // print(lastname);
                          // print(email);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return registerSocialMediaData(
                                  firstname: firstname,
                                  lastname: lastname,
                                  email: email);
                            },
                          ));
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    leading: SizedBox(
                      height: 25,
                      width: 25,
                      child: FaIcon(
                        FontAwesomeIcons.facebookSquare,
                        color: Colors.blueAccent,
                      ),
                    ),
                    title: Text('Facebook'),
                  ),
                  ListTile(
                    onTap: () {
                      try {
                        final provider =
                            Provider.of<Googlelogin>(context, listen: false);
                        provider.googlelogin().whenComplete(() {
                          final user = FirebaseAuth.instance.currentUser!;
                          final fullname = user.displayName;
                          final emaill = user.email;
                          var names = fullname!.split(' ');
                          print(
                              "Length of names  : " + names.length.toString());
                          String firstname = names[0];
                          String lastname = names[1];
                          String email = emaill!;
                          print("First Name : " + firstname);
                          print("last Name : " + lastname);
                          print("Full name : " + fullname);
                          print("Email : " + email);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return registerSocialMediaData(
                                  firstname: firstname,
                                  lastname: lastname,
                                  email: email);
                            },
                          ));
                        });
                        //final ptanai = user.
                        //Navigator.pushNamed(context, registerSocialMediaData.id);
                      } catch (e) {
                        print(e);
                      }
                    },
                    leading: SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.asset('assets/images/google_icon.png',
                          fit: BoxFit.cover),
                    ),
                    // FaIcon(
                    //   FontAwesomeIcons.google,
                    //   color: Colors.greenAccent,
                    // ),
                    title: Text('Google'),
                  ),
                  Text(
                    'By clicking you may receive an SMS for verification. Message and data rates may apply.',
                    style: kmediumblackText,
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
