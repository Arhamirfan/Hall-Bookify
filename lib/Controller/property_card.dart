import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hall_bookify/Screens/mainScreens/HomeScreen/View_Package.dart';

class productCard2 extends StatelessWidget {
  final Map package_details;
  productCard2(this.package_details);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return new View_Package(package_details);
            },
          ));
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          package_details['pictures'][0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -12.0,
                    left: 10.0,
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: package_details['package_availibility']
                                    .toString() ==
                                "true"
                            ? Colors.purple
                            : Color.fromRGBO(255, 136, 0, 1),
                      ),
                      child: Center(
                        child: Text(
                          package_details['package_availibility'].toString() ==
                                  'true'
                              ? "Available"
                              : "Booked",
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          package_details['package'],
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      Text(
                        'Starting: \$${package_details['price'][0]}',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    package_details['description'][0],
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFF343434),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        FlutterIcons.event_available_mdi,
                        size: 15.0,
                        color: Color.fromRGBO(255, 136, 0, 1),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        package_details['package_availibility'].toString(),
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Color(0xFF343434),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
