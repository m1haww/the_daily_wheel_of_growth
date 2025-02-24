import 'package:flutter/material.dart';
import 'package:the_daily_wheel_of_growth/models/container.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class DecisionsDetailsPage extends StatefulWidget {
  const DecisionsDetailsPage({super.key});

  @override
  State<DecisionsDetailsPage> createState() => _DecisionsDetailsPageState();
}

class _DecisionsDetailsPageState extends State<DecisionsDetailsPage> {
  final TextEditingController _controllerdecisions = TextEditingController();
  final TextEditingController _controlleroption = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackDark,
      appBar: AppBar(
        backgroundColor: kBlackDark,
        leading: buildAppbarLeading(context),
        // actions: [buildSave(context, onTap, text)],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeight(context, 0.02),
            buildTextField(context, "What decision do you need to make?",
                Colors.white, Colors.transparent, kBlackLight,
                controller: _controllerdecisions),
            buildHeight(context, 0.02),
            buildTextFieldOption(context, "Add Option", Colors.white,
                Colors.transparent, Color(0xffCCCCCC),
                controller: _controlleroption),
            buildHeight(context, 0.02),
            buildTextFieldOption(context, "Add Option", Colors.white,
                Colors.transparent, Color(0xffCCCCCC),
                controller: _controlleroption),
          ],
        ),
      )),
    );
  }

  Widget buildSavee(BuildContext context, VoidCallback onTap, String text) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.06,
        width: width * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kkPurpleDark,
        ),
        child: Align(
          child: Text(
            text,
            textAlign: TextAlign.center,
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
}
