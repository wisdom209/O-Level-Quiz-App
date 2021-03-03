import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:quiz_app/Backend/CollectionService.dart';
import 'package:quiz_app/Components/QuestionContainer.dart';
import 'package:quiz_app/GetController/QuestionController.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/Models/questionModel.dart';

class BusinessLogicClass {
  // void getProgressData() {
  //   var subjectList = [
  //     'government',
  //     'mathematics',
  //     'biology',
  //     'physics',
  //     'chemistry',
  //     'literature-in-english',
  //     'crs'
  //   ];

  //   for (var i = 0; i < subjectList.length; i++) {
  //     CollectionService().readProgress(subject: "${subjectList[i]}");
  //   }
  // }

  Future getData() async {
    QuestionController _questionControllerinstance = Get.find();
    String subject = _questionControllerinstance.subjectedSelected.value;
    try {
      var response = await http.get(
          "https://raw.githubusercontent.com/wisdom209/jamb_questions/main/$subject/jambquestions.json");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
        //throw Exception("Error fetching data from the internet");
      }
    } catch (e) {
      return null;
      //throw Exception("Error fetching data from the internet");
    }
  }

  dynamic getTheQuestionsRequested(
      {@required dynamic questionData, @required String year}) {
    List<Widget> listOfQuestions = List();
    QuestionController _questionControllerInstance = Get.find();

    if (_questionControllerInstance.isExam.value) {
      for (var i = 0; i < 50; i++) {
        String randYear = "${Random().nextInt(41) + 1978}";
        if (randYear == "1996") {
          int yearInt = int.parse(randYear) + Random().nextInt(10) + 1;
          randYear = "$yearInt";
        }
        QuestionModel questionModel =
            QuestionModel(index: i, questionData: questionData, year: randYear);
        questionModel.initializeData();
        listOfQuestions.add(QuestionContainer(
            key: UniqueKey(),
            questionNumber: "${i + 1}",
            question: questionModel.question,
            optionA: questionModel.optionA,
            optionB: questionModel.optionB,
            optionC: questionModel.optionC,
            optionD: questionModel.optionD,
            optionE: questionModel.optionE,
            answer: questionModel.answer,
            image: questionModel.image));
      }
     
    } else if (_questionControllerInstance.isReview.value) {
      //TODO
      // var answerMap = _questionControllerInstance.answerSheet;
      // var resultEntries = _questionControllerInstance.resultSheet;
      // var answerLength = answerMap.length;

      // if (answerLength > 0 &&
      //     (resultEntries.values.contains("a") ||
      //         resultEntries.values.contains("b") ||
      //         resultEntries.values.contains("c") ||
      //         resultEntries.values.contains("d") ||
      //         resultEntries.values.contains("e"))) {
      //   answerMap.forEach((k, v) {
      //     if (v != "correct") {
      //       listOfQuestions.add(
      //           _questionControllerInstance.possibleReviewQuestions[k - 1]);
      //     }
      //   });
      // }
    } else {
      for (var i = 0; i < 50; i++) {
        QuestionModel questionModel =
            QuestionModel(index: i, questionData: questionData, year: year);
        questionModel.initializeData();
        listOfQuestions.add(QuestionContainer(
            key: UniqueKey(),
            questionNumber: "${i + 1}",
            question: questionModel.question,
            optionA: questionModel.optionA,
            optionB: questionModel.optionB,
            optionC: questionModel.optionC,
            optionD: questionModel.optionD,
            optionE: questionModel.optionE,
            answer: questionModel.answer,
            image: questionModel.image));
      }
    }
    _questionControllerInstance.possibleReviewQuestions = listOfQuestions;
    return listOfQuestions;
  }

  dynamic calculateScore() {
    QuestionController _questionControllerInstance = Get.find();
    var answerMap = _questionControllerInstance.answerSheet;
    var resultEntries = _questionControllerInstance.resultSheet;
    var answerLength = answerMap.length;
    List correctAnswers = [];

    if (answerLength > 0 &&
        (resultEntries.values.contains("a") ||
            resultEntries.values.contains("b") ||
            resultEntries.values.contains("c") ||
            resultEntries.values.contains("d") ||
            resultEntries.values.contains("e"))) {
      answerMap.forEach((k, v) {
        if (v == "correct") {
          correctAnswers.add("correct");
        }
      });

      return correctAnswers.length;
    } else {
      return "No question answered";
    }
  }
  
}
