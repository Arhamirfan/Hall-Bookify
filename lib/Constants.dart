import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final BoxDecoration pinPutDecoration = BoxDecoration(
  color: Colors.white,
  border: Border(
      bottom: BorderSide(
    color: Colors.black,
    width: 3.0,
  )),
);

var agePrivacyChecker = new RichText(
  text: new TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style:
        new TextStyle(fontFamily: 'Gudea', color: Colors.black, fontSize: 20),
    children: <TextSpan>[
      TextSpan(
          text:
              'Check the box to indicate you are at least 18 years of age, agree to the '),
      TextSpan(
          text: 'Terms & Conditions ',
          recognizer: TapGestureRecognizer()
            ..onTap = () => print('terms and conditions'),
          style: TextStyle(color: Colors.blue)),
      TextSpan(text: 'and acknowledge the '),
      TextSpan(
          text: 'Private Policy.',
          recognizer: TapGestureRecognizer()
            ..onTap = () => print('privacy policy'),
          style: TextStyle(color: Colors.blue)),
    ],
  ),
);
var smagePrivacyChecker = new RichText(
  text: new TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: new TextStyle(fontFamily: 'Gudea', color: Colors.black),
    children: <TextSpan>[
      TextSpan(
          text: 'By continuing, I confirm that i have read and agree to the '),
      TextSpan(
          text: 'Terms & Conditions ',
          recognizer: TapGestureRecognizer()
            ..onTap = () => print('terms and conditions'),
          style: TextStyle(color: Colors.blue)),
      TextSpan(text: 'and '),
      TextSpan(
          text: 'Private Policy.',
          recognizer: TapGestureRecognizer()
            ..onTap = () => print('privacy policy'),
          style: TextStyle(color: Colors.blue)),
    ],
  ),
);

final bottomNavItems = [
  Icon(Icons.home, size: 30),
  Icon(Icons.search, size: 30),
  Icon(Icons.add, size: 30),
  Icon(Icons.favorite, size: 30),
  Icon(Icons.person, size: 30)
];

void snackBar(BuildContext context, String message) {
  var snackbar =
      SnackBar(content: Text(message), backgroundColor: Colors.lightBlueAccent);
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void whatsappMessage({required number, required message}) async {
  String url = "https://wa.me/${number}?text=${message}";
  await canLaunch(url) ? launch(url) : print('Cannot open whatsapp');
}

const ksmallText = TextStyle(fontSize: 10);
const kmediumText = TextStyle(fontSize: 15);
const klargeText = TextStyle(fontSize: 20);
const kxlText = TextStyle(fontSize: 25);

const ksmallwhiteText = TextStyle(color: Colors.white, fontSize: 10);
const kmediumwhiteText = TextStyle(color: Colors.white, fontSize: 15);
const klargewhiteText = TextStyle(color: Colors.white, fontSize: 20);
const klargewhiteboldText =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
const kmlwhiteText = TextStyle(color: Colors.white, fontSize: 25);
const kxlwhiteText = TextStyle(color: Colors.white, fontSize: 30);
const kxxlwhiteText = TextStyle(color: Colors.white, fontSize: 40);
const kxxxlwhiteText = TextStyle(color: Colors.white, fontSize: 50);

const ksmallblackText = TextStyle(color: Colors.black, fontSize: 10);
const kmediumblackText = TextStyle(color: Colors.black, fontSize: 15);
const kmediumblackboldText =
    TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
const klargeblackText = TextStyle(color: Colors.black, fontSize: 20);
const klargeblackboldText =
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
const kmlblackText = TextStyle(color: Colors.black, fontSize: 25);
const kmlblackboldText =
    TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
const kxlblackText = TextStyle(color: Colors.black, fontSize: 30);
const kxxlblackText = TextStyle(color: Colors.black, fontSize: 40);
const kxxxlblackText = TextStyle(color: Colors.black, fontSize: 50);

const ksmallgreyText = TextStyle(color: Colors.black54, fontSize: 12);
const kmediumgreyText = TextStyle(color: Colors.grey, fontSize: 15);
const klargegreyText = TextStyle(color: Colors.grey, fontSize: 20);

const klargeblueText =
    TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold);
const kmlblueText = TextStyle(color: Colors.blue, fontSize: 25);

const ksmallpurpleText = TextStyle(color: Colors.purple, fontSize: 10);
const kmediumpurpleText = TextStyle(color: Colors.purple, fontSize: 15);
const klargepurpleText = TextStyle(color: Colors.purple, fontSize: 20);
const klargepurpleboldText =
    TextStyle(color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold);
const kmlpurpleText = TextStyle(color: Colors.purple, fontSize: 25);
const kmlpurpleboldText =
    TextStyle(color: Colors.purple, fontSize: 25, fontWeight: FontWeight.bold);
