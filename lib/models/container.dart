import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/pages/calendar_page.dart';
// import 'package:the_daily_wheel_of_growth/pages/note_page.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

Widget buildContainer(BuildContext context, VoidCallback onTap, String text) {
  final height = MediaQuery.of(context).size.height;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height * 0.07,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffCC16FB),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16), // Adaugă un spațiu la stânga
        child: Align(
          alignment: Alignment.centerLeft, // Aliniere la stânga
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildContainer1(BuildContext context, VoidCallback onTap, String text) {
  final height = MediaQuery.of(context).size.height;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height * 0.07,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kkPurpleDark,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

Widget buildAppbarLeading(BuildContext context) {
  return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Image(image: AssetImage("images/Frame (5).png")),
      ));
}

Widget buildAppbarAction(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 15.0),
    child: Image(image: AssetImage("images/Close.png")),
  );
}

Widget buildAppbarActionCalendar(BuildContext context, DateTime selectedDay) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Image(image: AssetImage("images/Layer_1 (1).png")),
    ),
  );
}

Widget buildTextField(BuildContext context, String text, Color colortext,
    Color colorbackground, Color colorhint,
    {required TextEditingController controller}) {
  final width = MediaQuery.of(context).size.width;
  return Container(
    width: width, // Set the width you desire

    child: TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: null, // Allow for multiple lines
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: colorhint,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: InputBorder.none,
      ),
      style: TextStyle(
        fontFamily: "Inter",
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: colortext,
      ),
      cursorColor: Colors.white,
    ),
  );
}

Widget buildTextFieldDescription(BuildContext context, String text,
    Color colortext, Color colorbackground, Color colorhint,
    {required TextEditingController controller}) {
  return Align(
    child: TextField(
      textAlign: TextAlign.left,
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: null,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: colorhint,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: InputBorder.none,
      ),
      style: TextStyle(
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: colortext,
      ),
      cursorColor: Colors.white,
    ),
  );
}

Widget buildSave(BuildContext context, VoidCallback onTap, String text) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height * 0.08,
      width: width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffCC16FB),
      ),
      child: Align(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}

Widget buildTextFieldOption(BuildContext context, String text, Color colortext,
    Color colorbackground, Color colorhint,
    {required TextEditingController controller}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Align(
    child: Container(
      width: double.infinity,
      height: height * 0.05,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: kBlackLight),
      child: TextField(
        textAlign: TextAlign.left,
        controller: controller,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: colorhint,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: colortext,
        ),
        cursorColor: Colors.black,
      ),
    ),
  );
}

Widget buildContainerSettings(
  BuildContext context,
  String text,
) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Container(
    width: double.infinity,
    height: height * 0.06,
    decoration: BoxDecoration(
        color: kkPurpleDark, borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildContainerSettings1(
  BuildContext context,
  String text,
) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Container(
    width: double.infinity,
    height: height * 0.06,
    decoration: BoxDecoration(
        color: Color(0xffCC16FB), borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
