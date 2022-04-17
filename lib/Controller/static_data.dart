import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hall_bookify/Models/category.dart';
import 'package:hall_bookify/Screens/mainScreens/SearchProduct/PriceSearchedScreens/PriceRangeSearchScreen.dart';

class StaticData {
  static List<Category> categories = [
    Category(
        id: 1,
        title: "Package Price",
        icon: Icon(
          Icons.attach_money,
        ),
        function: (context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return new PriceRangeSearchScreen();
            },
          ));
        }),
    Category(
        id: 2,
        title: "Service Price",
        icon: Icon(
          Icons.money_outlined,
        ),
        function: (context) {}),
    Category(
        id: 3,
        title: "Availability",
        icon: Icon(
          Icons.event_available,
        ),
        function: (context) {}),
    Category(
        id: 4,
        title: "Services",
        icon: Icon(
          Icons.home_repair_service_outlined,
        ),
        function: (context) {}),
    Category(
        id: 5,
        title: "Location",
        icon: Icon(
          Icons.location_on_outlined,
        ),
        function: (context) {}),
    Category(
        id: 6,
        title: "Top Rated",
        icon: Icon(
          FlutterIcons.globe_ent,
        ),
        function: (context) {}),
  ];
}
