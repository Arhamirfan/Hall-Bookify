import 'package:flutter/material.dart';

class Category {
  final int id;
  final String title;
  final Widget icon;
  final void Function(BuildContext) function;

  Category(
      {required this.id,
      required this.title,
      required this.icon,
      required this.function});
}
