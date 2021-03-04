import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../GetController/QuestionController.dart';
import 'AddHiveUser.dart';
import 'SelectHiveUser.dart';

class SelectUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Choose User"),
          bottom: TabBar(
            tabs: [
              Tab(child: Text("Select User")),
              Tab(child: Text("New User"))
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            SelectHiveUser(),
            AddHiveUser(questionControllerInstance: _questionControllerInstance)
          ],
        ),
      ),
    );
  }
}
