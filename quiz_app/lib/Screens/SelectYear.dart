import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Components/SelectYearBtn.dart';
import 'Dashboard.dart';
import 'ProgressScreen.dart';
import 'SelectUser.dart';


class SelectYear extends StatelessWidget {
  const SelectYear({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    List yearList = [];
    for (var i = 0; i < 42; i++) {
      if (i == 18) {
        continue;
      }
      yearList.add("${i + 1978}");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Year"),
        actions: [
          PopupMenuButton(
            padding: EdgeInsets.zero,
            elevation: 0,
            onSelected: (value) {
              if (value == 2) {
                Get.to(ProgressScreen(),
                    transition: Transition.leftToRightWithFade);
              }
              if (value == 3) {
                Get.offAll(SelectUser());
              }
              if (value == 1) {
                Get.offAll(Dashboard(),
                    transition: Transition.leftToRightWithFade);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Dashboard"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Progress"),
                value: 2,
              ),
               PopupMenuItem(
                      child: Text("Change User"),
                      value: 3,
                    ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[400]),
        child: ListView.builder(
            itemCount: yearList.length,
            itemBuilder: (context, index) => SelectYearBtn(
                  year: yearList[index],
                )),
      ),
    );
  }
}
