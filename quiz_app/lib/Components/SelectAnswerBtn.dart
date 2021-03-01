import 'package:flutter/material.dart';
import 'package:flutter_math/flutter_math.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import '../GetController/QuestionController.dart';

class SelectAnswerBtn extends StatelessWidget {
  SelectAnswerBtn({
    Key key,
    this.option,
    this.optionText,
    this.answer,
    this.questionNumber,
    this.index,
    this.selectFunction,
    this.btnColor,
    this.optionLetter,
  }) : super(key: key);

  final String option;
  final String optionText;
  final String answer;
  final String optionLetter;
  final Color btnColor;
  final Function selectFunction;
  final int index;
  final int questionNumber;

  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          // onPressed: (){},
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black), color: btnColor),
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical:8 ),
                child: GestureDetector(
                  child:Text("$option."), onTap: selectFunction,),
              ),
              //Text("$option.   "),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: SizedBox(
                  
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: ((_questionControllerInstance
                                        .subjectedSelected.value ==
                                    "chemistry" ||
                                _questionControllerInstance
                                        .subjectedSelected.value ==
                                    "mathematics" ||
                                _questionControllerInstance
                                        .subjectedSelected.value ==
                                    "physics") &&
                            (optionText.contains("frac") ||
                                optionText.contains('sqrt') ||
                                optionText.contains('theta') ||
                                optionText.contains('delta') ||
                                optionText.contains('}')))
                        ? Math.tex(
                            optionText,
                            onErrorFallback: (context) => TeXView(
                              renderingEngine: TeXViewRenderingEngine.katex(),
                              loadingWidgetBuilder: (context) =>
                                  Text("Loading . . ."),
                              child: TeXViewDocument(optionText),
                            ),
                          )
                        : Text(
                            optionText,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          )),
              )
            ],
          ),
          // shape: RoundedRectangleBorder(
          //     side: BorderSide(color: Colors.black, width: 0.5)),
        ));
  }
}
