import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSwimmer extends StatefulWidget {
  @override
  _CalendarSwimmerState createState() => _CalendarSwimmerState();
}

class _CalendarSwimmerState extends State<CalendarSwimmer> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildCalendarPage());
  }

  Widget _buildCalendarPage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: TableCalendar(
        calendarBuilders: CalendarBuilders(),
        firstDay: DateTime(DateTime.now().year, DateTime.now().month, 1),
        lastDay: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
        focusedDay: _focusedDay,

        calendarFormat: CalendarFormat.month,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          // Do something with the selected day
        },
        // Add additional calendar customization as needed
      ),
    );
  }
}
