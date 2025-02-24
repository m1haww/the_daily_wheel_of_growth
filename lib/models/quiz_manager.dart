import 'package:the_daily_wheel_of_growth/models/quiz.list.dart';

class QuizManager {
  final Map<String, int> _scores = {};

  void addScore(String question, int score) {
    _scores[question] = score;
    print("Score Added: $question -> $score"); // Debugging
  }

  Map<String, double> calculateCategoryScores(QuizData quizDataInstance) {
    Map<String, double> categoryScores = {};

    for (var category in quizDataInstance.categories) {
      int totalScore = 0;
      int maxScore = 15; // Assuming 3 questions per category

      for (var question in quizDataInstance.quizData
          .where((q) => q['category'] == category)) {
        int score = _scores[question['question']] ?? 0;
        print(
            "Category: $category, Question: ${question['question']}, Score: $score"); // Debugging
        totalScore += score;
      }

      double percentage = (totalScore / maxScore) * 100;
      categoryScores[category] = percentage;
      print("Final Score for $category: $percentage%"); // Debugging
    }

    return categoryScores;
  }

  void resetScores() {
    _scores.clear();
  }

  Map<String, int> get scores => _scores;
}
