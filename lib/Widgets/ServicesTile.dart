import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ServicesTile extends StatelessWidget {
  final bool availibility;
  List<XFile>? Pictures;
  final String taskTitle, taskdesc;
  final String taskprice;
  final Function checkboxFunction;
  final Function onLongPress;
  ServicesTile(
      {required this.Pictures,
      required this.taskTitle,
      required this.taskprice,
      required this.taskdesc,
      required this.availibility,
      required this.checkboxFunction,
      required this.onLongPress});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Image.file(File(Pictures![0].path), fit: BoxFit.cover, width: 80),
      title: Text(
        taskTitle,
        style: TextStyle(color: Colors.black45),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(taskdesc),
        ],
      ),
      onLongPress: () {
        onLongPress();
      },
      trailing: Text(
        'PKR. ${taskprice.toString()}',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 17,
        ),
      ),
      // Checkbox(
      //   activeColor: Colors.purple,
      //   value: ischecked,
      //   onChanged: (value) {
      //     checkboxFunction(value);
      //   },
      // ),
    );
  }
}

//TODO: add function to binary condition as
// ischecked == false
// ? () {
// TextDecoration.lineThrough;
// TextStyle(color: Colors.black45);
// }()
// : null
