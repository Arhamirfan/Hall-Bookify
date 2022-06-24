import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/static_data.dart';
import 'package:hall_bookify/Screens/mainScreens/SearchProduct/Searches/ViewPackageByName.dart';
import 'package:hall_bookify/Widgets/input_widget.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController _packageSearchedDetailController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Package ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: InputWidget(
                          controller: _packageSearchedDetailController,
                          hintText: "Find by package name",
                          prefixIcon: Icons.search,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: FlatButton(
                                color: Colors.purpleAccent,
                                onPressed: () {
                                  print('passed data: ' +
                                      _packageSearchedDetailController.text);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return new ViewPackageByName(
                                          PackageName:
                                              _packageSearchedDetailController
                                                  .text);
                                    },
                                  ));
                                },
                                child: Text('Search',
                                    style: TextStyle(color: Colors.white))),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Services",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          StaticData.categories[index].function(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(245, 246, 250, 1),
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StaticData.categories[index].icon,
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                StaticData.categories[index].title,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: StaticData.categories.length,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
