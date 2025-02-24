import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:the_daily_wheel_of_growth/models/app_provider.dart';
import 'package:the_daily_wheel_of_growth/models/classes.dart';
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

  Widget _buildEventCard(Home home) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // If the event is user-created and has an image file, load from file; otherwise use asset.
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: home.isown && home.fileImage != null
                ? Image.file(
                    home.fileImage!,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 150,
                        child: Center(
                          child: Icon(Icons.image_not_supported,
                              size: 50, color: Colors.grey),
                        ),
                      );
                    },
                  )
                : Image.asset(
                    home.image,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 150,
                        child: Center(
                          child: Icon(Icons.broken_image,
                              size: 50, color: Colors.grey),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  home.title,
                  style: const TextStyle(
                      fontFamily: "Sf",
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black),
                ),
                Text(
                  home.description,
                  style: TextStyle(
                    fontFamily: "Sf",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventGrid() {
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
            return _buildEventCard(event);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
                  child: Container(
                    width: double.infinity,
                    height: height * 0.10,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              width: 65,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.purpleAccent
                                    : Colors.white24,
                                borderRadius: BorderRadius.circular(10),
                              ),
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
              // Event Grid Displaying Journal Entries for the selected date
              _buildEventGrid(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCalendarPage(context),
        child: const Icon(Icons.add),
        backgroundColor: kkPurpleDark,
      ),
    );
  }
}
