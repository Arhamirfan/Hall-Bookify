import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hall_bookify/Constants.dart';

import '../../../../Widgets/input_widget.dart';
import '../../../../Widgets/textFieldInput.dart';
import '../Searches/ViewPackageByServiceMultiplePrice.dart';
import '../Searches/ViewPackageByServicePrice.dart';

class PriceRangeServiceSearchScreen extends StatefulWidget {
  const PriceRangeServiceSearchScreen({Key? key}) : super(key: key);

  @override
  _PriceRangeServiceSearchScreenState createState() =>
      _PriceRangeServiceSearchScreenState();
}

class _PriceRangeServiceSearchScreenState
    extends State<PriceRangeServiceSearchScreen> {
  TextEditingController _exactPriceController = new TextEditingController();
  TextEditingController _minPriceController = new TextEditingController();
  TextEditingController _maxPriceController = new TextEditingController();
  final double min = 10, max = 1000;
  double getmin = 0, getmax = 0;
  RangeValues values = RangeValues(10, 1000);
  RangeValues resertvalues = RangeValues(10, 1000);

  @override
  void dispose() {
    getmin = 10;
    getmax = 1000;
    _exactPriceController.text = " ";
    _maxPriceController.text = " ";
    _minPriceController.text = " ";

    values = resertvalues;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Product'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xffe6e6e6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        controller: _exactPriceController,
                        height: 44.0,
                        hintText: "Search By Price",
                        prefixIcon: FlutterIcons.search1_ant,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      height: 44,
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
                                return new ViewByServicePrice(
                                    PackagePrice: _exactPriceController.text);
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
                ),
                SizedBox(height: 30),
                Text('Price Range', style: klargeblackboldText),
                SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RangeSlider(
                        activeColor: Colors.purpleAccent,
                        inactiveColor: Colors.blue.shade200,
                        values: values,
                        min: min,
                        max: max,
                        divisions: 50,
                        labels: RangeLabels(
                            values.start.toString(), values.end.toString()),
                        onChanged: (values) => setState(() {
                              this.values = values;
                              getmin = values.start;
                              getmax = values.end;
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('\$10', style: kmediumblackboldText),
                        Text('\$250', style: kmediumblackboldText),
                        Text('\$500', style: kmediumblackboldText),
                        Text('\$750', style: kmediumblackboldText),
                        Text('\$1000', style: kmediumblackboldText)
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: RaisedButton(
                              onPressed: () {
                                //add min and max range search here
                                print(getmin);
                                print(getmax);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ViewPackageByServiceMultiplePrice(
                                        minPrice: getmin.toString(),
                                        maxPrice: getmax.toString());
                                  },
                                ));
                              },
                              color: Colors.purple,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "SEARCH",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Text('Custom Price Range', style: klargeblackboldText),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildTextFieldNumberNoPadding(
                          "", 'Min. Price', _minPriceController),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildTextFieldNumberNoPadding(
                          "", 'Max. Price', _maxPriceController),
                    )),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: RaisedButton(
                          onPressed: () {
                            print(_minPriceController.text);
                            print(_maxPriceController.text);
                            double cp_min =
                                double.parse(_minPriceController.text);
                            double cp_max =
                                double.parse(_maxPriceController.text);
                            if (_minPriceController.text.isNotEmpty) {
                              if (_maxPriceController.text.isNotEmpty) {
                                if (cp_min < cp_max) {
                                  //not empty and min price is greater
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ViewPackageByServiceMultiplePrice(
                                          minPrice: _minPriceController.text,
                                          maxPrice: _maxPriceController.text);
                                    },
                                  ));
                                } else {
                                  snackBar(context,
                                      'Minimum price is getter than Maximum');
                                }
                              } else {
                                snackBar(context, 'Maximum price is empty');
                              }
                            } else {
                              snackBar(context, 'Minimum price is empty');
                            }
                          },
                          color: Colors.purple,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "SEARCH",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
