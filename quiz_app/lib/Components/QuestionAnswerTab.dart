import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_math/flutter_math.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import '../GetController/QuestionController.dart';

class QuestionAnswerTab extends StatelessWidget {
  QuestionAnswerTab({
    this.optionText,
  });

  final String optionText;

  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();

    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          margin: EdgeInsets.only(right: 8),
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[800], width: 0.2),
              color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
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
