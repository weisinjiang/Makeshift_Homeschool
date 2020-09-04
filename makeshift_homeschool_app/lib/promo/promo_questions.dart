import 'package:makeshift_homeschool_app/models/quiz_model.dart';

Quiz getTutorPromoQuiz() {
  // questions in JSON format for Quiz model to parse
  Map<String, dynamic> tutorQuestions = {
    "question1": {
      "question": "What is an Introduction?",
      "correctOption": "How you start a post",
      "options": [
        "How you start a post",
        "How you end a post",
        "Where you say hello",
        "Where you put a picture"
      ],
    },
    "question2": {
      "question": "What is a body?",
      "correctOption": "Where you adress your three main points",
      "options": [
        "The second paragraph",
        "Where you say goodbye",
        "Where you adress your three main points",
        "The place where you put a video"
      ],
    },
    "question3": {
      "question": "What is the Conclusion?",
      "correctOption": "The ending of your post",
      "options": [
        "The beginning",
        "The ending of your post",
        "Your picture",
        "The place where you say hello"
      ],
    },
    "question4": {
      "question": "What is the Quiz section of a post?",
      "correctOption": "Questions about each body paragraph",
      "options": [
        "Where you make a video",
        "The place where you conclude",
        "You intruduce you post",
        "Questions about each body paragraph"
      ],
    },
  };

  Quiz quiz = Quiz(quizData: tutorQuestions);
  quiz.serializeQuizData(); // parse the json and format the questions
  return quiz;
}
