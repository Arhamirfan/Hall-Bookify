import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:hall_bookify/Models/DatabaseOperations.dart';
import 'package:hall_bookify/Screens/mainScreens/MainMenu.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../../Models/FireBaseData/PackagesData.dart';
import '../../../Models/FireBaseData/ProfileDatabase.dart';
import '../../../Models/sharedPreference/sharedPreference.dart';

class orderStatus extends StatefulWidget {
  @override
  _orderStatusState createState() => _orderStatusState();
}

class _orderStatusState extends State<orderStatus> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PackagesData packagesData = new PackagesData();
  int index = 0, cartnumber = 0, receiptnumber = 0;
  String payment_status = "pending";
  String packagename = "";
  String uid = "",
      firstname = "",
      lastname = "",
      phoneno = "",
      address = "",
      city = "",
      cnic = "";
  sharedPreferenceForReceipt sharedpreferenceforreceipt =
      new sharedPreferenceForReceipt();
  sharedPreferenceForCart sharedpreferenceforcart =
      new sharedPreferenceForCart();
  DatabaseOperations dboperation = new DatabaseOperations();

  fetchUserInfo() async {
    final User user = await _auth.currentUser!;
    uid = user.uid;
    dynamic userData = await DatabaseManager().getCurrentUserData(uid);
    if (userData != null) {
      setState(() {
        firstname = userData[0];
        lastname = userData[1];
        phoneno = userData[2];
        address = userData[3];
        city = userData[4];
      });
    } else {
      print("Error reteriving data from current user data");
    }
    print(firstname + lastname + phoneno + address + city);
  }

  void getCartCount() async {
    int cartno = await sharedpreferenceforcart.getintfromSharedPreference();
    setState(() {
      cartnumber = cartno;
    });
    print('Shared Preference cart value:' + cartnumber.toString());
  }

  void getReceiptCount() async {
    int receiptno =
        await sharedpreferenceforreceipt.getintfromSharedPreference();
    setState(() {
      receiptnumber = receiptno;
    });
    //sharedpref.resetCounter();
    print('Shared Preference receipt value:' + receiptnumber.toString());
  }

  void getReceiptData() async {
    int receiptno =
        await sharedpreferenceforreceipt.getintfromSharedPreference();
    await dboperation.getReceiptData(receiptno.toString());
    setState(() {
      payment_status = dboperation.receiptData['status'];
      packagename = dboperation.receiptData['package'];
    });
  }

  void show() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return RatingDialog(
              title: Text('HALL BOOKIFY',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              message: Text('Give Seller Ratings', textAlign: TextAlign.center),
              image: Image.asset('assets/images/fyplogocolored.png',
                  width: 100, height: 100),
              submitButtonText: 'SUBMIT',
              onSubmitted: (response) async {
                print('Ratings given:  ' + response.rating.toString());
                print('Comments given:  ' + response.comment.toString());
                await dboperation.getpackageDataAndAddRatings(
                    packagename, response.rating, response.comment);
              });
        });
  }

  @override
  void initState() {
    fetchUserInfo();
    getCartCount();
    getReceiptCount();
    getReceiptData();
    super.initState();
  }

  @override
  void dispose() {
    cartnumber = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (c) => MainMenu()),
                            (route) => false);
                      },
                      icon: Icon(Icons.clear))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ORDER STATUS', style: kmlblackboldText),
                    Container(
                        width: 100,
                        child:
                            Divider(thickness: 3, color: Colors.purpleAccent)),
                    SizedBox(height: 30),
                    ListTile(
                      leading: cartnumber == 0
                          ? Icon(Icons.check_circle_outline, color: Colors.grey)
                          : Icon(Icons.check_circle,
                              color: Colors.purpleAccent),
                      title: Text(
                          cartnumber == 0
                              ? 'Cart is Empty'
                              : 'Package available in Cart',
                          style: klargeblackText),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: receiptnumber == 0
                          ? Icon(Icons.check_circle_outline, color: Colors.grey)
                          : Icon(Icons.check_circle,
                              color: Colors.purpleAccent),
                      title: Text(
                          receiptnumber == 0
                              ? 'Order receipt not generated'
                              : 'Order Booked',
                          style: klargeblackText),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: payment_status == 'pending'
                          ? Icon(Icons.check_circle_outline, color: Colors.grey)
                          : Icon(Icons.check_circle,
                              color: Colors.purpleAccent),
                      title: Text(
                          payment_status == 'pending'
                              ? 'Payment pending'
                              : 'Payment completed',
                          style: klargeblackText),
                    ),
                    SizedBox(height: 40),
                    Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            //when done..
                            if (payment_status == 'Paid') {
                              show();
                              await sharedpreferenceforreceipt.resetCounter();
                            } else {
                              snackBar(context, 'Complete order payment first');
                            }
                          },
                          icon: Icon(Icons.star_half),
                          label: Text(
                              payment_status == 'Paid'
                                  ? 'Proceed To Ratings'
                                  : 'Uncompleted Order',
                              style: kmediumwhiteText),
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: payment_status == 'Paid'
                                  ? Colors.purpleAccent
                                  : Colors.grey),
                        ))
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    ));
  }
}
