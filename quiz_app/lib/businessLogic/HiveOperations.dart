import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../GetController/QuestionController.dart';

part 'HiveOperations.g.dart';

@HiveType(typeId: 1)
class Person {
  @HiveField(0)
  String name;

  @HiveField(1)
  Map mathematics = {};

  @HiveField(2)
  Map literature = {};

  @HiveField(3)
  Map chemistry = {};

  @HiveField(4)
  Map crs = {};

  @HiveField(5)
  Map government = {};

  @HiveField(6)
  Map biology = {};

  @HiveField(7)
  Map physics = {};
}

class HiveManipulation {
  register() {
    Hive.registerAdapter(PersonAdapter());
    // Hive.openBox("AppBox");
  }

  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  openHiveBox() async {
    await Hive.openBox("AppBox");
  }

  addUser({String userName}) async {
    userName = userName.toLowerCase();
    var box = await Hive.openBox("AppBox");

    if (box.get("users") != null) {
      if (box.get("users").contains(userName)) {
        print(box.get("users"));
        print("username already exists");
        return "username already exists";
      }
      List users = box.get("users");
      users.add(userName);
      box.put("users", users);
    } else {
      box.put("users", [userName]);
    }
    box.put(userName, {
      "name": userName,
      "chemistry": {},
      "mathematics": {},
      "biology": {},
      "physics": {},
      "crs": {},
      "government": {},
      "literature": {}
    });
  }

  getAllUsers() async {
    var box = await Hive.openBox("AppBox");

    var userList = await box.get("users");
    if (userList != null) {
      print(userList);
    }
    return userList;
  }

  clearUserList() async {
    var box = await Hive.openBox("AppBox");
    var users = await box.get("users");

    for (var i = 0; i < users.length; i++) {
      box.delete(users[i]);
    }

    box.delete("users");
  }

  removeUser({String userName}) async {
    userName = userName.toLowerCase();
    var box = await Hive.openBox("AppBox");

    var userList = await box.get("users");
    if (userList.contains(userName)) {
      userList.remove(userName);
      box.put("users", userList);
    }

    box.delete(userName);
  }

  addScore(
      {String userName, String subject = "chemistry", var score = 20}) async {
    var box = await Hive.openBox("AppBox");
    print(userName);
    var personData = await box.get(userName);
    print(personData);
    personData[subject][DateTime.now().toIso8601String()] = score;
  }

  getAllScores({String username, String subject}) async {
    username = username.toLowerCase();
    subject = subject.toLowerCase();
    var box = await Hive.openBox("AppBox");

    var personData = box.get(username);
    return personData[subject];
  }

  readProgress({String username, String subject}) async {
    QuestionController _questionControllerInstance = Get.find();
    var progressData;
    try {
      progressData = await getAllScores(subject: subject, username: username);
    } catch (e) {
      print(e.toString());
    }

    if (progressData == null) {
      _questionControllerInstance.subjectScores["${subject.toLowerCase()}"] =
          {};
    } else {
      _questionControllerInstance.subjectScores["${subject.toLowerCase()}"] =
          progressData;
    }
    print(_questionControllerInstance.subjectScores["${subject.toLowerCase()}"]);
  }
}
