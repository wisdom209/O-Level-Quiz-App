import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:quiz_app/GetController/QuestionController.dart';

import '../Screens/SelectChallenge.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    Key key,
    @required this.width,
    @required this.height,
    @required this.subject,
    this.svgToLoad
  }) : super(key: key);

  final double width;
  final double height;
  final String subject;
  final String svgToLoad;

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        _questionControllerInstance.subjectedSelected.value = subject.toLowerCase();
        Get.to(SelectChallenge(), transition: Transition.leftToRightWithFade);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            SizedBox(
              width: width * 0.45,
              height: height * 0.3,
              child: Card(
                elevation: 8.0,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SizedBox(
                      
                      height: height * 0.20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(svgToLoad, allowDrawingOutsideViewBox: true,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                      child: Text(subject, style: TextStyle(fontSize: 20),))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
