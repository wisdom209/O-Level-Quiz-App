import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Components/SelectChallengeBtn.dart';
import '../Constants/AppConstants.dart';
import '../GetController/QuestionController.dart';
import 'Dashboard.dart';
import 'ProgressScreen.dart';
import 'Questions.dart';
import 'SelectUser.dart';
import 'SelectYear.dart';

class SelectChallenge extends StatelessWidget {
  const SelectChallenge({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _questionControllerInstance.subjectedSelected.value.capitalize),
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
                Get.offAll(SelectUser());
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
               PopupMenuItem(
                      child: Text("Change User"),
                      value: 3,
                    ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: AppConstants().primaryColour),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SizedBox(
                    child: SvgPicture.string(
                      AppConstants().readerSvg,
                      color: Colors.brown,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SelectChallengeBtn(
                topPadding: 25,
                option: 'Study',
                widget: SelectYear(),
                isStudy: true),
            SelectChallengeBtn(
                topPadding: 0,
                option: "Exercise",
                widget: SelectYear(),
                isExercise: true),
            SelectChallengeBtn(
                topPadding: 0,
                option: "Exam Mode",
                widget: Questions(),
                isExam: true),
          ],
        ),
      ),
    );
  }
}
