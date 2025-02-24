import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_daily_wheel_of_growth/models/container.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/pages/quiz_page.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackDark,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeight(context, 0.15),
            Align(
              alignment: Alignment.center,
              child: Image.asset("images/splash_img.png"),
            ),
            buildHeight(context, 0.1),
            Center(
              child: Image(
                image: AssetImage("images/The Daily Wheel of Growth.png"),
                fit: BoxFit.cover,
              ),
            ),
            buildHeight(context, 0.02),
            Center(
              child: buildtext(
                  context,
                  "📌 Unlock your full potential by reflecting on your life balance, setting meaningful goals, and making confident decisions",
                  Colors.white),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Center(
                  child: buildContainer(context, () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => QuizPage(),
                    ));
              }, "Get Started")),
            )
          ],
        ),
      )),
    );
  }
}
