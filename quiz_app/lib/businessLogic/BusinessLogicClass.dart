import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:quiz_app/Backend/CollectionService.dart';
import 'package:quiz_app/Components/QuestionContainer.dart';
import 'package:quiz_app/GetController/QuestionController.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/Models/questionModel.dart';

class BusinessLogicClass {
  parseQuestionsToModel(
      {String year,
      var questionData,
      int indexer,
      List initialList,
      String subject}) {
    QuestionModel questionModel =
        QuestionModel(index: indexer, questionData: questionData, year: year);
    questionModel.initializeData();
    initialList.add(QuestionContainer(
        key: UniqueKey(),
        questionNumber: "${indexer + 1}",
        question: questionModel.question,
        optionA: questionModel.optionA,
        optionB: questionModel.optionB,
        optionC: questionModel.optionC,
        optionD: questionModel.optionD,
        optionE: questionModel.optionE,
        answer: questionModel.answer,
        image: questionModel.image.length > 5
            ? "https://raw.githubusercontent.com/wisdom209/jamb_questions/main/JambPics/$subject/Year${year}Num${indexer + 1}End.jpg"
            : ""));
  }

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
      }
    } catch (e) {
      return null;
    }
  }

  dynamic getTheQuestionsRequested(
      {@required dynamic questionData, @required String year}) {
    List<Widget> listOfQuestions = List();
    QuestionController _questionControllerInstance = Get.find();
    String subject = _questionControllerInstance.subjectedSelected.value;

    if (_questionControllerInstance.isExam.value) {
      for (var i = 0; i < 50; i++) {
        String randYear = "${Random().nextInt(41) + 1978}";
        if (randYear == "1996") {
          int yearInt = int.parse(randYear) + Random().nextInt(10) + 1;
          randYear = "$yearInt";
        }

        parseQuestionsToModel(
            indexer: i,
            year: randYear,
            questionData: questionData,
            initialList: listOfQuestions,
            subject: subject);
      }
    } else if (_questionControllerInstance.isReview.value) {
      return _questionControllerInstance.possibleReviewQuestions;
    } else {
      for (var i = 0; i < 50; i++) {
        parseQuestionsToModel(
            indexer: i,
            initialList: listOfQuestions,
            questionData: questionData,
            subject: subject,
            year: year);
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
