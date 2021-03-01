import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Backend/AuthService.dart';
import 'package:quiz_app/GetController/QuestionController.dart';
import '../Components/SelectYearBtn.dart';
import 'Dashboard.dart';
import 'ProgressScreen.dart';
import 'LoginScreen.dart';

class SelectYear extends StatelessWidget {
  const SelectYear({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    List yearList = [];
    for (var i = 0; i < 42; i++) {
      if (i == 18) {
        continue;
      }
      yearList.add("${i + 1978}");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Year"),
        actions: [
          PopupMenuButton(
            padding: EdgeInsets.zero,
            elevation: 0,
            onSelected: (value) {
              if (value == 2) {
                Get.to(ProgressScreen(),
                    transition: Transition.leftToRightWithFade);
              }
              if (value == 3) {
                if (!_questionControllerInstance.isGuest.value) {
                  AuthService().signOut();
                  Get.offAll(LoginScreen(),
                      transition: Transition.leftToRightWithFade);
                } else {
                  Get.off(LoginScreen(),
                      transition: Transition.leftToRightWithFade);
                }
              }
              if (value == 1) {
                Get.offAll(Dashboard(),
                    transition: Transition.leftToRightWithFade);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Dashboard"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Progress"),
                value: 2,
              ),
              _questionControllerInstance.isGuest.value
                  ? PopupMenuItem(
                      child: Text("Sign In"),
                      value: 3,
                    )
                  : PopupMenuItem(
                      child: Text("Logout"),
                      value: 3,
                    ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[400]),
        child: ListView.builder(
            itemCount: yearList.length,
            itemBuilder: (context, index) => SelectYearBtn(
                  year: yearList[index],
                )),
      ),
    );
  }
}
