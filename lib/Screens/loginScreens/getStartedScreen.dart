import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hall_bookify/Controller/loginButtons.dart';
import 'package:hall_bookify/Controller/sliderItems.dart';
import 'package:hall_bookify/Models/slideData.dart';

import 'registerPhone.dart';

class getStartedScreen extends StatefulWidget {
  static const String id = 'getStartedScreen';

  @override
  _getStartedScreenState createState() => _getStartedScreenState();
}

class _getStartedScreenState extends State<getStartedScreen> {
  int _currentPage = 0;
  final scrollController = ScrollController();
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (scrollController.hasClients) {
        pageController.animateToPage(_currentPage,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
  }

  _onPageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 55.0, left: 20, right: 20, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: _onPageChange,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => sliderItems(index),
                itemCount: sliderList.length,
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: startediconButton(
                buttontext: 'Get Started',
                onpressed: () {
                  Navigator.pushNamed(context, registerPhone.id);
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
