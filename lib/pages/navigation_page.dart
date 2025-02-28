import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:the_daily_wheel_of_growth/models/quiz_manager.dart';
import 'package:the_daily_wheel_of_growth/models/quiz.list.dart';
import 'package:the_daily_wheel_of_growth/pages/quiz_page_origin.dart';
import 'package:the_daily_wheel_of_growth/pages/quiz_result_page.dart';
import 'package:the_daily_wheel_of_growth/pages/decisions_page.dart';
import 'package:the_daily_wheel_of_growth/pages/home_page.dart';
import 'package:the_daily_wheel_of_growth/pages/setting_page.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';
import 'package:the_daily_wheel_of_growth/models/app_provider.dart'; // Import AppProvider

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selected = 0;
  final Color _selectedColor = kGreenLIght;

  final List<String> _tabIcons = [
    "images/Layer_1.png",
    "images/Frame (6).png",
    "images/Frame (7).png",
    "images/Livello_1.png",
  ];

  @override
  Widget build(BuildContext context) {
    // Access category scores from the AppProvider
    final appProvider = Provider.of<AppProvider>(context);
    final categoryScores = appProvider.calculateCategoryScores(
        QuizData()); // Pass the appropriate QuizData instance

    // The pages list dynamically passes categoryScores to the QuizResultPage
    final List<Widget> _pages = [
      HomePage(),
      QuizResultPageOrigin(
          categoryScores: categoryScores), // Pass categoryScores here
      DecisionsPage(),
      SettingPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _pages[_selected],
      bottomNavigationBar: ClipRRect(
        child: CupertinoTabBar(
          backgroundColor: kkPurpleDark,
          height: MediaQuery.of(context).size.height * 0.08,
          currentIndex: _selected,
          onTap: (index) {
            setState(() {
              _selected = index;
            });
          },
          items: List.generate(
            _tabIcons.length,
            (index) {
              return BottomNavigationBarItem(
                icon: _buildTabIcon(index),
                label: '',
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabIcon(int index) {
    // Check if this icon is selected, if so, apply the red color filter
    return ColorFiltered(
      colorFilter: _selected == index
          ? ColorFilter.mode(
              _selectedColor, BlendMode.srcIn) // Red color on select
          : const ColorFilter.mode(
              Colors.grey, BlendMode.srcIn), // Grey color for unselected
      child: Image.asset(
        _tabIcons[index],
      ),
    );
  }
}
