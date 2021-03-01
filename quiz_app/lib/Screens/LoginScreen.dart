import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Backend/AuthService.dart';
import 'package:quiz_app/Backend/CollectionService.dart';
import 'package:quiz_app/GetController/QuestionController.dart';
import 'package:quiz_app/Screens/Dashboard.dart';
import 'package:quiz_app/Screens/RegisterScreen.dart';

import '../Components/TextFieldItem.dart';
import '../Constants/AppConstants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key, this.svgToLoad}) : super(key: key);
  final String svgToLoad;

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        leading: Icon(
          Icons.login,
          color: Colors.white,
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 1:
                  Get.offAll(RegisterScreen(),
                      transition: Transition.leftToRightWithFade);
                  break;
                default:
                  Get.to(Dashboard());
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Sign Up"),
                value: 1,
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          padding: EdgeInsets.all(8.0),
          child: Text("Continue as guest"),
          onPressed: () {
            Get.offAll(Dashboard());
          },
          color: Colors.green,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: SvgPicture.asset("images/Good-Grade.svg")),
            TextFieldItem(
              iconData: Icons.mail,
              hintText: "Email",
              content: "email",
              loginScreen: true,
            ),
            TextFieldItem(
              iconData: Icons.lock,
              hintText: "Password",
              content: 'password',
              loginScreen: true,
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.lightBlue, fontSize: 10),
                ),
                onPressed: () {
                  Get.defaultDialog(
                      onConfirm: () {
                        if (_questionControllerInstance.emailName.value == '') {
                          Get.snackbar("Incomplete data",
                              "Enter email to reset password",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                              snackStyle: SnackStyle.GROUNDED);
                        } else {
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: _questionControllerInstance
                                      .emailName.value)
                              .then((data) {
                            Get.snackbar("Success",
                                "Check your email for your new password");
                          }).catchError((e) {
                            Get.snackbar("Error encountered", e.toString());
                          });
                        }
                      },
                      title: "Reset password",
                      middleText:
                          "Are you sure you want to reset your password?",
                      textConfirm: "Okay",
                      textCancel: "Cancel",
                      confirmTextColor: Colors.white);
                },
              ),
            ),
            FlatButton(
              child: Text("Continue"),
              onPressed: () {
                CollectionService().getUserNameFuture();
                String email = _questionControllerInstance.emailName.value;
                String password =
                    _questionControllerInstance.passwordName.value;
                AuthService().signInWithEmailAndPassword(
                    email: email, password: password);
              },
              color: AppConstants().primaryColour,
              minWidth: MediaQuery.of(context).size.width * 0.95,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
