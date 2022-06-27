import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hall_bookify/Screens/mainScreens/ManagementScreens/PackageAvailability.dart';
import 'package:hall_bookify/Screens/mainScreens/ManagementScreens/customerSupport.dart';
import 'package:hall_bookify/Screens/mainScreens/ManagementScreens/packageConfirmation.dart';

class ManagementMainActivity extends StatefulWidget {
  @override
  _ManagementMainActivityState createState() => _ManagementMainActivityState();
}

class _ManagementMainActivityState extends State<ManagementMainActivity> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String loggedinUser = "";

  fetchinfo() async {
    final User user = await _auth.currentUser!;
    setState(() {
      loggedinUser = user.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchinfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "PACKAGE MANAGEMENT",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Container(
                      height: 200,
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print(loggedinUser);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return new PackageConfirmation(
                                        logedinID: loggedinUser);
                                  },
                                ));
                              },
                              child: AnimatedContainer(
                                margin: EdgeInsets.only(bottom: 15.0),
                                duration: Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.download_done_rounded),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Package Confirmation",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.0,
                                            color: Color.fromRGBO(
                                                20, 20, 20, 0.96),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Buyer booking packages can be confirmed by package provider here",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color.fromRGBO(
                                                20, 20, 20, 0.96),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Container(
                      height: 200,
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print(loggedinUser);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return new PackageAvailability(
                                        logedinID: loggedinUser);
                                  },
                                ));
                              },
                              child: AnimatedContainer(
                                margin: EdgeInsets.only(bottom: 15.0),
                                duration: Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.event_available),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Package Availability",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.0,
                                            color: Color.fromRGBO(
                                                20, 20, 20, 0.96),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Stop customer to book package due to no availability",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color.fromRGBO(
                                                20, 20, 20, 0.96),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Container(
                      height: 200,
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return new CustomerSupport();
                                  },
                                ));
                              },
                              child: AnimatedContainer(
                                margin: EdgeInsets.only(bottom: 15.0),
                                duration: Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.support_agent_outlined),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "FAQ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.0,
                                            color: Color.fromRGBO(
                                                20, 20, 20, 0.96),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Added FAQs to help you out or you can talk to our support team",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                            color: Color.fromRGBO(
                                                20, 20, 20, 0.96),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
