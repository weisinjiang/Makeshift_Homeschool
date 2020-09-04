class Quiz {
  Map<String, dynamic> quizData; // to be serialized
  List<Question> questionsList;

  Quiz({this.quizData}) {
    this.questionsList = [];
  }
  get getQuestionList => this.questionsList;
  get getQuestionListSize => this.questionsList.length;
  Question getQuestionAt(int index) => this.questionsList[index];

  void addQuestion(Question question) => this.questionsList.add(question);

  // shuffle the question list
  void shuffleQuestionList() => this.questionsList.shuffle();

  // convert the map into a list of Quiz objects that contains Questions
  // and objects
  void serializeQuizData() {
    List<Question> questions = [];
    Map<String, dynamic> quizData = this.quizData;

    for (var part in quizData.keys) {
      // gets the questions data on the part of the post, ie: body, intro, etc
      var questionData = quizData[part];

      // generate all options for the question
      List<Option> optionList = [];
      var correctOption = questionData["correctOption"];
      for (var optionValue in questionData["options"]) {
        var isCorrect = optionValue == correctOption;
        Option option = Option(correct: isCorrect, value: optionValue);
        optionList.add(option);
      }

      // get the question text and add the question to the list
      var questionText = questionData["question"];
      optionList.shuffle(); // shuffle the options
      Question question = Question(options: optionList, question: questionText);
      questions.add(question);
    }
    this.questionsList = questions;
  }
}

/*
  This is a class holds the avaliable options for the quiz question
  Option can be correct or incorrect
*/
class Option {
  String value;
  bool correct;

  Option({this.value, this.correct});

  bool get isCorrect => this.correct;
  String get getValue => this.value;
}

class Question {
  String question;
  List<Option> options;
  Question({this.question, this.options});

  get getQuestion => this.question;
  get getAllOptions => this.options;
  get getOption1 => this.options[0];
  get getOption2 => this.options[1];
  get getOption3 => this.options[2];
  get getOption4 => this.options[3];
}
