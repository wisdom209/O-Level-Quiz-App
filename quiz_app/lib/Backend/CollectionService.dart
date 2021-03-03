// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:quiz_app/GetController/QuestionController.dart';

// class CollectionService {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   final CollectionReference progressCollection =
//       FirebaseFirestore.instance.collection('progress');
//   final CollectionReference detailsCollection =
//       FirebaseFirestore.instance.collection('details');

//   final QuestionController _questionControllerInstance = Get.find();

//   Future updateProgress({String subject, int score}) {
//     final CollectionReference progressCollection =
//         FirebaseFirestore.instance.collection('$subject progress');
//     try {
//       return progressCollection
//           .doc("${_auth.currentUser.uid}")
//           .set({DateTime.now().toString(): score}, SetOptions(merge: true));
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<dynamic> readProgress({String subject}) async {
//     final CollectionReference progressCollection =
//         FirebaseFirestore.instance.collection('$subject progress');
//     var docQuery;
//     try {
//       docQuery = await progressCollection.doc("${_auth.currentUser.uid}").get();
//     } catch (e) {
//       return null;
//     }

//     if (docQuery.exists) {
//       try {
//         _questionControllerInstance.subjectScores["${subject.toLowerCase()}"] =
//             docQuery.data();
//       } catch (e) {
//         return null;
//       }

//       return docQuery.data();
//     } else {
//       _questionControllerInstance.subjectScores["${subject.toLowerCase()}"] =
//           {};
//       return {};
//     }
//   }

//   Future getUserNameFuture() async {
//     try {
//       var name = await detailsCollection.doc("${_auth.currentUser.uid}").get();

//       _questionControllerInstance.displayName.value = name.get("name");
//       return name.get("name");
//     } catch (e) {
//       return "User";
//     }
//   }
// }
