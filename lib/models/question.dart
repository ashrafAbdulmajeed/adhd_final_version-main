//mode for questions to be used in data
class Question {
  int? id;
  String? question;
  Map<String, int>? answerChoices;
  String? errorText;

  Question({
    required this.id,
    required this.question,
    required this.answerChoices,
    required this.errorText,
  });
}
