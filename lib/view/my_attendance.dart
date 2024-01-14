import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:workmate_01/view/today_visit.dart';

import '../controller/attendance_controller.dart';

class MyAttendanceView extends StatefulWidget {
  const MyAttendanceView({Key? key}) : super(key: key);

  @override
  State<MyAttendanceView> createState() => _MyAttendanceViewState();
}

class _MyAttendanceViewState extends State<MyAttendanceView> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  final Map<DateTime, List<String>> _events = {};

  AttendanceController controller = Get.put(AttendanceController());

  final List<DateTime> _leaveDates = [
    DateTime(2024, 1, 6),
    DateTime(2024, 1, 8),
  ];
  final List<DateTime> _absentDates = [
    DateTime(2024, 1, 19),
  ];
  final List<DateTime> _presentDates = [
    DateTime(2024, 1, 14),
    DateTime(2024, 1, 25),
  ];
  List<DateTime> holidays = [
    DateTime.utc(2024, 1, 1), // New Year's Day
    DateTime.utc(2024, 1, 5), // Christmas
    // Add more holiday dates as needed
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
    DateTime currentDate = DateTime.now();
    List<DateTime> logDates =
        List.generate(7, (index) => currentDate.add(Duration(days: index)));
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: secondaryColor,
              )),
          backgroundColor: darkColor,
          title: const Text(
            'My Attendance',
            style: TextStyle(color: secondaryColor),
          ),
        ),
        body: Obx(() => controller.isLoading.isFalse
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: TableCalendar(
                          firstDay: DateTime.utc(2024, 1, 1),
                          lastDay: DateTime.utc(2024, 1, 31),
                          focusedDay: _focusedDay,
                          calendarFormat: _calendarFormat,
                          calendarStyle: const CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                          ),

                          // Enable current day and holidays, disable all other days
                          enabledDayPredicate: (DateTime day) {
                            return _isSameDay(day, DateTime.now()) ||
                                holidays.contains(day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                            if (kDebugMode) {
                              print(_selectedDay);
                            }
                            if (_isSameDay(selectedDay, DateTime.now())) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TodayVisit(),
                                ),
                              );
                            }
                          },
                          calendarBuilders: CalendarBuilders(
                            defaultBuilder: (context, day, focusedDay) {
                              for (DateTime highlightedDate in _leaveDates) {
                                if (_isSameDay(day, highlightedDate)) {
                                  return Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.orangeAccent.shade100,
                                        border: Border.all(
                                            color: Colors.orangeAccent,
                                            width: 2),
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        '${day.day}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                }
                              }
                              for (DateTime highlightedDate in _absentDates) {
                                if (_isSameDay(day, highlightedDate)) {
                                  return Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent.shade100,
                                        border: Border.all(
                                            color: Colors.redAccent, width: 2),
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        '${day.day}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                }
                              }
                              for (DateTime highlightedDate in _presentDates) {
                                if (_isSameDay(day, highlightedDate)) {
                                  return Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent.shade100,
                                        border: Border.all(
                                            color: Colors.greenAccent,
                                            width: 2),
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        '${day.day}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        surfaceTintColor: Colors.white,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Attendance Status",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 110,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //scrollDirection: Axis.horizontal,
                                children: [
                                  _buildStatusContainer(
                                      "Present",
                                      controller.attendanceData[0].present
                                          .toString(),
                                      Colors.green),
                                  _buildStatusContainer(
                                      "Absent",
                                      controller.attendanceData[0].absent
                                          .toString(),
                                      Colors.red),
                                  _buildStatusContainer(
                                      "Leave",
                                      controller.attendanceData[0].leave
                                          .toString(),
                                      Colors.orange),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        surfaceTintColor: Colors.white,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "7 Days log",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildLog(" Days"),
                                _buildLog("Check-in"),
                                _buildLog("Check-out"),
                                _buildLog("status  ")
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: getColorByIndex(index),
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  12)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            DateHeader(logDates[index]),
                                            _buildLog1("11:38 AM"),
                                            _buildLog1("01:38 PM"),
                                            _buildLog1("Check-in"),
                                          ]),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 3,
                                    ),
                                itemCount: 7)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator())));
  }

  Widget DateHeader(DateTime date) {
    return Container(
      width: 60,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("${date.day}"),
              Text(_getDayName(date)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLog(text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildLog1(text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  String _getDayName(DateTime date) {
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  bool _isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  Color getColorByIndex(int index) {
    // Replace this logic with your own color assignment
    Color baseColor = Colors.red; // Change this to your base color

    // Calculate the percentage based on the index (adjust the factor as needed)
    double percentage = (index + 1) * 10.0; // For example, 10% increments

    // Create a color with the adjusted opacity
    Color adjustedColor = baseColor.withOpacity(percentage / 100.0);

    return adjustedColor;
  }

  Widget _buildStatusContainer(String title, String count, Color color) {
    return Container(
      width: 100,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(2),
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
