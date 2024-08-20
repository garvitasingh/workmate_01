// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSwimmer extends StatefulWidget {
  const CalendarSwimmer({super.key});

  @override
  _CalendarSwimmerState createState() => _CalendarSwimmerState();
}

class _CalendarSwimmerState extends State<CalendarSwimmer> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
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
        calendarBuilders: const CalendarBuilders(),
        firstDay: DateTime(DateTime.now().year, DateTime.now().month, 1),
        lastDay: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
        focusedDay: _focusedDay,

        calendarFormat: CalendarFormat.month,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
          // Do something with the selected day
        },
        // Add additional calendar customization as needed
      ),
    );
  }
}
