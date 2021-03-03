import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/GetController/QuestionController.dart';

class TextFieldItem extends StatelessWidget {
  const TextFieldItem(
      {Key key,
      @required this.iconData,
      this.hintText,
      this.content,
      this.loginScreen})
      : super(key: key);

  final IconData iconData;
  final String hintText;
  final String content;
  final bool loginScreen;

  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: TextFormField(
          autofocus: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: hintText == "Password" ? true : false,
          validator: (value) {
            if (loginScreen == true || loginScreen != null) {
              return null;
            } else {
              if (content == "email") {
                if (!GetUtils.isEmail(value) && value != "") {
                  _questionControllerInstance.emailName.value = "invalid";

                  return 'Email is not valid';
                }
                return null;
              } else if (content == "password" && value != "") {
                if (!GetUtils.isLengthGreaterThan(value, 4)) {
                  _questionControllerInstance.passwordName.value = "invalid";
                  return "Password should be 5 characters or more";
                }
                return null;
              } else if (content == "name" && value != "") {
                if (!GetUtils.isLengthGreaterThan(value, 2)) {
                  _questionControllerInstance.userName.value = "invalid";
                  return "Name should be 3 characters or more";
                }
                return null;
              }
              else if (content == "hiveUserName" && value != "") {
                if (!GetUtils.isLengthGreaterThan(value, 2) || GetUtils.isLengthGreaterThan(value,10)) {
                  _questionControllerInstance.hiveUserName.value = "";
                  return "Name should be 3 characters or more";
                }
                return null;
              }
               else {
                return null;
              }
            }
          },
          onChanged: (text) {
            if (content == "name") {
              _questionControllerInstance.userName.value = text;
            } else if (content == "email") {
              _questionControllerInstance.emailName.value = text;
            } else if (content == "hiveUserName") {
              _questionControllerInstance.hiveUserName.value = text;
            } else {
              _questionControllerInstance.passwordName.value = text;
            }
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.grey[400],
              )),
              prefixIcon: Icon(
                iconData,
                color: Colors.green,
              ),
              hintText: hintText,
              alignLabelWithHint: true,
              hintStyle: TextStyle(
                letterSpacing: 0,
                color: Colors.grey[600],
              ))),
    );
  }
}
