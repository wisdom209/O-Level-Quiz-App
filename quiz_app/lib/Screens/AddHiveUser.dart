import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Components/TextFieldItem.dart';
import 'package:quiz_app/GetController/QuestionController.dart';
import 'package:quiz_app/businessLogic/HiveOperations.dart';

import 'Dashboard.dart';

class AddHiveUser extends StatelessWidget {
  const AddHiveUser({
    Key key,
    @required QuestionController questionControllerInstance,
  })  : _questionControllerInstance = questionControllerInstance,
        super(key: key);

  final QuestionController _questionControllerInstance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 8),
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: SvgPicture.asset("images/Good-Grade.svg")),
          TextFieldItem(
            iconData: Icons.person_add,
            hintText: "Enter your username",
            content: "hiveUserName",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FlatButton(
                minWidth: MediaQuery.of(context).size.width,
                color: Colors.green,
                onPressed: () async {
                  if (_questionControllerInstance.hiveUserName.value.length >
                          2 &&
                      _questionControllerInstance.hiveUserName.value.length <
                          11) {
                    var result = await HiveManipulation().addUser(
                      userName: _questionControllerInstance.hiveUserName.value,
                    );
                    
                    if (result == "username already exists") {
                      Get.snackbar("Info", "Username already exists",
                          snackPosition: SnackPosition.BOTTOM);
                      return null;
                    }
                    Get.offAll(Dashboard());
                  }
                  
                },
                child: Text(
                  "Continue",
                  style: TextStyle(letterSpacing: 2),
                )),
          )
        ],
      ),
    );
  }
}
