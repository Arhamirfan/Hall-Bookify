import 'package:flutter/material.dart';

class phoneAuthentication extends ChangeNotifier {
  String phoneNumber = "";
  String phoneIsoCode = "PK";
  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    phoneNumber = internationalizedPhoneNumber;
    phoneIsoCode = isoCode;
    notifyListeners();
    print(isoCode + phoneNumber);
  }
}

class getnames extends ChangeNotifier {
  late String name;
  bool agerememberMe = false;

  String registerNames(String value) {
    name = value;
    print(name);
    notifyListeners();
    return name;
  }

  void onageRememberMeChanged(bool newValue) {
    // setState(() {
    agerememberMe = newValue;

    if (agerememberMe) {
      //  Here goes your functionality that remembers the user.
    } else {
      // Forget the user
    }
    notifyListeners();
    // });
  }
}
