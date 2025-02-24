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
