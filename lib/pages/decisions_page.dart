import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_daily_wheel_of_growth/pages/decisions_details_page.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class DecisionsPage extends StatefulWidget {
  const DecisionsPage({super.key});

  @override
  State<DecisionsPage> createState() => _DecisionsPageState();
}

class _DecisionsPageState extends State<DecisionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackDark,
      appBar: AppBar(
        backgroundColor: kBlackDark,
        title: Text(""),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: FloatingActionButton(
              backgroundColor: kkPurpleDark,
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => DecisionsDetailsPage(),
                    ));
              },
              child: Icon(
                Icons.add,
                size: 24,
                color: Colors.white,
              ),
            ),
          )
        ],
      )),
    );
  }
}
