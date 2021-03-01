class QuestionModel {
  QuestionModel({this.questionData, this.index, this.year});
  int index;
  dynamic questionData;
  String year;
  String question;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String optionE;
  String answer;
  String image;

  initializeData() {
    question = questionData['questions']['$year']["${index + 1}"]["question"];
    optionA = questionData['questions']['$year']["${index + 1}"]['a'];
    optionB = questionData['questions']['$year']["${index + 1}"]['b'];
    optionC = questionData['questions']['$year']["${index + 1}"]['c'];
    optionD = questionData['questions']['$year']["${index + 1}"]['d'];
    optionE = questionData['questions']['$year']["${index + 1}"]['e'];
    answer = questionData['questions']['$year']["${index + 1}"]['answer'];
    image = questionData['questions']['$year']["${index + 1}"]['image'];
  }
}
