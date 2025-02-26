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
      appBar: AppBar(
        backgroundColor: kBlackDark,
        title: Text("Your Decisions", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeight(context, 0.02), // Small spacing at the top

            // ✅ Expanded at the top (ListView takes all available space)
            Expanded(
              child: decisions.isNotEmpty
                  ? ListView.builder(
                      itemCount: decisions.length,
                      itemBuilder: (context, index) {
                        final decision = decisions[index];
                        return GestureDetector(
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
                                          image: AssetImage("images/wheel.png"))
                                    ]),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No decisions yet. Add one!",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
            ),

            buildHeight(context, 0.02), // Space between list and FAB

            // ✅ Floating Action Button BELOW the list
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
            ),

            buildHeight(context, 0.02), // Small spacing at the bottom
          ],
        ),
      ),
    );
  }
}
