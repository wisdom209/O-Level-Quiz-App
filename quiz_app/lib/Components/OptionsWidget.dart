import 'package:flutter/material.dart';

import 'SelectAnswerBtn.dart';

class OptionsWidget extends StatefulWidget {
  const OptionsWidget({
    Key key,
    @required this.optionA,
    @required this.optionB,
    @required this.optionC,
    @required this.optionD,
    @required this.optionE,
    @required this.questionNumber,
  }) : super(key: key);

  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String optionE;
  final String questionNumber;

  @override
  _OptionsWidgetState createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  Map questionAnswer;
  int quesNum;
  @override
  void initState() {
    super.initState();
    quesNum = 1;
    for (var i = 0; i < 50; i++) {
      questionAnswer[i] = List.filled(5, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.questionNumber != null
        ? CircularProgressIndicator()
        : ListView.builder(
            key: Key("${widget.questionNumber}"),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              List options = [
                [widget.optionA, 'A'],
                [widget.optionB, 'B'],
                [widget.optionC, 'C'],
                [widget.optionD, 'D'],
                [widget.optionE, 'E']
              ];

              setState(() {
                quesNum = int.parse(widget.questionNumber);
              });


              return SelectAnswerBtn(
                  key: Key("$index"),
                  optionText: options[index][0],
                  option: options[index][1],
                  questionNumber: quesNum,
                  index: index,
                  selectFunction: () {},
                  btnColor: Colors.white);
            });
  }
}
