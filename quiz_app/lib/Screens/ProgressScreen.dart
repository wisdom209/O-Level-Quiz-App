import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Components/ProgressContainer.dart';
import '../Constants/AppConstants.dart';
import '../GetController/QuestionController.dart';
import '../businessLogic/GetScores.dart';
import '../businessLogic/HiveOperations.dart';
import 'Dashboard.dart';
import 'SelectUser.dart';


class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key key}) : super(key: key);

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    super.initState();
    QuestionController _questionControllerInstance = Get.find();
    setState(() {
      HiveManipulation().readProgress(
          subject: "chemistry",
          username: _questionControllerInstance.hiveUserName.value);
    });
    Timer(Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    

    return Scaffold(
        appBar: AppBar(
          title: Text(_questionControllerInstance.hiveUserName.value.capitalizeFirst),
          leading: Icon(
            Icons.timeline_outlined,
            color: Colors.white,
          ),
          actions: [
            PopupMenuButton(
              padding: EdgeInsets.zero,
              elevation: 0,
              onSelected: (value) {
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
                  child: Text("Change user"),
                  value: 3,
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: HiveManipulation().readProgress(
                subject: "chemistry",
                username: _questionControllerInstance.hiveUserName.value),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.done
                ? ValueListenableBuilder(
                    valueListenable: Hive.box("AppBox").listenable(
                        keys: [_questionControllerInstance.hiveUserName.value]),
                    builder: (context, value, child) => ListView(
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
                            bestScore:
                                GetScores().getBestScore(subject: 'chemistry'),
                            leastScore:
                                GetScores().getLeastScore(subject: "chemistry"),
                            averageScore: GetScores()
                                .getAverageScore(subject: "chemistry")),
                        ProgressContainer(
                            subject: "Mathematics",
                            bestScore: GetScores()
                                .getBestScore(subject: 'mathematics'),
                            leastScore: GetScores()
                                .getLeastScore(subject: "mathematics"),
                            averageScore: GetScores()
                                .getAverageScore(subject: "mathematics")),
                        ProgressContainer(
                            subject: "Physics",
                            bestScore:
                                GetScores().getBestScore(subject: 'physics'),
                            leastScore:
                                GetScores().getLeastScore(subject: "physics"),
                            averageScore: GetScores()
                                .getAverageScore(subject: "physics")),
                        ProgressContainer(
                            subject: "Government",
                            bestScore:
                                GetScores().getBestScore(subject: 'government'),
                            leastScore: GetScores()
                                .getLeastScore(subject: "government"),
                            averageScore: GetScores()
                                .getAverageScore(subject: "government")),
                        ProgressContainer(
                            subject: "CRS",
                            bestScore: GetScores().getBestScore(subject: 'crs'),
                            leastScore:
                                GetScores().getLeastScore(subject: "crs"),
                            averageScore:
                                GetScores().getAverageScore(subject: "crs")),
                        ProgressContainer(
                            subject: "Biology",
                            bestScore:
                                GetScores().getBestScore(subject: 'biology'),
                            leastScore:
                                GetScores().getLeastScore(subject: "biology"),
                            averageScore: GetScores()
                                .getAverageScore(subject: "biology")),
                        ProgressContainer(
                            subject: "Literature-in-english",
                            bestScore: GetScores()
                                .getBestScore(subject: 'literature-in-english'),
                            leastScore: GetScores().getLeastScore(
                                subject: "literature-in-english"),
                            averageScore: GetScores().getAverageScore(
                                subject: "literature-in-english")),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Text(""),
                  )));
  }
}
