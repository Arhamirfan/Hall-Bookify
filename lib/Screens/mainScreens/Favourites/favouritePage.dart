import 'package:flutter/material.dart';

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
              'Empty favourities list\nBrowse Packages to add them to favourities.☺'),
        ),
      ),
    );
  }
}
