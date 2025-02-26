import 'package:flutter/material.dart';
import 'package:the_daily_wheel_of_growth/models/classes.dart';
import 'package:the_daily_wheel_of_growth/models/container.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class DecisionsOptionsInfoPage extends StatefulWidget {
  final Decisions decisions;

  const DecisionsOptionsInfoPage({super.key, required this.decisions});

  @override
  State<DecisionsOptionsInfoPage> createState() =>
      _DecisionsOptionsInfoPageState();
}

class _DecisionsOptionsInfoPageState extends State<DecisionsOptionsInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kkBlueLight, // Set background color of the whole screen
      appBar: AppBar(
        backgroundColor: kkBlueLight,
        leading: buildAppbarLeading(context),
        title: Text(
          "Decision Details",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // This allows scrolling if content overflows
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centers content vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centers content horizontally
              children: [
                buildHeight(context, 0.04),

                // Title Section - Centered Text
                Center(
                  child: Text(
                    widget.decisions.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                buildHeight(context, 0.4),

                // Option 1
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kBlackLight,
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle,
                            color: Colors.white), // Icon for option
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.decisions.option1,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                buildHeight(context, 0.02),

                // Option 2
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kBlackLight,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.decisions.option2,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Option 3 - Displayed only if it exists
                if (widget.decisions.option3 != null) SizedBox(height: 15),
                if (widget.decisions.option3 != null)
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kBlackLight,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              widget.decisions.option3!,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
