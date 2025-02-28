import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/pages/navigation_page.dart';
import 'package:the_daily_wheel_of_growth/pages/quiz_page.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class QuizResultPageOrigin extends StatelessWidget {
  final Map<String, double> categoryScores;

  QuizResultPageOrigin({required this.categoryScores});

  final List<Color> sectionColors = [
    Color(0xffCC16FB),
    kBlueDark,
    kGreenLIght,
    kYellow,
    kRed,
    kkBlueLight,
    kGreenDark,
    kOrange
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    List<String> categories = categoryScores.keys.toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildHeight(context, 0.02),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => QuizPage(),
                              ));
                        },
                        child: Container(
                          width: double.infinity,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xffCC16FB),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text("Take the test",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildHeight(context, 0.02),
                    _buildPieChart(),
                    buildHeight(context, 0.02),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...List.generate(3, (index) {
                          // First row (3 items)
                          return Chip(
                            label: Text(
                              categories[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Inter",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                            backgroundColor:
                                sectionColors[index % sectionColors.length],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }),
                        ...List.generate(3, (index) {
                          // Second row (3 items)
                          return Chip(
                            label: Text(
                              categories[index + 3],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Inter",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                            backgroundColor: sectionColors[
                                (index + 3) % sectionColors.length],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }),
                        ...List.generate(2, (index) {
                          // Last row (2 items)
                          return Chip(
                            label: Text(
                              categories[index + 6],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Inter",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                            backgroundColor: sectionColors[
                                (index + 6) % sectionColors.length],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }),
                      ],
                    ),
                    buildHeight(context, 0.02),
                    Column(
                      children: List.generate(categories.length, (index) {
                        return _buildCategoryContainer(
                          categories[index],
                          categoryScores[categories[index]]!,
                          sectionColors[index % sectionColors.length],
                        );
                      }),
                    ),
                    buildHeight(context, 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: categoryScores.entries.map((entry) {
            int index = categoryScores.keys.toList().indexOf(entry.key);
            return PieChartSectionData(
              color: sectionColors[index % sectionColors.length],
              value: entry.value,
              title: '',
              radius: 50,
            );
          }).toList(),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildCategoryContainer(String title, double value, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Inter",
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          Text(
            '${value.toStringAsFixed(1)}%',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Inter",
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
