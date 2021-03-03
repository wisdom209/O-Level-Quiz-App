import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/businessLogic/HiveOperations.dart';

import '../Constants/AppConstants.dart';
import 'SelectUser.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    HiveManipulation().init();
    HiveManipulation().register();

    Timer(Duration(seconds: 3), () {
      Get.offAll(SelectUser());
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
        child: Scaffold(
            backgroundColor: AppConstants().primaryColour,
            body: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: SizedBox(
                      width: width * 0.50,
                      height: height * 0.5,
                      child: SvgPicture.asset(
                        "images/raised_hand.svg",
                        allowDrawingOutsideViewBox: true,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Center(
                    child: Text(
                      "There is no such thing as failure. Only feedback...",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          color: Colors.grey[800]),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "-Tony Robbins",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator()
              ],
            )));
  }
}
