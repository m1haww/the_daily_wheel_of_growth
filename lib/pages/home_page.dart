import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:the_daily_wheel_of_growth/models/app_provider.dart';
import 'package:the_daily_wheel_of_growth/models/classes.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/pages/calendar_page.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime today = DateTime.now();
  late int selectedIndex;
  late final List<Map<String, String>> allDates;

  @override
  void initState() {
    super.initState();
    _generateDatesUntil2099();
    selectedIndex = allDates.indexWhere(
        (element) => element["date"] == DateFormat('yyyy-MM-dd').format(today));
  }

  void _generateDatesUntil2099() {
    DateTime startDate =
        today.subtract(Duration(days: today.weekday - 1)); // start from Monday
    DateTime endDate = DateTime(2099, 12, 31);
    allDates = [];
    while (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
      allDates.add({
        "date": DateFormat('yyyy-MM-dd').format(startDate),
        "day": DateFormat('EEE').format(startDate),
        "dayNum": DateFormat('d').format(startDate),
      });
      startDate = startDate.add(const Duration(days: 1));
    }
  }

  void _openCalendarPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(
          selectedDay:
              DateFormat('yyyy-MM-dd').parse(allDates[selectedIndex]["date"]!),
        ),
      ),
    );
  }

  Widget _buildHomeCard(Home home) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: home.isown && home.fileImage != null
                ? Image.file(
                    home.fileImage!,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 120,
                        child: Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        ),
                      );
                    },
                  )
                : Image.asset(
                    home.image,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 120,
                        child: Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      );
                    },
                  ),
          ),
          buildHeight(context, 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                home.title,
                style: const TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white),
              ),
              buildHeight(context, 0.02),
              Text(
                home.description,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              buildHeight(context, 0.02),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHomeGrid() {
    // Parse the selected date from the horizontal list.
    final selectedDate =
        DateFormat('yyyy-MM-dd').parse(allDates[selectedIndex]["date"]!);
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        // Filter events to only those that match the selected date.
        final filteredEvents = provider.home
            .where((event) => isSameDay(event.date, selectedDate))
            .toList();

        if (filteredEvents.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "You didn't add any notes.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredEvents.length,
          itemBuilder: (context, index) {
            final event = filteredEvents[index];
            return _buildHomeCard(event);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final borderSide = BorderSide(color: Colors.white, width: 2);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kkPurpleDark,
        automaticallyImplyLeading: false,
        title: const Text("Today",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: kBlackDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Horizontal Date Selector
              Container(
                color: kkPurpleDark,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    // Impunem o înălțime fixă
                    width: double.infinity,
                    height: 100, // Modifică această valoare cum dorești
                    child: Container(
                      decoration: BoxDecoration(
                        color: kkPurpleDark,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allDates.length,
                        controller: ScrollController(
                            initialScrollOffset: selectedIndex * 65.0),
                        itemBuilder: (context, index) {
                          bool isSelected = index == selectedIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Container(
                                width: width * 0.2,
                                decoration: BoxDecoration(
                                    color: isSelected
                                        ? Color(0xffCC16FB)
                                        : kkPurpleDark,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border(
                                        top: borderSide, bottom: borderSide)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      allDates[index]["dayNum"]!,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      allDates[index]["day"]!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                height: height * 0.03,
                color: kkPurpleDark,
              ),
              buildHeight(context, 0.02),

              _buildHomeGrid(),

              buildHeight(context, 0.02),
              GestureDetector(
                onTap: () => _openCalendarPage(context),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
