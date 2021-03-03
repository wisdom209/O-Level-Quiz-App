// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:quiz_app/GetController/QuestionController.dart';
// import 'package:quiz_app/Screens/Dashboard.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final CollectionReference detailsCollection =
//       FirebaseFirestore.instance.collection('details');
//   final CollectionReference questionCollection =
//       FirebaseFirestore.instance.collection('chemistry');
//   final QuestionController _questionControllerInstance = Get.find();

//   Future signInWithEmailAndPassword({String email, String password}) async {
//     try {
//       await _auth
//           .signInWithEmailAndPassword(email: email, password: password)
//           .then((d) {
//         _questionControllerInstance.isGuest.value = false;
//         Get.offAll(Dashboard());
//         return d;
//       }).catchError((e) {
//         Get.snackbar('Error', e.toString());
//         _questionControllerInstance.isGuest.value = true;
//       });
//     } catch (e) {
//       _questionControllerInstance.isGuest.value = true;

//       return null;
//     }
//   }

//   Future registerUserWithEmailAndPassword(
//       {String email, String password, String name}) async {
    
//     if (email == "") {
//       print('hi');
//       return 'Error: Email is not valid';
//     }
//     if (!GetUtils.isEmail(email) && email != "") {
//       _questionControllerInstance.emailName.value = "invalid";
//       return 'Error: Email is not valid';
//     }
//     if (!GetUtils.isLengthGreaterThan(password, 4)) {
//       _questionControllerInstance.passwordName.value = "invalid";
//       return "Error: Password should be 5 characters or more";
//     }

//     if (!GetUtils.isLengthGreaterThan(name, 2)) {
//       _questionControllerInstance.userName.value = "invalid";
//       return "Error: Name should be 3 characters or more";
//     }

//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       User user = result.user;
//       detailsCollection.doc("${_auth.currentUser.uid}").set({"name": name});
//       _questionControllerInstance.isGuest.value = false;
//       print('returning');
//       return user;
//     } catch (e) {
//       _questionControllerInstance.isGuest.value = true;
//       return ("Error: " + e.toString());
//     }
//   }

//   Future signOut() async {
//     try {
//       return await _auth.signOut().then((value) {
//         _questionControllerInstance.displayName.value = 'Dashboard';
//         _questionControllerInstance.isGuest.value = true;
//       });
//     } catch (e) {
//       return null;
//     }
//   }
// }
