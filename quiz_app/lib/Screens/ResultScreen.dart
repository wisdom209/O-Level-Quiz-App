import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../Backend/CollectionService.dart';
import '../Constants/AppConstants.dart';
import '../GetController/QuestionController.dart';
import '../businessLogic/BusinessLogicClass.dart';
import 'Dashboard.dart';

class ResultScreen extends StatelessWidget {
  //const ResultScreen({Key key}) : super(key: key);
  final QuestionController _questionControllerInstance = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            onPressed: () {
              Get.offAll(Dashboard(),
                  transition: Transition.leftToRightWithFade);
              try {
                CollectionService().updateProgress(
                    score: BusinessLogicClass().calculateScore(),
                    subject: _questionControllerInstance.subjectedSelected.value
                        .toLowerCase());
              } catch (e) {
                //print e.toString();
              }
            },
            child: Text(
              "CONTINUE",
              style: TextStyle(
                  fontSize: 20, color: Colors.white, letterSpacing: 2),
            ),
            color: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
        backgroundColor: AppConstants().primaryColour,
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              color: Colors.black,
              child: Center(
                  child: Text(
                "YOUR RESULT: ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.grey[200]),
              )),
            ),
            Center(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${BusinessLogicClass().calculateScore()}" ==
                            "No question answered"
                        ? ""
                        : BusinessLogicClass().calculateScore() < 20
                            ? "Good try. Put more effort ..."
                            : "Good job. Keep it up...",
                    style: TextStyle(fontSize: 40, color: Colors.grey[800]),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.15),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    "${BusinessLogicClass().calculateScore()}",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // SelectChallengeBtn(
            //   topPadding: 0,
            //   option: "Review",
            //   widget: Questions(),
            //   isReview: true),
          ],
        ));
  }
}
