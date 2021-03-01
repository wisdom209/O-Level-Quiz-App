import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {
  const AnswerButton({Key key, @required this.answer}) : super(key: key);
  final String answer;

  @override
  _AnswerButtonState createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  bool showAnswer = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            setState(() {
              showAnswer = !showAnswer;
            });
          },
          color: Colors.brown[400],
          child: Center(
              child: Text(
            showAnswer? widget.answer.toUpperCase() : "Show Answer",
            style: TextStyle(fontSize: 20, color: Colors.grey[100]),
          )),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.5)),
        ));
  }
}
