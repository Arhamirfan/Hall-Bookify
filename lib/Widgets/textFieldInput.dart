import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

Widget buildTextFieldNumber(
    String labelText, String hintText, TextEditingController controler) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
      controller: controler,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

Widget buildTextFieldMultiline(
    String labelText, String hintText, TextEditingController controler) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
      controller: controler,
      keyboardType: TextInputType.multiline,
      minLines: 1, //Normal textInputField will be displayed
      maxLines: 15,
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

Widget buildTextFieldNoPadding(
    String labelText, String hintText, TextEditingController controler) {
  return TextField(
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
  );
}

Widget buildTextFieldNumberNoPadding(
    String labelText, String hintText, TextEditingController controler) {
  return TextField(
    controller: controler,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
  );
}
