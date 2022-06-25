import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:hall_bookify/Models/DatabaseOperations.dart';
import 'package:intl/intl.dart';

import '../../../Models/DatabaseCollections.dart';
import '../../../Models/sharedPreference/sharedPreference.dart';
import '../../../Widgets/progressDialog.dart';

class View_Package extends StatefulWidget {
  final Map package_details;
  View_Package(this.package_details);

  @override
  _View_PackageState createState() => _View_PackageState();
}

class _View_PackageState extends State<View_Package> {
  int total = 0, cartnumber = 0;
  double creatorFee = 0, subTotal = 0;
  late DateTime Bookingdate;
  TextEditingController _bookingtimeController = new TextEditingController();
  TextEditingController _totalpersonController = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  sharedPreferenceForCart sharedpreference = new sharedPreferenceForCart();
  String buyer_uid = "", seller_uid = "";
  DatabaseOperations dboperation = new DatabaseOperations();

  fetchinfo() async {
    final User user = await _auth.currentUser!;
    setState(() {
      buyer_uid = user.uid;
    });
  }

  void getCartCount() async {
    int cartno = await sharedpreference.getintfromSharedPreference();
    setState(() {
      cartnumber = cartno;
    });
    //sharedpref.resetCounter();
    print('Shared Preference cart count:' + cartnumber.toString());
  }

  void getSellerData() async {
    seller_uid = widget.package_details['uid'];
    await dboperation.getSellerData(seller_uid);
  }

  @override
  void initState() {
    super.initState();
    fetchinfo();
    getCartCount();
    getSellerData();
    for (int i = 0; i < widget.package_details['price'].length; i++) {
      int value = int.parse(widget.package_details['price'][i]);
      total = total + value;
    }
    creatorFee = total * 0.02;
    subTotal = total + creatorFee;
    print("Total price is : " + total.toString());
    print("Creator Fee : " + creatorFee.toString());
    print("Sub Total : " + subTotal.toString());
  }

