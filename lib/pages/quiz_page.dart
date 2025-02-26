import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_daily_wheel_of_growth/models/app_provider.dart';
import 'package:the_daily_wheel_of_growth/models/classes.dart';
import 'package:the_daily_wheel_of_growth/models/container.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/pages/quiz_result_page.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';
import 'package:the_daily_wheel_of_growth/models/quiz.list.dart';

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentIndex = 0;
  QuizData quizDataInstance = QuizData();
  late final List<Map<String, dynamic>> quizData;

  @override
  void initState() {
    super.initState();
    quizData = quizDataInstance.quizData;
  }

  int getScore(String option) {
    if (option.startsWith('🌟')) return 5;
    if (option.startsWith('😊')) return 4;
    if (option.startsWith('😌')) return 3;
    if (option.startsWith('🤔')) return 2;
    if (option.startsWith('😞')) return 1;
    return 0;
  }

  void selectAnswer(
      BuildContext context, String question, String category, String option) {
    print("Selected Option: $option");

    int score = getScore(option);
    print("Computed Score: $score");

    // Save score using AppProvider
    // Provider.of<AppProvider>(context, listen: false)
    //     .saveScore(category, question, score);

    Future.delayed(Duration(milliseconds: 300), () {
      if (currentIndex < quizData.length - 1) {
        setState(() {
          currentIndex++;
        });
      } else {
        // Calculate final category scores and navigate to result screen
        final categoryScores = Provider.of<AppProvider>(context, listen: false)
            .calculateCategoryScores(quizDataInstance);
        print("Final Calculated Scores: $categoryScores");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(categoryScores: categoryScores),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionData = quizData[currentIndex];

    return Scaffold(
      backgroundColor: kBlackDark,
      appBar: AppBar(
        backgroundColor: kBlackDark,
        title: buildAppbarTitle(
            context, "Question ${currentIndex + 1}/${quizData.length}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionData['question'],
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildHeight(context, 0.03),
            ...questionData['options'].map<Widget>(
              (option) {
                return Column(
                  children: [
                    buildContainer(
                      context,
                      () => selectAnswer(
                          context,
                          questionData['question'],
                          questionData[
                              'category'], // Ensure category is in the quiz data
                          option),
                      option,
                    ),
                    buildHeight(context, 0.02),
                  ],
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
