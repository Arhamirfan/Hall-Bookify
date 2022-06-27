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
    await pref.setInt('cartstatus', currentNumber);
  }

  Future<void> decrementCounter() async {
    final pref = await SharedPreferences.getInstance();
    int lastnumber = await getintfromSharedPreference();
    int currentNumber = --lastnumber;
    await pref.setInt('cartstatus', currentNumber);
  }

  Future<void> setValueForCart(int invoicenumber) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('cartstatus', invoicenumber);
  }

  Future<int> getintfromSharedPreference() async {
    final pref = await SharedPreferences.getInstance();
    final startupNumber = pref.getInt('cartstatus');
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  Future<void> resetCounter() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('cartstatus', 0);
  }
}

class sharedPreferenceForReceipt {
  Future<void> incrementCounter() async {
    final pref = await SharedPreferences.getInstance();
    int lastnumber = await getintfromSharedPreference();
    int currentNumber = ++lastnumber;

    if (currentNumber == 2) {
      print("Cannot add more than 1 package to receipt.");
      //resetCounter();
    } else {
      await pref.setInt('receiptinvoice', currentNumber);
    }
  }

  Future<void> setValueForReceipt(int invoicenumber) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('receiptinvoice', invoicenumber);
  }

  Future<int> getintfromSharedPreference() async {
    final pref = await SharedPreferences.getInstance();
    final startupNumber = pref.getInt('receiptinvoice');
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  Future<void> resetCounter() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('receiptinvoice', 0);
  }
}
