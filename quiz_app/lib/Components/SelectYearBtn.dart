import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:quiz_app/GetController/QuestionController.dart';
import 'package:quiz_app/Screens/Questions.dart';
import '../Constants/AppConstants.dart';

class SelectYearBtn extends StatelessWidget {
  const SelectYearBtn({Key key, @required this.year}) : super(key: key);

  final String year;

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    return GestureDetector(
      onTap: () {
        _questionControllerInstance.selectedYear.value = year;
        Get.to(Questions(), transition: Transition.rightToLeftWithFade);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.2,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(3)),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                year,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            )),
            SizedBox(
                height: 15,
                child: SvgPicture.string(
                  AppConstants().penSvg,
                  color: Colors.brown,
                ))
          ],
        ),
      ),
    );
  }
}
