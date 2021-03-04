import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import '../GetController/QuestionController.dart';
import 'QuestionAnswerTab.dart';
import 'answerbtn.dart';

class QuestionContainer extends StatefulWidget {
  const QuestionContainer(
      {Key key,
      @required this.question,
      @required this.questionNumber,
      @required this.optionA,
      @required this.optionB,
      @required this.optionC,
      this.optionD,
      this.optionE,
      this.answer,
      this.image})
      : super(key: key);

  final String question;
  final String questionNumber;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String optionE;
  final String answer;
  final String image;

  @override
  _QuestionContainerState createState() => _QuestionContainerState();
}

class _QuestionContainerState extends State<QuestionContainer>
    with AutomaticKeepAliveClientMixin {
  QuestionController _questionControllerInstance = Get.find();
  Color btn;
  List btnSelected;
  Color btnA;
  Color btnB;
  Color btnC;
  Color btnD;
  Color btnE;
  Color btnAnswer;

  @override
  void initState() {
    super.initState();
    btn = Colors.white;

    btnSelected = List.filled(5, false);
    btnA = Colors.white;
    btnB = Colors.white;
    btnC = Colors.white;
    btnD = Colors.white;
    btnE = Colors.white;
    btnAnswer = Colors.white;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    btnA = btnSelected[0] ? Colors.lightBlue[200] : Colors.white;
    btnB = btnSelected[1] ? Colors.lightBlue[200] : Colors.white;
    btnC = btnSelected[2] ? Colors.lightBlue[200] : Colors.white;
    btnD = btnSelected[3] ? Colors.lightBlue[200] : Colors.white;
    btnE = btnSelected[4] ? Colors.lightBlue[200] : Colors.white;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        color: const Color(0xffdcd6d6),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(children: [
                          widget.image != ""
                              ? Image.network(widget.image)
                              : SizedBox(
                                  height: 0,
                                ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                color: Colors.brown),
                            child:
                                ((_questionControllerInstance
                                                    .subjectedSelected.value ==
                                                "chemistry" ||
                                            _questionControllerInstance
                                                    .subjectedSelected.value ==
                                                "mathematics" ||
                                            _questionControllerInstance
                                                    .subjectedSelected.value ==
                                                "physics") &&
                                        (widget.question.contains('frac') ||
                                            widget.question.contains('sqrt') ||
                                            widget.question.contains('circ}') ||
                                            widget.question.contains('}') ||
                                            widget.question.contains('\\')))
                                    ? TeXView(
                                        renderingEngine:
                                            TeXViewRenderingEngine.katex(),
                                        loadingWidgetBuilder: (context) =>
                                            LinearProgressIndicator(),
                                        child: TeXViewDocument(
                                            "${widget.questionNumber}. ${widget.question}",
                                            style: TeXViewStyle(
                                                contentColor: Colors.black)),
                                      )
                                    : Text(
                                        "${widget.questionNumber}. ${widget.question}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[200]),
                                      ),
                          ),

                          //A
                          Row(
                            children: [
                              buttonAnswerMethod(
                                  btnAnswerColor: btnA,
                                  btnAnswerIndex: 0,
                                  btnAnswerText: "A"),
                              Expanded(
                                child: QuestionAnswerTab(
                                  optionText: widget.optionA,
                                ),
                              ),
                            ],
                          ),

                          //B
                          Row(
                            children: [
                              buttonAnswerMethod(
                                  btnAnswerColor: btnB,
                                  btnAnswerIndex: 1,
                                  btnAnswerText: "B"),
                              Expanded(
                                child: QuestionAnswerTab(
                                  optionText: widget.optionB,
                                ),
                              ),
                            ],
                          ),

                          //C
                          Row(
                            children: [
                              buttonAnswerMethod(
                                  btnAnswerColor: btnC,
                                  btnAnswerIndex: 2,
                                  btnAnswerText: "C"),
                              Expanded(
                                child: QuestionAnswerTab(
                                  optionText: widget.optionC,
                                ),
                              ),
                            ],
                          ),

                          //D
                          Row(
                            children: [
                              buttonAnswerMethod(
                                  btnAnswerColor: btnD,
                                  btnAnswerIndex: 3,
                                  btnAnswerText: 'D'),
                              Expanded(
                                child: QuestionAnswerTab(
                                  optionText: widget.optionD,
                                ),
                              ),
                            ],
                          ),

                          //E
                          Row(
                            children: [
                              buttonAnswerMethod(
                                  btnAnswerColor: btnE,
                                  btnAnswerIndex: 4,
                                  btnAnswerText: "E"),
                              Expanded(
                                child: QuestionAnswerTab(
                                  optionText: widget.optionE,
                                ),
                              ),
                            ],
                          ),

                          //Show Answe Rowe
                          _questionControllerInstance.isStudy.value ||
                                  _questionControllerInstance.isReview.value
                              ? AnswerButton(
                                  answer: widget.answer,
                                )
                              : Text(""),
                        ]))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buttonAnswerMethod(
      {Color btnAnswerColor, String btnAnswerText, int btnAnswerIndex}) {
    return Container(
      decoration: BoxDecoration(boxShadow: ([BoxShadow(blurRadius: 1.0, offset: Offset(1.0, 1.0),color: Colors.grey[800])])),
      margin: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 0),
      child: FlatButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Center(child: Text("$btnAnswerText.")),
        color: btnAnswerColor,
        minWidth: 40,
        height: 25,
        onPressed: () =>
            selectButtonMethod(btn: btnAnswerColor, index: btnAnswerIndex),
      ),
    );
  }

  selectButtonMethod({int index, Color btn}) {
    List letters = ["a", 'b', 'c', 'd', 'e'];
    QuestionController questionControllerInstance = Get.find();

    setState(() {
      if (btnSelected[index]) {
        btnSelected[index] = false;

        questionControllerInstance
            .resultSheet[int.parse(widget.questionNumber)] = "x";

        if (widget.answer == letters[index]) {
          questionControllerInstance
              .answerSheet[int.parse(widget.questionNumber)] = "";
        }
      } else if (btnSelected.contains(true) && btnSelected[index] == false) {
        btnSelected = List.filled(5, false);
        btnSelected[index] = true;

        if (widget.answer == letters[index]) {
          questionControllerInstance
              .answerSheet[int.parse(widget.questionNumber)] = "correct";
        } else {
          questionControllerInstance
              .answerSheet[int.parse(widget.questionNumber)] = "wrong";
        }

        questionControllerInstance
            .resultSheet[int.parse(widget.questionNumber)] = letters[index];
      } else {
        btnSelected[index] = true;

        if (widget.answer == letters[index]) {
          questionControllerInstance
              .answerSheet[int.parse(widget.questionNumber)] = "correct";
        } else {
          questionControllerInstance
              .answerSheet[int.parse(widget.questionNumber)] = "wrong";
        }

        questionControllerInstance
            .resultSheet[int.parse(widget.questionNumber)] = letters[index];
      }
      btn = btnSelected[index] ? Colors.lightBlue[200] : Colors.white;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
