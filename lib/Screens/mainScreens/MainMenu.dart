import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  static const String id = 'MainMenu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff000000),
        child: Center(
          child: Text('This is the Main Menu Page'),
        ),
      ),
    );
  }
}
