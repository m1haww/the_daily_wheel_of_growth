import 'package:flutter/material.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

Widget buildHeight(BuildContext context, double percentage) {
  final height = MediaQuery.of(context).size.height;
  return SizedBox(height: height * percentage);
}

Widget buildWidth(BuildContext context, double percentage) {
  final width = MediaQuery.of(context).size.width;
  return SizedBox(width: width * percentage);
}

Widget buildtext(BuildContext context, String text, Color color) {
  return Align(
    child: Text(
      text,
      textAlign: TextAlign.left,
      maxLines: 4,
      style: TextStyle(
          fontFamily: "Inter",
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: color),
    ),
  );
}

Widget buildAppbartext(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: "Inter",
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: kBlackLight),
  );
}

Widget buildtexttoday(
  BuildContext context,
  String text,
) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: "Inter",
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white),
  );
}
