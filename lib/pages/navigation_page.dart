import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_daily_wheel_of_growth/pages/decisions_page.dart';
import 'package:the_daily_wheel_of_growth/pages/home_page.dart';
import 'package:the_daily_wheel_of_growth/pages/quiz_page.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selected = 0;
  final List<Widget> _pages = [
    HomePage(),
    QuizPage(),
    DecisionsPage(),
    HomePage(),
  ];
  final List<String> _tabIcons = [
    "images/Layer_1.png",
    "images/Frame (6).png",
    "images/Frame (7).png",
    "images/Livello_1.png",
  ];
  final Color _selectedColor = kGreenLIght;

  void _onItemTapped(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _pages[_selected],
      bottomNavigationBar: ClipRRect(
        child: CupertinoTabBar(
          backgroundColor: kkPurpleDark,
          height: height * 0.1,
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
