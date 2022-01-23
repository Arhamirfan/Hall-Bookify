import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hall_bookify/Models/category.dart';

class StaticData {
  static List<Category> categories = [
    Category(
      id: 1,
      title: "Most Popular",
      icon: Icon(
        FlutterIcons.trending_up_fea,
      ),
    ),
    Category(
      id: 2,
      title: "Top Rated",
      icon: Icon(
        FlutterIcons.globe_ent,
      ),
    ),
    Category(
      id: 3,
      title: "Best Photographer",
      icon: Icon(
        Icons.camera_alt_outlined,
      ),
    ),
    Category(
      id: 4,
      title: "Quality Meal",
      icon: Icon(
        Icons.fastfood_outlined,
      ),
    ),
  ];
}
