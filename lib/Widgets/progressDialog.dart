import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
// USAGE
//
// on button click when api is called, call this method like this
//
// onPressed: () {
// showLoaderDialog(context);
// //api here },
// and when response is fetched dismiss that dialog like this
//
// Navigator.pop(context);
