import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_daily_wheel_of_growth/pages/home_page.dart';
import 'package:the_daily_wheel_of_growth/pages/navigation_page.dart';
import 'package:the_daily_wheel_of_growth/pages/onboarding_page.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => OnboardingPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          "images/Untitled 1.png",
          fit: BoxFit.cover,
        )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image(image: AssetImage("images/splash_img.png")))
            ],
          )),
        ),
      ],
    );
  }
}
