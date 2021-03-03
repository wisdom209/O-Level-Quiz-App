import 'dart:convert';

import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:quiz_app/Constants/AppConstants.dart';
import 'package:quiz_app/businessLogic/HiveOperations.dart';

import '../GetController/QuestionController.dart';
import '../businessLogic/BusinessLogicClass.dart';
import 'Dashboard.dart';
import 'ResultScreen.dart';
import 'SelectChallenge.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions>
    with AutomaticKeepAliveClientMixin {
  final QuestionController _questionControllerInstance = Get.find();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _questionControllerInstance.resultSheet = {};
    _questionControllerInstance.answerSheet = {};
    String year = _questionControllerInstance.selectedYear.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${_questionControllerInstance.subjectedSelected.value.capitalize}"),
        leading: Icon(
          Icons.menu_book,
          color: Colors.white,
        ),
        actions: [
          _questionControllerInstance.isExam.value
              ? CountdownFormatted(
                  duration: Duration(minutes: 45),
                  onFinish: () {
                    if (BusinessLogicClass().calculateScore() !=
                        "No question answered") {
                      HiveManipulation().addScore(
                          userName:
                              _questionControllerInstance.hiveUserName.value,
                          subject: _questionControllerInstance
                              .subjectedSelected.value
                              .toLowerCase(),
                          score: BusinessLogicClass().calculateScore());
                    }

                    Get.offAll(ResultScreen(),
                        transition: Transition.leftToRightWithFade);
                  },
                  builder: (BuildContext ctx, String remaining) {
                    return Center(
                      child: Text(
                        remaining,
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ); // 01:00:00
                  },
                )
              : SizedBox(
                  height: 0,
                ),
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 1:
                  Get.offAll(Dashboard(),
                      transition: Transition.leftToRightWithFade);
                  break;
                case 2:
                  Get.offAll(SelectChallenge(),
                      transition: Transition.leftToRightWithFade);
                  break;
                default:
                  Get.to(Dashboard());
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Dashboard"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Change Mode"),
                value: 2,
              ),
            ],
          )
        ],
      ),
      backgroundColor: AppConstants().primaryColour,
      bottomNavigationBar: FlatButton(
        color: Colors.white,
        child: Text(
          "Done",
        ),
        onPressed: () {
          if (_questionControllerInstance.isStudy.value ||
              _questionControllerInstance.isReview.value) {
            Get.offAll(Dashboard(), transition: Transition.leftToRightWithFade);
          } else if (_questionControllerInstance.isExam.value) {
            if (BusinessLogicClass().calculateScore() !=
                "No question answered") {
              HiveManipulation().addScore(
                  userName: _questionControllerInstance.hiveUserName.value,
                  subject: _questionControllerInstance.subjectedSelected.value
                      .toLowerCase(),
                  score: BusinessLogicClass().calculateScore());
            }

            Get.offAll(ResultScreen(),
                transition: Transition.leftToRightWithFade);
          } else {
            Get.offAll(ResultScreen(),
                transition: Transition.leftToRightWithFade);
          }
        },
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 0.5)),
      ),
      body: Scrollbar(
        thickness: 10,
        child: Container(
            child: FutureBuilder(
          future: BusinessLogicClass().getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //
              if (snapshot.data == null) {
                return Center(
                    child: Container(
                  child: Column(
                    children: [
                      Icon(Icons.portable_wifi_off_sharp),
                      Text("Poor or limited Network Connectivity",
                          style: TextStyle(fontSize: 20, color: Colors.brown)),
                      RaisedButton(
                          onPressed: () {
                            Get.off(Dashboard());
                          },
                          child: Text("Back"))
                    ],
                  ),
                ));
              }
              //
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "${snapshot.error} occurred",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              } else if (snapshot.hasData) {
                var questionData = jsonDecode(snapshot.data.toString());
                BusinessLogicClass().getTheQuestionsRequested(
                    questionData: questionData, year: year);

                //TODO: FOR REVIEW; A FUTURE IMPLEMENTATION
                // if (BusinessLogicClass()
                //         .getTheQuestionsRequested(
                //             questionData: questionData, year: year)
                //         .length <
                //     1) {
                //   return Center(
                //     child: Text("No questions to review"),
                //   );
                // }
                // print(_questionControllerInstance.subjectedSelected.value);

                return Container(
                  child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    itemCount: BusinessLogicClass()
                        .getTheQuestionsRequested(
                            questionData: questionData, year: year)
                        .length,
                    itemBuilder: (context, index) => BusinessLogicClass()
                        .getTheQuestionsRequested(
                            questionData: questionData, year: year)[index],
                  ),
                );

               
              }
            }

            return Center(child: CircularProgressIndicator());
          },
        )),
      ),
    );
  }
}
