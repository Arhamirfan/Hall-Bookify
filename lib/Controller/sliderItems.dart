import 'package:flutter/material.dart';
import 'package:hall_bookify/Models/slideData.dart';

import '../Constants.dart';

class sliderItems extends StatelessWidget {
  final int index;
  sliderItems(this.index);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text(
        //   'Hall Bookify',
        //   style: kxxlwhiteText,
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFBF36F6),
                    Color(0xFF9D3FDB),
                    Color(0xFF5253A3),
                  ],
                ),
                image: DecorationImage(
                    image: AssetImage(sliderList[index].imageURL))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          sliderList[index].title,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: kxlblackText,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          sliderList[index].description,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
