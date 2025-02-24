import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
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
    return Scaffold(
      appBar:
          AppBar(title: const Text("Calendar"), backgroundColor: kkPurpleDark),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
