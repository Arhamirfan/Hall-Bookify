import 'package:flutter/material.dart';

import '../Constants.dart';

class startediconButton extends StatelessWidget {
  startediconButton({required this.buttontext, required this.onpressed});

  final String buttontext;
  final Function onpressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // begin: Alignment.topLeft,
          // end: Alignment.bottomRight,
          colors: [
            Color(0xFFBF36F6),
            Color(0xFF9D3FDB),
            Color(0xFF5253A3),
          ],
        ),
      ),
      child: FlatButton(
          onPressed: onpressed as void Function()?,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    buttontext,
                    style: klargewhiteText,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )
            ],
          )),
    );
  }
}

class loginButton extends StatelessWidget {
  loginButton(
      {required this.buttontext,
      required this.onpressed,
      required this.buttonColour,
      required this.buttontextColour});

  final String buttontext;
  final Color buttonColour;
  final Color buttontextColour;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // begin: Alignment.topLeft,
          // end: Alignment.bottomRight,
          colors: [
            Color(0xFFBF36F6),
            Color(0xFF9D3FDB),
            Color(0xFF5253A3),
          ],
        ),
      ),
      child: FlatButton(
          onPressed: onpressed as void Function()?,
          //color: buttonColour,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    buttontext,
                    style: TextStyle(
                      color: buttontextColour,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
