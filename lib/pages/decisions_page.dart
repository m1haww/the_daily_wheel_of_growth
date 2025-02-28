import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_daily_wheel_of_growth/models/app_provider.dart';
import 'package:the_daily_wheel_of_growth/models/classes.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/pages/decisions_details_page.dart';
import 'package:the_daily_wheel_of_growth/pages/decisions_options_info_page.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class DecisionsPage extends StatefulWidget {
  const DecisionsPage({super.key});

  @override
  State<DecisionsPage> createState() => _DecisionsPageState();
}

class _DecisionsPageState extends State<DecisionsPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<AppProvider>(context);
    final decisions = provider.decisions; // Get decisions list from provider

    return Scaffold(
      backgroundColor: kBlackDark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeight(context, 0.05),

            Center(
              child: Text(
                "Decisions",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: kBlackLight),
              ),
            ),
            buildHeight(context, 0.02), // Small spacing at the top

            // ListView without Expanded
            decisions.isNotEmpty
                ? ListView.builder(
                    shrinkWrap:
                        true, // Allows ListView to take only required space
                    physics:
                        NeverScrollableScrollPhysics(), // Prevents scroll within the ListView
                    itemCount: decisions.length,
                    itemBuilder: (context, index) {
                      final decision = decisions[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        DecisionsOptionsInfoPage(
                                            decisions: decision),
                                  ));
                            },
                            child: Container(
                              width: double.infinity,
                              height: height * 0.15,
                              child: Card(
                                color: kBlackLight,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 14.0,
                                    right: 14.0,
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(decision.title,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        buildWidth(context, 0.04),
                                        Image(
                                            image:
                                                AssetImage("images/wheel.png")),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 10), // Add vertical space between items
                        ],
                      );
                    },
                  )
                : SizedBox.shrink(),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => DecisionsDetailsPage(),
                    ));
              },
              child: Center(
                child: Container(
                    width: width * 0.15,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kkPurpleDark,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 24,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),

            buildHeight(context, 0.04),
          ],
        ),
      ),
    );
  }
}
