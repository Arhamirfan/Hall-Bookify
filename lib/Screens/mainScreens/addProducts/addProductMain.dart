import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:hall_bookify/Models/Services.dart';
import 'package:hall_bookify/Screens/mainScreens/addProducts/addTaskScreen.dart';
import 'package:hall_bookify/Widgets/ServicesList.dart';

class AddProduct extends StatefulWidget {
  // TextEditingController _serviceNameController = TextEditingController();
  // TextEditingController _servicePriceController = TextEditingController();
  // TextEditingController _serviceDescriptionController = TextEditingController();
  // TextEditingController _picturesController = TextEditingController();
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late BuildContext Context;

  void createSnackBar(String message) {
    var snackbar = SnackBar(
        content: Text(message), backgroundColor: Colors.lightBlueAccent);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  void dispose() {
    servicesTask.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('Number of Services added : ${servicesTask.length}' +
                    "\n (Long Press to remove item)"),
                SizedBox(height: 20),
                servicesTask.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Text(
                          'LIST IS EMPTY',
                          style: kmlblueText,
                        ),
                      )
                    : ServicesList(servicesTask: servicesTask),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              //title: Text(title),
                              content: addTaskScreen(addServiceCallback:
                                  (newServiceName, newServicePrice,
                                      newServiceDesc, imageFileList) {
                                setState(() {
                                  servicesTask.add(Services(
                                      name: newServiceName,
                                      price: newServicePrice,
                                      description: newServiceDesc,
                                      images: imageFileList));
                                });
                                createSnackBar(
                                    "Service Added. Click to add more to Package");
//                             var snackBar =
//                                 SnackBar(content: Text('Service Added'));
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackBar);
                              }),
                            );
                          },
                        );
                      },
                      color: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "ADD SERVICE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2,
                            color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        createSnackBar("ADD DATA TO FIRE BASE");
                        // print('package 1');
                        // print('path of 1st pic: ' +
                        //     servicesTask[0].images![0].path);
                        // print('path of 2nd pic: ' +
                        //     servicesTask[0].images![1].path);
                        //result
                        // I/flutter (14629): package 1
                        // I/flutter (14629): path of 1st pic: /data/user/0/com.hallbookify.hall_bookify/cache/image_picker1187040386018176509.jpg
                        // I/flutter (14629): path of 2nd pic: /data/user/0/com.hallbookify.hall_bookify/cache/image_picker8635218453805241586.jpg

                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: Color(0xff757575),
                              child: Container(
                                height: MediaQuery.of(context).size.height * .8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'CONFIRM PACKAGE',
                                      textAlign: TextAlign.center,
                                      style: kmlpurpleboldText,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .4,
                                      child: servicesTask.isEmpty
                                          ? Text(
                                              "List is empty",
                                              style: kmediumgreyText,
                                              textAlign: TextAlign.center,
                                            )
                                          : ListView.builder(
                                              itemCount: servicesTask.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: Image.file(
                                                      File(servicesTask[index]
                                                          .images![0]
                                                          .path),
                                                      fit: BoxFit.cover,
                                                      width: 80),
                                                  title: Text(
                                                      servicesTask[index].name),
                                                  subtitle: Text(
                                                      servicesTask[index]
                                                          .description),
                                                  trailing: Text('PKR ' +
                                                      servicesTask[index]
                                                          .price),
                                                );
                                              },
                                            ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: OutlineButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: RaisedButton(
                                              onPressed: () {},
                                              color: Colors.purple,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                "CONFIRM",
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
                            );
                          },
                        );
                      },
                      color: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "UPLOAD PACKAGE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.deepPurpleAccent,
      //   onPressed: () {
      //     showModalBottomSheet(
      //         context: context,
      //         builder: (context) => addTaskScreen(addServiceCallback:
      //                 (newServiceName, newServicePrice, newServiceDesc) {
      //               setState(() {
      //                 servicesTask.add(Services(
      //                     name: newServiceName,
      //                     price: newServicePrice,
      //                     description: newServiceDesc));
      //               });
      //             }));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

//
// class serviceCard extends StatelessWidget {
//   String title, description, price;
//   serviceCard(
//       {required this.title, required this.description, required this.price});
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                   child: Text('Disini Judul', style: klargeblackboldText),
//                 ),
//                 Container(
//                   child: Text(
//                       'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Container(
//             child: Image.network(
//               'https://picsum.photos/250?image=9',
//               width: 100,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// AlertDialog(
// title: Text("Add Services"),
// content: Column(
// children: [
// buildTextField(
// "Service Name", "Name", _serviceNameController),
// buildTextField(
// "Service Price", "Price", _servicePriceController),
// buildTextField("Service Description", "Description",
// _serviceDescriptionController),
// ],
// ),
// actions: [
// FlatButton(
// child: Text("Close"),
// onPressed: () {
// Navigator.of(context).pop();
// },
// ),
// FlatButton(
// child: Text(
// "SUBMIT",
// style: TextStyle(color: Colors.white),
// ),
// color: Colors.purple,
// onPressed: () {
// // serviceCard(
// //     title: _serviceNameController.text,
// //     description: _serviceDescriptionController.text,
// //     price: _servicePriceController.text);
// },
// )
// ],
// );
