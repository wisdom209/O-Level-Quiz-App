import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Backend/AuthService.dart';
import '../Components/TextFieldItem.dart';
import '../GetController/QuestionController.dart';
import 'Dashboard.dart';
import 'LoginScreen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();

    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
          leading: Icon(
            Icons.app_registration,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            padding: EdgeInsets.all(8.0),
            child: Text("Continue as guest",style: TextStyle(color: Colors.grey[100]),),
            onPressed: () {
              Get.offAll(Dashboard());
            },
            color: Colors.green,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: SvgPicture.asset("images/Good-Grade.svg")),
                TextFieldItem(
                    iconData: Icons.person,
                    hintText: "Enter your name",
                    content: "name"),
                TextFieldItem(
                    iconData: Icons.mail,
                    hintText: "Enter your email",
                    content: "email"),
                TextFieldItem(
                    iconData: Icons.lock,
                    hintText: "Enter your password",
                    content: "password"),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FlatButton(
                    minWidth: MediaQuery.of(context).size.width * 0.98,
                    color:Colors.green,
                    onPressed: () {
                      String name = _questionControllerInstance.userName.value;
                      String email =
                          _questionControllerInstance.emailName.value;
                      String password =
                          _questionControllerInstance.passwordName.value;

                      AuthService()
                          .registerUserWithEmailAndPassword(
                              email: email, password: password, name: name)
                          .then((data) {
                        if (!data.toString().contains("Error") && data != null) {
                          Get.offAll(Dashboard());
                        } else {
                          Get.snackbar("Check internet Connnection", data.toString(),
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      });
                      // .catchError((e) => Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM));
                      //.then((data) => Get.offAll(Dashboard()));
                    },
                    child: Text("REGISTER", style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 2, color: Colors.grey[100]),),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("Already have an account?"),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FlatButton(
                    minWidth: MediaQuery.of(context).size.width * 0.98,
                    color: Colors.green,
                    child: Text("LOGIN", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold,color: Colors.grey[100]),),
                    onPressed: () {
                      Get.to(LoginScreen(),
                          transition: Transition.leftToRightWithFade);
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ));
  }
}
