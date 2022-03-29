import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hall_bookify/Controller/loginButtons.dart';

class View_Package extends StatefulWidget {
  final Map package_details;
  View_Package(this.package_details);

  @override
  _View_PackageState createState() => _View_PackageState();
}

class _View_PackageState extends State<View_Package> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: Icon(Icons.arrow_back),
      //   title: Text(widget.package_details['package']),
      //   backgroundColor: Colors.purpleAccent,
      // ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 300),
              child: ImageSlider(context, widget.package_details['pictures']),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.purpleAccent,
                    child: Column(
                      children: [Text('data'), Text("data")],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 60,
                child: startediconButton(
                    buttontext: "Add To Cart", onpressed: () {}))
          ],
        ),
      ),
    );
    //   Container(
    //   color: Colors.white,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text("Package name : " + widget.package_details['package'],
    //           style: kmediumblackText),
    //       Text("service name : " + widget.package_details['services'][0],
    //           style: kmediumblackText),
    //       Text("Package price : " + widget.package_details['description'][0],
    //           style: kmediumblackText)
    //     ],
    //   ),
    // );
  }
}

Swiper ImageSlider(BuildContext context, List<dynamic> images) {
  return new Swiper(
    itemCount: images.length,
//    viewportFraction: 0.8,
    scale: 0.8,
    autoplay: true,
    itemBuilder: (context, index) {
      return new Image.network(
        images[index],
        fit: BoxFit.cover,
      );
    },
  );
}
