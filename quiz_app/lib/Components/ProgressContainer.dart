import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../GetController/QuestionController.dart';
import '../businessLogic/HiveOperations.dart';
import '../businessLogic/PercentageCalculator.dart';

class ProgressContainer extends StatefulWidget {
  const ProgressContainer(
      {Key key,
      @required this.subject,
      this.bestScore,
      this.averageScore,
      this.leastScore})
      : super(key: key);

  final String subject;
  final double bestScore;
  final double averageScore;
  final double leastScore;

  @override
  _ProgressContainerState createState() => _ProgressContainerState();
}

class _ProgressContainerState extends State<ProgressContainer> {
  @override
  void initState() {
    super.initState();
    QuestionController _questionControllerInstance = Get.find();
    String username = _questionControllerInstance.hiveUserName.value;
    HiveManipulation().readProgress(
        subject: "${widget.subject.toLowerCase()}", username: username);
    // .then((data) => {});
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();

    double averagePercent =
        PercentageCalculator(receivedValue: widget.averageScore).getPercent();
    double bestPercent =
        PercentageCalculator(receivedValue: widget.bestScore).getPercent();
    double leastPercent =
        PercentageCalculator(receivedValue: widget.leastScore).getPercent();

    Stream<dynamic> _getScoreState() async* {
      HiveManipulation().readProgress(
          subject: "${widget.subject.toLowerCase()}",
          username: _questionControllerInstance.hiveUserName.value);
      yield _questionControllerInstance.subjectScores;
    }

    return FutureBuilder(
      future: HiveManipulation()
          .readProgress(
              subject: "${widget.subject.toLowerCase()}",
              username: _questionControllerInstance.hiveUserName.value)
          .then((d) => d),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<Object>(
              stream: _getScoreState(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                widget.subject,
                                style: TextStyle(
                                    fontSize: 30, color: Colors.green),
                              )),
                        ),
                        Divider(
                          color: Colors.grey[500],
                          indent: 8,
                          endIndent: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Exam Mode",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 25),
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8, left: 8, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Best Score"),
                              Text("${widget.bestScore}/50 ($bestPercent%)")
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8, left: 8, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Average Score"),
                              Text(
                                  "${widget.averageScore.toStringAsFixed(1)}/50 ($averagePercent%)")
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8, left: 8, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Least Score"),
                              Text("${widget.leastScore}/50 ($leastPercent%)")
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text("");
                }
              });
        }
        return Center(child: Text(''));
      },
    );
  }
}
