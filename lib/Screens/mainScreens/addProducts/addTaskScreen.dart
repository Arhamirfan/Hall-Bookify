import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hall_bookify/Constants.dart';

class addTaskScreen extends StatelessWidget {
  TextEditingController _serviceNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Add Service',
                textAlign: TextAlign.center,
                style: kmlblackboldText,
              ),
              // buildTextField('labelText', 'hintText', _serviceNameController),
              TextField(),
              FlatButton(
                onPressed: () {},
                child: Text(
                  'ADD',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.purple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