  @override
  void dispose() {
    total = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 300),
              child: ImageSlider(context, widget.package_details['pictures']),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.package_details['package'],
                                      overflow: TextOverflow.ellipsis,
                                      style: klargeblackboldText),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          color: Colors.purple),
                                      Text(
                                        widget.package_details['location'],
                                        softWrap: false,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () async {
                                      DatabaseOperations databaseop =
                                          new DatabaseOperations();
                                      databaseop.addToFavourities(
                                          buyer_uid, widget.package_details);
                                      snackBar(context, 'Added to favourities');
                                    },
                                    child: Icon(Icons.favorite_outlined,
                                        color: Colors.red),
                                    style: OutlinedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(5),
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      print('seller id: ' +
                                          dboperation.sellerData['userid']);
                                      print('seller number: ' +
                                          dboperation.sellerData['phoneno']);
                                      whatsappMessage(
                                          number:
                                              dboperation.sellerData['phoneno'],
                                          message:
                                              'Hello sir, I want to know about your package ${widget.package_details['package']}');
                                    },
                                    child: Icon(Icons.whatsapp,
                                        color: Colors.green),
                                    style: OutlinedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(5),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          ListTile(
                            title:
                                Text('Services', style: kmediumblackboldText),
                            trailing:
                                Text('Price', style: kmediumblackboldText),
                          ),
                          Divider(thickness: 0.5),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  widget.package_details['services'].length,
                              itemBuilder: (context, index) {
                                return Container(
                                    child: ListTile(
                                  title: Text(
                                      widget.package_details['services'][index],
                                      style: kmediumblackboldText),
                                  subtitle: Text(
                                      widget.package_details['description']
                                          [index],
                                      style: ksmallgreyText),
                                  trailing: Text('\$' +
                                      widget.package_details['price'][index]),
                                ));
                              },
                            ),
                          ),
                          Divider(thickness: 0.5),
                          Container(
                            height: 25,
                            child: ListTile(
                              title: Text('Total : ', style: kmediumblackText),
                              trailing: Text("\$ " + total.toString(),
                                  style: kmediumblackboldText),
                            ),
                          ),
                          Container(
                            height: 25,
                            child: ListTile(
                              title: Text('Creator Fee : ',
                                  style: kmediumblackText),
                              subtitle: Text('(2% of total payment)'),
                              trailing: Text("\$ " + creatorFee.toString(),
                                  style: kmediumblackboldText),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Divider(thickness: 0.5),
                Container(
                  height: 25,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    title: Text('Sub Total : ', style: kmediumblackboldText),
                    trailing: Text("\$ " + subTotal.toString(),
                        style: kmediumblackboldText),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (buyer_uid != seller_uid) {
                          if (widget.package_details['package_availibility'] !=
                              false) {
                            openBookingDialog();
                          }
                        }
                      },
                      icon: Icon(Icons.shopping_cart),
                      label: buyer_uid == seller_uid
                          ? Text('Error: Same Buyer & Seller')
                          : widget.package_details['package_availibility']
                                      .toString() ==
                                  'false'
                              ? Text('Not available')
                              : cartnumber == 1
                                  ? Text('Cannot Add More To Cart',
                                      style: kmediumwhiteText)
                                  : Text('Add Booking Details',
                                      style: kmediumwhiteText),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: buyer_uid == seller_uid
                              ? Colors.grey
                              : widget.package_details['package_availibility']
                                          .toString() ==
                                      'false'
                                  ? Colors.grey
                                  : cartnumber == 1
                                      ? Colors.grey
                                      : Colors.purpleAccent),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future openBookingDialog() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Text('Booking Details', style: klargeblackboldText),
                    SizedBox(height: 30),
                    Container(
                      height: MediaQuery.of(context).size.height * .3,
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Booking time span',
                                  style: kmediumblackboldText),
                              TextField(
                                controller: _bookingtimeController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        'Afternoon(2pm - 4pm) / Evening(7pm - 9pm)'),
                              ),
                              Text('Booking Time', style: kmediumblackboldText),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  color: Colors.blue,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '${DateFormat.MMMM().format(DateTime.now())}',
                                                    style: kmediumwhiteText,
                                                  ),
                                                  Text('${DateTime.now().day}',
                                                      style:
                                                          kmediumwhiteboldText),
                                                ],
                                              )),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime.now(),
                                              maxTime: DateTime.now()
                                                  .add(Duration(days: 31)),
                                              onConfirm: (days) {
                                            setState(() {
                                              Bookingdate = days;
                                            });
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.calendar_today,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Text('No of people', style: kmediumblackboldText),
                              TextField(
                                controller: _totalpersonController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'eg. 500'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.purpleAccent,
                          ),
                          RaisedButton(
                            onPressed: () {
                              showLoaderDialog(context);
                              DatabaseService dbs =
                                  new DatabaseService(uid: buyer_uid);

                              dbs.addToReview(
                                  buyer_uid,
                                  widget.package_details,
                                  total.toString(),
                                  creatorFee.toString(),
                                  subTotal.toString(),
                                  Bookingdate,
                                  _bookingtimeController.text,
                                  _totalpersonController.text);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              snackBar(context,
                                  "Package added for review. Package will be added to cart once provider approve");

                              setState(() {
                                cartnumber = 1;
                              });
                            },
                            child: Text(
                              "Book Package",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.purpleAccent,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

Swiper ImageSlider(BuildContext context, List<dynamic> images) {
  return new Swiper(
    itemCount: images.length,
//    viewportFraction: 0.8,
    scale: 0.8,
    autoplay: true,
    itemBuilder: (context, index) {
      return new Image.network(
        images[index],
        fit: BoxFit.cover,
      );
    },
  );
}

Container servicesDataContainer(BuildContext context, List<dynamic> serviceName,
    List<dynamic> serviceDescription, List<dynamic> servicePrice) {
  return new Container();
}
