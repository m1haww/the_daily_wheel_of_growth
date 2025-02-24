import 'package:flutter/material.dart';
import 'package:the_daily_wheel_of_growth/models/classes.dart';
import 'package:the_daily_wheel_of_growth/models/quiz.list.dart';
import 'package:the_daily_wheel_of_growth/models/quiz_manager.dart';

class AppProvider extends ChangeNotifier {
  var directorypath = "";
  final List<Home> _home = [];
  List<Home> get home => _home;

  final QuizManager _quizManager = QuizManager();

  void addEvent(Home home) {
    _home.add(home);
    notifyListeners();
  }

  void addScore(String question, int score) {
    _quizManager.addScore(question, score);
    print("AppProvider: Score saved for $question -> $score"); // Debugging
    notifyListeners();
  }

  Map<String, double> calculateCategoryScores(QuizData quizDataInstance) {
    var scores = _quizManager.calculateCategoryScores(quizDataInstance);
    print("AppProvider: Final Calculated Scores: $scores"); // Debugging
    return scores;
  }

  void resetScores() {
    _quizManager.resetScores();
    notifyListeners();
  }
}
