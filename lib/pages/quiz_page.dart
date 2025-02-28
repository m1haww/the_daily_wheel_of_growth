import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_daily_wheel_of_growth/models/app_provider.dart';
import 'package:the_daily_wheel_of_growth/models/classes.dart';
import 'package:the_daily_wheel_of_growth/models/container.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/pages/navigation_page.dart';
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

    Provider.of<AppProvider>(context, listen: false).addScore(question, score);

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
            builder: (context) =>
                QuizResultPage(categoryScores: categoryScores),
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
        leading: buildAppbarLeading(context),
        centerTitle: false,
        title: buildAppbartext(context, "Previous"),
        actions: [
          GestureDetector(
              onTap: () => _showActionSheet(context),
              child: buildAppbarAction(context))
        ],
        backgroundColor: kBlackDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProgressBar(),
            buildHeight(context, 0.03),
            Text(
              questionData['question'],
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter"),
            ),
            buildHeight(context, 0.09),
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

  Widget buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: (currentIndex + 1) / quizData.length,
          color: kkPurpleDark,
          backgroundColor: Color(0xffCD16FC),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  void _showActionSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Leaving the Test?",
            style: TextStyle(
              fontFamily: "Sf",
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          content: const Text(
            "If you exit now, your progress won’t be saved. Do you want to continue or stay and finish the test?",
            style: TextStyle(
              fontFamily: "Sf",
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog and continue the quiz
                Navigator.pop(context);
              },
              child: const Text(
                "Stay & Continue",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff007AFF),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Exit and navigate to the navigation page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationPage(),
                  ),
                );
              },
              child: const Text(
                "Leave the test",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffFF3B30),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
