import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/textFieldInput.dart';
import 'package:hall_bookify/Models/ProfileDatabase.dart';
import 'package:hall_bookify/Screens/loginScreens/getStartedScreen.dart';
import 'package:hall_bookify/Screens/mainScreens/MainMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileManagement extends StatelessWidget {
  static const String id = 'ProfileManagement';
  String firstname, lastname, phoneno, address, city, uid;
  ProfileManagement(
      {required this.firstname,
      required this.lastname,
      required this.phoneno,
      required this.address,
      required this.city,
      required this.uid});
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  bool showPassword = false;

  updateData(
      String firstname, String lastname, String address, String city) async {
    await DatabaseManager()
        .updateUserData(firstname, lastname, address, city, uid);
  }

  deleteData(String uid) async {
    await DatabaseManager().deleteUser(uid);
    final SharedPreferences sharedpreference =
        await SharedPreferences.getInstance();
    sharedpreference.remove('PHONE');
  }

  submitAction(BuildContext context) {
    updateData(_firstnameController.text, _lastnameController.text,
        _addressController.text, _cityController.text);
    _firstnameController.clear();
    _lastnameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   elevation: 1,
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: Icon(
      //         Icons.arrow_back,
      //         color: Colors.purple,
      //       )),
      //   actions: [],
      // ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () {
                        deleteData(uid);
                        openDialogBox(
                            context,
                            'Profile Delete',
                            'Successfully deleted profile.',
                            () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => getStartedScreen(),
                                ),
                                (route) => false));
                        print("Profile Deleted");
                      },
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Colors.purple,
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/profilemanagement.png'))),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("First Name", firstname, _firstnameController),
              buildTextField("Second Name", lastname, _lastnameController),
              buildTextField("Address", address, _addressController),
              buildTextField("City", city, _cityController),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2,
                                color: Colors.black)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RaisedButton(
                        onPressed: () {
                          print("Submitting the following action: Updating..");
                          print(_firstnameController.text);
                          print(_lastnameController.text);
                          print(_addressController.text);
                          print(_cityController.text);
                          submitAction(context);
                          openDialogBox(
                              context,
                              'Profile Update',
                              'Successfully updated.',
                              () => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainMenu(),
                                  ),
                                  (route) => false));
                        },
                        color: Colors.purple,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "UPDATE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  openDialogBox(
      BuildContext context, String title, String content, Function function) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Wrap(
            children: [
              Container(child: Text(content)),
            ],
          ),
          actions: [
            FlatButton(
                color: Colors.purple,
                onPressed: () {
                  try {
                    function();
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        );
      },
    );
  }
}
