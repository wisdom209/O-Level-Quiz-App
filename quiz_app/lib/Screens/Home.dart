import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Backend/CollectionService.dart';
import '../Constants/AppConstants.dart';
import '../GetController/QuestionController.dart';
import '../businessLogic/BusinessLogicClass.dart';
import 'Dashboard.dart';
import 'LoginScreen.dart';

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
   QuestionController _questionControllerInstance = Get.find();
    if (FirebaseAuth.instance.currentUser != null) {
      _questionControllerInstance.isGuest.value = false;
      CollectionService().getUserNameFuture();
      BusinessLogicClass().getProgressData();
    }
    Timer(Duration(seconds: 3), () {
      FirebaseAuth.instance.currentUser == null
          ? Get.offAll(LoginScreen())
          : Get.offAll(Dashboard());
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
