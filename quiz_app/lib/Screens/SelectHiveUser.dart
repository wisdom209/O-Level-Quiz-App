import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/GetController/QuestionController.dart';
import 'package:quiz_app/Screens/Dashboard.dart';
import 'package:quiz_app/businessLogic/HiveOperations.dart';

class SelectHiveUser extends StatelessWidget {
  const SelectHiveUser({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionControllerInstance = Get.find();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: FlatButton(
          color: Colors.green,
          disabledColor: Colors.grey,
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            List appUsers = await HiveManipulation().getAllUsers();
            if (appUsers == null) {
              return null;
            }

            HiveManipulation().clearUserList();
          },
          child: Text("Clear all users"),
        ),
      ),
      body: FutureBuilder(
        future: HiveManipulation().openHiveBox(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ValueListenableBuilder(
              valueListenable: Hive.box("AppBox").listenable(),
              builder: (context, value, child) => FutureBuilder(
                  future: HiveManipulation().getAllUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null || snapshot.data.length < 1) {
                        return Center(
                            child: Text("There are currently no users"));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black, width: 0.3)),
                            child: ListTile(
                              title: Text(
                                snapshot.data[index].toUpperCase(),
                                style: TextStyle(letterSpacing: 2),
                              ),
                              onTap: () {
                                _questionControllerInstance.hiveUserName.value =
                                    snapshot.data[index];
                                Get.offAll(Dashboard());
                              },
                              trailing: GestureDetector(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red[400],
                                ),
                                onTap: () {
                                  HiveManipulation().removeUser(
                                      userName: snapshot.data[index]);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: Text("Loading . . ."));
                  }),
            );
          }
          return Text("Loading...");
        },
      ),
    );
  }
}
