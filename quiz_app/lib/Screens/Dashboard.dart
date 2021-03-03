import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../Components/DashboardItem.dart';
import '../Constants/AppConstants.dart';
import '../GetController/QuestionController.dart';
import 'ProgressScreen.dart';
import 'SelectUser.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(
              _questionControllerInstance.hiveUserName.value.capitalizeFirst)),
          leading: Icon(
            Icons.home,
            color: Colors.white,
          ),
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
                  Get.offAll(SelectUser());
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Progress"),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("Select User"),
                  value: 2,
                )
              ],
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(color: AppConstants().primaryColour),
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
