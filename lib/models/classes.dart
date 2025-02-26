import 'dart:io';

class Home {
  final String title;
  final String description;
  final String image;
  final DateTime date;
  File? fileImage;
  bool isown = false;
  Home(
      {required this.title,
      required this.description,
      required this.date,
      required this.image});
}

class Decisions {
  final String title;
  final String option1;
  final String option2;
  String? option3;
  Decisions(
      {required this.title, required this.option1, required this.option2});
}
