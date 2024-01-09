import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/utils/colors.dart';

class MyAttendanceView extends StatefulWidget {
  const MyAttendanceView({Key? key}) : super(key: key);

  @override
  State<MyAttendanceView> createState() => _MyAttendanceViewState();
}

class _MyAttendanceViewState extends State<MyAttendanceView> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  Map<DateTime, List<String>> _events = {};
  List<DateTime> _leaveDates = [
    DateTime(2024, 1, 6),
    DateTime(2024, 1, 8),
  ];
  List<DateTime> _absentDates = [
    DateTime(2024, 1, 19),
  ];
  List<DateTime> _presentDates = [
    DateTime(2024, 1, 14),
    DateTime(2024, 1, 25),
  ];

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                if(kDebugMode){
                  print(_selectedDay);
                }
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  for (DateTime highlightedDate in _leaveDates) {
                    if (_isSameDay(day, highlightedDate)) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent.shade100,
                          border: Border.all(color: Colors.orangeAccent,width: 2),
                          shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                  }
                  for (DateTime highlightedDate in _absentDates) {
                    if (_isSameDay(day, highlightedDate)) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.redAccent.shade100,
                            border: Border.all(color: Colors.redAccent,width: 2),
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                  }
                  for (DateTime highlightedDate in _presentDates) {
                    if (_isSameDay(day, highlightedDate)) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.greenAccent.shade100,
                            border: Border.all(color: Colors.greenAccent,width: 2),
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                  }
                  return null;
                },
              ),
            ),
            Text("Attendance Status",
            style: TextStyle(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildStatusContainer("Present", _presentDates.length, Colors.green),
                  _buildStatusContainer("Absent", _absentDates.length, Colors.red),
                  _buildStatusContainer("Leave", _leaveDates.length, Colors.orange),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year && dayA.month == dayB.month && dayA.day == dayB.day;
  }

  Widget _buildStatusContainer(String title, int count, Color color) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(0.2),
        border: Border(
          top: BorderSide(color: color, width: 5.0),
        ),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
