import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:quiz_app/Backend/AuthService.dart';
import 'package:quiz_app/Constants/AppConstants.dart';
import 'package:quiz_app/GetController/QuestionController.dart';

import '../Components/DashboardItem.dart';
import 'ProgressScreen.dart';
import 'LoginScreen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    

    return Scaffold(
        appBar: AppBar(
          title: _questionControllerInstance.isGuest.value
              ? Text("Guest")
              : Obx(()=>Text(_questionControllerInstance.displayName.value)),
          leading: Icon(Icons.home, color: Colors.white,),
          actions: [
            PopupMenuButton(
              padding: EdgeInsets.zero,
              elevation: 0,
              onSelected: (value) {
                if (value == 1) {
                  Get.to(ProgressScreen(),
                      transition: Transition.leftToRightWithFade);
                }
                if (value == 2) {
                  if (!_questionControllerInstance.isGuest.value) {
                    AuthService().signOut();
                    Get.offAll(LoginScreen(),
                        transition: Transition.leftToRightWithFade);
                  } else {
                    Get.off(LoginScreen(),
                        transition: Transition.leftToRightWithFade);
                  }
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Progress"),
                  value: 1,
                ),
                _questionControllerInstance.isGuest.value
                    ? PopupMenuItem(
                        child: Text("Sign In"),
                        value: 2,
                      )
                    : PopupMenuItem(
                        child: Text("Logout"),
                        value: 2,
                      ),
              ],
            ),
          ],
        ),
        body: Container(
          decoration:BoxDecoration(color: AppConstants().primaryColour),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
            child: Center(
                
                child: ListView(
              children: [
                Row(
                  children: [
                    DashboardItem(
                      width: width,
                      height: height,
                      subject: "Chemistry",
                      svgToLoad: "images/chemistry.svg",
                    ),
                    DashboardItem(
                      width: width,
                      height: height,
                      subject: "Mathematics",
                      svgToLoad: "images/mathematics.svg",
                    ),
                  ],
                ),
                Row(
                  children: [
                    DashboardItem(
                      width: width,
                      height: height,
                      subject: "Physics",
                      svgToLoad: "images/physics.svg",
                    ),
                    DashboardItem(
                      width: width,
                      height: height,
                      subject: "Literature-In-English",
                      svgToLoad: "images/literature-in-english.svg",
                    ),
                  ],
                ),
                Row(
                  children: [
                    DashboardItem(
                      width: width,
                      height: height,
                      subject: "Biology",
                      svgToLoad: 'images/biology.svg',
                    ),
                    DashboardItem(
                      width: width,
                      height: height,
                      subject: "CRS",
                      svgToLoad: 'images/crs.svg',
                    ),
                  ],
                ),
                Row(
                  children: [
                  
                    DashboardItem(
                      width: width,
                      height: height,
                      subject: "Government",
                      svgToLoad: 'images/government.svg',
                    ),
                  ],
                ),
              ],
            )),
          ),
        ));
  }
}
