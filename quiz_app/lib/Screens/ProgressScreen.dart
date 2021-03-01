import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Backend/AuthService.dart';
import 'package:quiz_app/Components/ProgressContainer.dart';
import 'package:quiz_app/Constants/AppConstants.dart';
import 'package:quiz_app/GetController/QuestionController.dart';
import 'package:quiz_app/businessLogic/GetScores.dart';

import 'Dashboard.dart';
import 'RegisterScreen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();

    return Scaffold(
        appBar: AppBar(
          title: Text("Progress"),
          leading: Icon(Icons.timeline_outlined, color: Colors.white,),
          actions: [
            PopupMenuButton(
              padding: EdgeInsets.zero,
              elevation: 0,
              onSelected: (value) {
                if (value == 3) {
                  if (!_questionControllerInstance.isGuest.value) {
                    AuthService()
                        .signOut()
                        .then((data) => Get.offAll(RegisterScreen(),
                            transition: Transition.leftToRightWithFade))
                        .catchError((e) => Get.snackbar(
                            "Error", "User could not be logged out"));
                  } else {
                    Get.off(RegisterScreen(),
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
        backgroundColor: Colors.white,
        body: _questionControllerInstance.isGuest.value
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Center(
                      child: SizedBox(
                    child: SvgPicture.string(AppConstants().timelineSvg),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: Text(
                    "Sign in to track your progress . . .",
                    style: TextStyle(fontSize: 20),
                  )),
                ],
              )
            : ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Center(
                      child: SizedBox(
                    child: SvgPicture.string(AppConstants().timelineSvg),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  ProgressContainer(
                      subject: "Chemistry",
                      bestScore: GetScores().getBestScore(subject: 'chemistry'),
                      leastScore:
                          GetScores().getLeastScore(subject: "chemistry"),
                      averageScore:
                          GetScores().getAverageScore(subject: "chemistry")),
                  ProgressContainer(
                      subject: "Mathematics",
                      bestScore:
                          GetScores().getBestScore(subject: 'mathematics'),
                      leastScore:
                          GetScores().getLeastScore(subject: "mathematics"),
                      averageScore:
                          GetScores().getAverageScore(subject: "mathematics")),
                  ProgressContainer(
                      subject: "Physics",
                      bestScore: GetScores().getBestScore(subject: 'physics'),
                      leastScore: GetScores().getLeastScore(subject: "physics"),
                      averageScore:
                          GetScores().getAverageScore(subject: "physics")),
                  ProgressContainer(
                      subject: "Government",
                      bestScore:
                          GetScores().getBestScore(subject: 'government'),
                      leastScore:
                          GetScores().getLeastScore(subject: "government"),
                      averageScore:
                          GetScores().getAverageScore(subject: "government")),
                  ProgressContainer(
                      subject: "CRS",
                      bestScore: GetScores().getBestScore(subject: 'crs'),
                      leastScore: GetScores().getLeastScore(subject: "crs"),
                      averageScore:
                          GetScores().getAverageScore(subject: "crs")),
                  ProgressContainer(
                      subject: "Biology",
                      bestScore: GetScores().getBestScore(subject: 'biology'),
                      leastScore: GetScores().getLeastScore(subject: "biology"),
                      averageScore:
                          GetScores().getAverageScore(subject: "biology")),
                  ProgressContainer(
                      subject: "Literature-in-english",
                      bestScore: GetScores()
                          .getBestScore(subject: 'literature-in-english'),
                      leastScore: GetScores()
                          .getLeastScore(subject: "literature-in-english"),
                      averageScore: GetScores()
                          .getAverageScore(subject: "literature-in-english")),
                  SizedBox(
                    height: 20,
                  )
                ],
              ));
  }
}
