import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workmate_01/swimmer_widget/mark_attendance_swimmer.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:workmate_01/utils/constants.dart';
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

  bool visible = true;
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
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: secondaryColor,
              )),
          backgroundColor: darkColor,
          title: const Text(
            'Mark Attendance',
            style: TextStyle(color: secondaryColor),
          ),
        ),
        body: GetBuilder<AttendanceController>(
          init: AttendanceController(),
          builder: (controller) {
            return controller.isLoading.isFalse
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
                              firstDay: DateTime(
                                  DateTime.now().year, DateTime.now().month, 1),
                              lastDay: DateTime(DateTime.now().year,
                                  DateTime.now().month + 1, 0),
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
                              enabledDayPredicate: (DateTime day) {
                                // Disable all past days except leave and absent days
                                if (day.isAfter(DateTime.now()
                                    .subtract(const Duration(days: 1)))) {
                                  return true;
                                }
                                for (DateTime leaveDate
                                    in controller.leaveDates) {
                                  if (_isSameDay(day, leaveDate)) {
                                    return true;
                                  }
                                }
                                for (DateTime absentDate
                                    in controller.absentDates) {
                                  if (_isSameDay(day, absentDate)) {
                                    return true;
                                  }
                                }
                                for (DateTime presentDate
                                    in controller.presentDates) {
                                  if (_isSameDay(day, presentDate)) {
                                    return true;
                                  }
                                }
                                for (DateTime holidayDate
                                    in controller.holidayDates) {
                                  if (_isSameDay(day, holidayDate)) {
                                    return true;
                                  }
                                }
                                return false;
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
                                  if (controller.leaveDates.isNotEmpty) {
                                    for (var i = 0;
                                        i < controller.leaveDates.length;
                                        i++) {
                                      DateTime dateTime = DateTime.parse(
                                          selectedDay.toString());
                                      int curre = dateTime.day;
                                      DateTime leave = DateTime.parse(
                                          controller.leaveDates[i].toString());
                                      int dayOfMonth = leave.day;

                                      if (curre == dayOfMonth) {
                                        constToast(
                                            "You are on leave today, cannot mark attendance.");
                                        return;
                                      }
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TodayVisit(),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TodayVisit(),
                                      ),
                                    );
                                  }
                                }
                              },
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, focusedDay) {
                                  for (DateTime highlightedDate
                                      in controller.leaveDates) {
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
                                  for (DateTime highlightedDate
                                      in controller.presentDates) {
                                    if (_isSameDay(day, highlightedDate)) {
                                      return Container(
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent.shade100,
                                            border: Border.all(
                                                color: Colors.redAccent,
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
                                  for (DateTime highlightedDate
                                      in controller.holidayDates) {
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
                            height: 30,
                          ),
                          const Text(
                            " Attendance Status",
                            style: TextStyle(
                                color: darkColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          PieChart(
                            dataMap: {
                              "Present": controller.attendanceData?.data
                                      .myAttendance[0].present
                                      .toDouble() ??
                                  0.0,
                              "Absent": controller.attendanceData?.data
                                      .myAttendance[0].absent
                                      .toDouble() ??
                                  0.0,
                              "Leave": controller.attendanceData?.data
                                      .myAttendance[0].leave
                                      .toDouble() ??
                                  0.0,
                              "Holiday": controller.attendanceData?.data
                                      .myAttendance[0].holidayCount
                                      .toDouble() ??
                                  0.0,
                            },
                            animationDuration:
                                const Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.6,
                            colorList: colorList,
                            initialAngleInDegree: 0,

                            chartType: ChartType.ring,
                            ringStrokeWidth: 25,
                            centerText: "Attendance\nStatus",
                            legendOptions: const LegendOptions(
                              showLegendsInRow: true,
                              legendPosition: LegendPosition.bottom,
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: false,
                              decimalPlaces: 1,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: true,
                            ),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _buildAttendanceSummary(controller)
                        ],
                      ),
                    ),
                  )
                : const Center(child: CalendarSwimmer());
          },
        ));
  }

  int calculateAbsentDays(int present, int leave, int holiday) {
    DateTime now = DateTime.now();

    int totalDays = now.day;

    int absentDays = totalDays - (present + leave + holiday);

    return absentDays >= 0 ? absentDays : 0;
  }

  Widget _buildAttendanceSummary(AttendanceController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatusContainer(
              'Present', controller.presentDates.length, Colors.green),
          _buildStatusContainer(
              'Absent',
              calculateAbsentDays(controller.presentDates.length,
                  controller.leaveDates.length, controller.holidayDates.length),
              Colors.red),
          _buildStatusContainer(
              'Leave', controller.leaveDates.length, Colors.orange),
          _buildStatusContainer(
              'Holiday', controller.holidayDates.length, Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _buildStatusContainer(String title, int count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(4),
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
            const SizedBox(height: 5),
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
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget DateHeader(String dateString) {
  DateTime date = DateTime.parse(dateString);
  return SizedBox(
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

final colorList = <Color>[
  Colors.green,
  Colors.red,
  Colors.orange, // Add color
  Colors.greenAccent, // Add color
];

Widget _buildLog(text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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

List<Color> generateLightColors() {
  List<Color> lightColors = [];
  // Add all light shades of primary colors
  for (MaterialColor color in Colors.primaries) {
    lightColors.add(color.shade200);
  }

  return lightColors;
}

Widget _buildStatusContainer(String title, String count, Color color) {
  return Container(
    //width: 90,
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
