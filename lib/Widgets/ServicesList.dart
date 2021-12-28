import 'package:flutter/material.dart';

import 'ServicesTile.dart';

class ServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView(
        children: [ServicesTile()],
      ),
    );
  }
}
