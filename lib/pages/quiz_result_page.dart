import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, double> categoryScores;

  ResultScreen({required this.categoryScores}) {
    // Debugging: Print category scores to verify data
    print("Category Scores Received in ResultScreen:");
    categoryScores.forEach((category, score) {
      print("$category: ${score.toStringAsFixed(1)}%");
    });
  }

  final List<Color> sectionColors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.lightBlue,
    Colors.deepOrange,
    Colors.orange
  ];

  @override
  Widget build(BuildContext context) {
    List<String> categories = categoryScores.keys.toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                _buildPieChart(),
                SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(categories.length, (index) {
                    return Chip(
                      label: Text(
                        categories[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor:
                          sectionColors[index % sectionColors.length],
                    );
                  }),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return _buildProgressBar(
                          categories[index],
                          categoryScores[categories[index]]!,
                          sectionColors[index % sectionColors.length]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text("Got it!",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    List<MapEntry<String, double>> sortedEntries = categoryScores.entries
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: sortedEntries.map((entry) {
                int index = sortedEntries.indexOf(entry);
                return PieChartSectionData(
                  color: sectionColors[index % sectionColors.length],
                  value: entry.value,
                  title: '${entry.value.toStringAsFixed(1)}%',
                  radius: 50,
                  titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                );
              }).toList(),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        SizedBox(height: 20),
        _buildPercentageText(sortedEntries),
      ],
    );
  }

  Widget _buildPercentageText(List<MapEntry<String, double>> sortedEntries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: sortedEntries.map((entry) {
        return Text(
          '${entry.key}: ${entry.value.toStringAsFixed(1)}%',
          style: TextStyle(color: Colors.white, fontSize: 16),
        );
      }).toList(),
    );
  }

  Widget _buildProgressBar(String title, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey.shade800,
              color: color,
              minHeight: 15,
            ),
          ),
        ],
      ),
    );
  }
}
