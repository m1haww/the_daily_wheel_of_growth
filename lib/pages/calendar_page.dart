import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/pages/aa_clanedar_wrinting.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class CalendarPage extends StatefulWidget {
  final DateTime selectedDay;
  const CalendarPage({super.key, required this.selectedDay});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDay;
  Map<DateTime, String> _notes = {}; // Optional: to store notes per day

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay;
  }

  void _addNote() async {
    final note = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => AaClanedarWrinting(selectedDay: _selectedDay),
      ),
    );
    if (note != null) {
      setState(() {
        _notes[_selectedDay] = note;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBlackDark,
      appBar: AppBar(
          backgroundColor: kkPurpleDark,
          automaticallyImplyLeading: false,
          title: const Text("Today",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          actions: [
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
            ),
          ]),
      body: Column(
        children: [
          Container(
            color: kkPurpleDark,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color(0xffCC16FB),
                  ),
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        child: TableCalendar(
                          focusedDay: _selectedDay,
                          firstDay: DateTime.utc(2000, 1, 1),
                          lastDay: DateTime.utc(2100, 12, 31),
                          calendarFormat: CalendarFormat.month,
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                            });
                          },
                          calendarStyle: CalendarStyle(
                            todayTextStyle: TextStyle(
                              fontSize: 20, // Adjust size
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                            ),
                            todayDecoration: const BoxDecoration(
                              color: Colors.purpleAccent,
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: kkPurpleDark,
                              shape: BoxShape.circle,
                            ),
                            selectedTextStyle: const TextStyle(
                              fontSize: 20, // Adjust size
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                            ),
                            defaultTextStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                            ),
                            weekendTextStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                            ),
                            outsideTextStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              fontSize: 13,
                              color: Color(0xff3C3C434D),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                            weekendStyle: TextStyle(
                              fontSize: 13,
                              color: Color(0xff3C3C434D),
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          headerStyle: const HeaderStyle(
                              formatButtonVisible:
                                  false, // Remove "2 weeks" button
                              titleCentered:
                                  false, // Ensures title is NOT centered
                              leftChevronVisible:
                                  false, // Hide default left arrow
                              rightChevronVisible:
                                  false, // Hide default right arrow
                              titleTextStyle:
                                  TextStyle(color: Colors.transparent)),
                        ),
                      ),

                      // Month name in the top-left corner
                      Positioned(
                        top: 8, // Adjust vertical positioning
                        left: 16, // Align to left
                        child: Text(
                          DateFormat.yMMMM()
                              .format(_selectedDay), // Format month text
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),

                      // Arrows in the top-right corner
                      Positioned(
                        top: 8, // Adjust vertical positioning
                        right: 8, // Align to right
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left,
                                  color: Color(0xffFBBBFA)),
                              onPressed: () {
                                setState(() {
                                  _selectedDay = DateTime(_selectedDay.year,
                                      _selectedDay.month - 1, _selectedDay.day);
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right,
                                  color: Color(0xffFBBBFA)),
                              onPressed: () {
                                setState(() {
                                  _selectedDay = DateTime(_selectedDay.year,
                                      _selectedDay.month + 1, _selectedDay.day);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Container(
            width: double.infinity,
            height: height * 0.001,
            decoration: BoxDecoration(
                color: kkPurpleDark,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
          ),
          buildHeight(context, 0.02),
          GestureDetector(
            onTap: () => _addNote(),
            child: Container(
                width: width * 0.15,
                height: height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kkPurpleDark,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    size: 24,
                    color: Colors.white,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
