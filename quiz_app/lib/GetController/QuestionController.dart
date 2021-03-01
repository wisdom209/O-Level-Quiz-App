import 'package:get/get.dart';

class QuestionController extends GetxController {
  Map resultSheet = {}.obs;
  List possibleReviewQuestions = [].obs;
  var isReview = false.obs;
  var isStudy = false.obs;
  var isExam = false.obs;
  var selectedYear = "1979".obs;
  var subjectedSelected = "Select an option".obs;
  Map answerSheet = {}.obs;
  var userName = "".obs;
  var emailName = "".obs;
  var passwordName = "".obs;
  var isGuest = true.obs;
  var displayName = "Dashboard".obs;
  Map questionBank = {}.obs;
  var questionChosen = "".obs;
  Map subjectScores = {
    "chemistry": {},
    "mathematics": {},
    "crs": {},
    "physics": {},
    "biology": {},
    "literature-in-english": {},
    "government": {},
  }.obs;
}
