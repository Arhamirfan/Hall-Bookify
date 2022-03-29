import 'package:shared_preferences/shared_preferences.dart';

class sharedPreference {
  Future<void> incrementCounter() async {
    final pref = await SharedPreferences.getInstance();
    int lastnumber = await getintfromSharedPreference();
    int currentNumber = ++lastnumber;

    if (currentNumber == 9) {
      print("Cannot add more than 10 products");
      resetCounter();
    } else {
      await pref.setInt('startNumber', currentNumber);
    }
  }

  Future<int> getintfromSharedPreference() async {
    final pref = await SharedPreferences.getInstance();
    final startupNumber = pref.getInt('startNumber');
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  Future<void> resetCounter() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('startNumber', 0);
  }
}

class sharedPreferenceForCart {
  Future<void> incrementCounter() async {
    final pref = await SharedPreferences.getInstance();
    int lastnumber = await getintfromSharedPreference();
    int currentNumber = ++lastnumber;

    if (currentNumber == 2) {
      print("Cannot add more than 1 package to cart.");
      //resetCounter();
    } else {
      await pref.setInt('cartcounter', currentNumber);
    }
  }

  Future<int> getintfromSharedPreference() async {
    final pref = await SharedPreferences.getInstance();
    final startupNumber = pref.getInt('cartcounter');
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  Future<void> resetCounter() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('cartcounter', 0);
  }
}
