import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:quiz_app/GetController/QuestionController.dart';

class SelectChallengeBtn extends StatelessWidget {
  const SelectChallengeBtn(
      {Key key,
      @required this.topPadding,
      @required this.option,
      this.widget,
      this.isStudy,
      this.isExam,
      this.isExercise,
      this.isReview})
      : super(key: key);

  final double topPadding;
  final String option;
  final widget;
  final bool isStudy;
  final bool isReview;
  final bool isExam;
  final bool isExercise;

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          FlatButton(
              onPressed: () {
                if (isStudy == true) {
                  _questionControllerInstance.isStudy.value = true;
                  _questionControllerInstance.isExam.value = false;
                  _questionControllerInstance.isReview.value = false;
                } else if (isExam == true) {
                  _questionControllerInstance.isStudy.value = false;
                  _questionControllerInstance.isReview.value = false;
                  _questionControllerInstance.isExam.value = true;
                  int randomYear = Random().nextInt(42) + 1978;
                  if (randomYear == 1996) {
                    randomYear = 1997 + Random().nextInt(10);
                  }
                  _questionControllerInstance.selectedYear.value =
                      "$randomYear";
                  print(randomYear);
                } else if (isExercise == true) {
                  _questionControllerInstance.isStudy.value = false;
                  _questionControllerInstance.isReview.value = false;
                  _questionControllerInstance.isExam.value = false;
                } else if (isReview == true) {
                  _questionControllerInstance.isStudy.value = false;
                  _questionControllerInstance.isReview.value = true;
                  _questionControllerInstance.isExam.value = false;
                } else {
                  _questionControllerInstance.isStudy.value = false;
                  _questionControllerInstance.isExam.value = false;
                  _questionControllerInstance.isReview.value = false;
                }

                Get.to(widget, transition: Transition.leftToRightWithFade);
              },
              color: Colors.white,
              height: MediaQuery.of(context).size.height *0.12,
              minWidth: MediaQuery.of(context).size.width * 0.95,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),borderRadius: BorderRadius.circular(10)),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(option, style: TextStyle(fontSize: 20),),
              )),
        ],
      ),
    );
  }
}
