import 'package:get/get.dart';
import 'package:quiz_app/GetController/QuestionController.dart';

class GetScores {
  QuestionController _questionControllerInstance = Get.find();

  dynamic getBestScore({String subject}) {
    Map subjectScore = {};

    

    try {
      if (_questionControllerInstance.subjectScores[subject] != null) {
        subjectScore = _questionControllerInstance.subjectScores[subject];
        if (subjectScore.isNotEmpty) {
          List scoreList = [];
          subjectScore.forEach((k, v) {
            scoreList.add(v);
          });

          scoreList.sort();

          return double.parse(scoreList[scoreList.length - 1].toString());
        }
      }
    } catch (e) {
      return 0.00;
    }

    return 0.00;
  }

  dynamic getAverageScore({String subject}) {
    Map subjectScore = {};
    try {
      if (_questionControllerInstance.subjectScores[subject] != null) {
        subjectScore = _questionControllerInstance.subjectScores[subject];
        List scoreList = [];

        if (subjectScore.isNotEmpty) {
          subjectScore.forEach((k, v) {
            scoreList.add(v);
          });
        }

        int sum = 0;
        if (scoreList.isNotEmpty) {
          for (var i = 0; i < scoreList.length; i++) {
            sum = scoreList[i] + sum;
          }

          double average = sum / scoreList.length == double.nan
              ? 0.00
              : sum / scoreList.length;

          return average;
        }
      }
    } catch (e) {
      return 0.00;
    }

    return 0.00;
  }

  dynamic getLeastScore({String subject}) {
    Map subjectScore = {};
    try {
      if (_questionControllerInstance.subjectScores[subject] != null) {
        subjectScore = _questionControllerInstance.subjectScores[subject];
        if (subjectScore.isNotEmpty) {
          List scoreList = [];
          subjectScore.forEach((k, v) {
            scoreList.add(v);
          });

          scoreList.sort();

          return double.parse(scoreList[0].toString());
        }
      }
    } catch (e) {
      return 0.00;
    }

    return 0.00;
  }
}
