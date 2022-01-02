import 'package:flutter/material.dart';
import 'package:hall_bookify/Models/Services.dart';
import 'package:hall_bookify/Widgets/ServicesTile.dart';

class ServicesList extends StatefulWidget {
  final List<Services> servicesTask;

  ServicesList({required this.servicesTask});

  @override
  _ServicesListState createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ServicesTile(
              Pictures: widget.servicesTask[index].images,
              taskTitle: widget.servicesTask[index].name,
              taskprice: widget.servicesTask[index].price,
              taskdesc: widget.servicesTask[index].description,
              availibility: widget.servicesTask[index].availibility,
              checkboxFunction: (checkboxState) {
                setState(() {
                  widget.servicesTask[index].toggleisDone();
                });
              },
              onLongPress: () {
                print("The index on LONG PRESS IS : $index");
                setState(() {
                  print("old length of list : " +
                      widget.servicesTask.length.toString());
                  widget.servicesTask.removeAt(index);
                  print("new length of list : " +
                      widget.servicesTask.length.toString());
                });
              },
            );
          },
          itemCount: widget.servicesTask.length,
        ));
  }
}
