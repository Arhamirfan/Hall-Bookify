import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hall_bookify/Constants.dart';
import 'package:hall_bookify/Screens/mainScreens/SearchProduct/Searches/ViewPackageByServiceName.dart';

import '../../../../Widgets/input_widget.dart';

class ServiceNameSearchScreen extends StatefulWidget {
  @override
  _ServiceNameSearchScreenState createState() =>
      _ServiceNameSearchScreenState();
}

class _ServiceNameSearchScreenState extends State<ServiceNameSearchScreen> {
  TextEditingController _nameController = new TextEditingController();

  @override
  void dispose() {
    _nameController.text = " ";

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Search'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          color: Color(0xffe6e6e6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('SEARCH SERVICE BY NAME', style: kmediumblackboldText),
              SizedBox(
                height: 50.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputWidget(
                      controller: _nameController,
                      height: 44.0,
                      hintText: "Search By Service Name",
                      prefixIcon: FlutterIcons.search1_ant,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                height: 44,
                width: MediaQuery.of(context).size.width * .35,
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.purpleAccent,
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                      )),
                  onPressed: () {
                    //Helper.nextScreen(context, Filters());
                  },
                  child: GestureDetector(
                    onTap: () {
                      //add simple search here..
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return new ViewPackageByServiceName(
                              PackageName: _nameController.text);
                        },
                      ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "SEARCH",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
