import 'package:flutter/material.dart';

Widget buildTextField(
    String labelText, String hintText, TextEditingController controler) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
      controller: controler,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    ),
  );
}
