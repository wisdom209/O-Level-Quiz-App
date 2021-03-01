import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'GetController/QuestionController.dart';
import 'Screens/Home.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final QuestionController questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "Quiz App",
        defaultTransition: Transition.leftToRightWithFade,
        theme: ThemeData(primarySwatch: Colors.green, textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
        home: Home());
  }
}
