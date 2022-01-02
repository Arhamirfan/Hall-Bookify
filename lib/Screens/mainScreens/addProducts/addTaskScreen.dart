import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:hall_bookify/Controller/textFieldInput.dart';
import 'package:image_picker/image_picker.dart';

class addTaskScreen extends StatefulWidget {
  final Function addServiceCallback;

  addTaskScreen({required this.addServiceCallback});

  @override
  _addTaskScreenState createState() => _addTaskScreenState();
}

class _addTaskScreenState extends State<addTaskScreen> {
  TextEditingController _serviceNameController = TextEditingController();
  TextEditingController _serviceDescController = TextEditingController();
  TextEditingController _servicePriceController = TextEditingController();
  TextEditingController _servicePicturesController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      _imageFileList!.addAll(selectedImages);
    }
    print("Image list length : " + _imageFileList!.length.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ADD SERVICE',
                  textAlign: TextAlign.center,
                  style: kmlpurpleboldText,
                ),
                SizedBox(height: 20),
                // buildTextField('labelText', 'hintText', _serviceNameController),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextField(
                        "Service Name", "e.g. HALL", _serviceNameController),
                    buildTextFieldNumber("Service Price", "e.g. 20000 PKR",
                        _servicePriceController),
                    buildTextFieldMultiline(
                        "Service Description",
                        "e.g. HALL has a capacity of 500 persons and is divided into two portions",
                        _serviceDescController),
                    Text(
                      'Pictures',
                      style: ksmallgreyText,
                    ),
                    Container(
                        height: 100,
                        child: _imageFileList!.isEmpty
                            ? Center(
                                child: Text("Add Images Here",
                                    style: ksmallgreyText))
                            : ListView.builder(
                                itemCount: _imageFileList!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.file(
                                      File(_imageFileList![index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              )
                        //TODO: grid view example code
                        // GridView.builder(
                        //   itemCount: _imageFileList!.length,
                        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 3),
                        //   itemBuilder: (context, index) {
                        //     return Padding(
                        //       padding: const EdgeInsets.all(3.0),
                        //       child: Image.file(
                        //         File(_imageFileList![index].path),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     );
                        //   },
                        // ),
                        ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () {
                        //     loadImages();
                        //   },
                        //   child: Column(
                        //     children: [
                        //       SizedBox(height: 5),
                        //       Icon(
                        //         Icons.camera,
                        //         color: Colors.white,
                        //       ),
                        //       SizedBox(height: 5),
                        //       Text('Load', style: ksmallwhiteText),
                        //       Text('Image', style: ksmallwhiteText),
                        //       SizedBox(height: 5),
                        //     ],
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius:
                        //           BorderRadius.circular(12), // <-- Radius
                        //     ),
                        //   ),
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            selectImages();
                            // var res = await loadAsset();
                            // setState(() {
                            //   imagePicker = res!;
                            // });
                          },
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5),
                              Text('Upload', style: ksmallwhiteText),
                              Text('Picture', style: ksmallwhiteText),
                              SizedBox(height: 5),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.grey,
                    ),
                    FlatButton(
                      onPressed: _imageFileList!.isEmpty
                          ? () {}
                          : () {
                              // print(_serviceNameController.text);
                              // print(_servicePriceController.text);
                              // print(_serviceDescController.text);
                              // print(_imageFileList!.length);
                              widget.addServiceCallback(
                                  _serviceNameController.text,
                                  _servicePriceController.text,
                                  _serviceDescController.text,
                                  _imageFileList);
                              Navigator.pop(context);
                              // addServiceCallback(newTaskTitle);
                            },
                      child: Text(
                        'ADD',
                        style: TextStyle(color: Colors.white),
                      ),
                      color:
                          _imageFileList!.isEmpty ? Colors.grey : Colors.purple,
                    )
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
