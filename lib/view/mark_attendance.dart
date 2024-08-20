// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workmate_01/controller/my_attendance_controller.dart';
import 'package:workmate_01/swimmer_widget/my_attendance_swimmer.dart';
import 'package:workmate_01/utils/colors.dart';

import '../controller/attendance_controller.dart';

class MarkAttendanceView extends StatefulWidget {
  const MarkAttendanceView({super.key});

  @override
  State<MarkAttendanceView> createState() => _MarkAttendanceViewState();
}

class _MarkAttendanceViewState extends State<MarkAttendanceView> {
  //AttendanceController controller = Get.put(AttendanceController());
  DateTime currentDate = DateTime.now();
  List<DateTime> holidays = [];

  @override
  void initState() {
    super.initState();
    List<DateTime> sundaysInApril2024 = getSundaysInMonth(2024, 4);

    // Add all Sundays to the holidays list
    holidays.addAll(sundaysInApril2024);
  }

  List<DateTime> getSundaysInMonth(int year, int month) {
    List<DateTime> sundays = [];
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    for (DateTime date = firstDayOfMonth;
        date.isBefore(lastDayOfMonth);
        date = date.add(const Duration(days: 1))) {
      if (date.weekday == DateTime.sunday) {
        sundays.add(DateTime.utc(date.year, date.month, date.day));
      }
    }

    return sundays;
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AttendanceController());
    String formattedDate = DateFormat('dd MMM').format(currentDate);
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: secondaryColor,
              )),
          centerTitle: false,
          backgroundColor: darkColor,
          title: const Text(
            "My Attendance",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: secondaryColor),
          ),
        ),
        body: GetBuilder<MyAttendanceController>(
          init: MyAttendanceController(),
          builder: (controller) {
            return controller.isLoading.isTrue
                ? const Center(child: MyAttendanceSwimmer())
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attendance Status ($formattedDate)",
                            style: const TextStyle(
                                color: darkColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: GridView(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 150),
                              children: [
                                _iconCard(
                                    "Present",
                                    controller.attendanceData?.data
                                        .myAttendance[0].present,
                                    "present",
                                    getColorByIndex(0)),
                                _iconCard(
                                    "Absent",
                                    controller.attendanceData?.data
                                        .myAttendance[0].absent,
                                    "absent",
                                    getColorByIndex(1)),
                                _iconCard(
                                    "Leaves",
                                    controller.attendanceData?.data
                                        .myAttendance[0].leave,
                                    "leave",
                                    getColorByIndex(2)),
                                _iconCard(
                                    "Working Days",
                                    controller.attendanceData?.data
                                        .myAttendance[0].workingDays,
                                    "my_att",
                                    getColorByIndex(3)),
                                _iconCard(
                                    "Holidays",
                                    controller.attendanceData?.data
                                        .myAttendance[0].holidayCount,
                                    "leave",
                                    getColorByIndex(3)),
                              ],
                            ),
                          ),
                        ]),
                  );
          },
        ));
  }

  Widget _iconCard(String title, int? count, icon, color) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CalendarDialog(
              holidays: holidays,
            );
          },
        );
      },
      child: Card(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/$icon.png",
              height: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "#$count",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: darkColor, fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorByIndex(int index) {
    // Replace this logic with your own color assignment
    Color baseColor = Colors.yellowAccent; // Change this to your base color

    // Calculate the percentage based on the index (adjust the factor as needed)
    double percentage = (index + 1) * 10.0; // For example, 10% increments

    // Create a color with the adjusted opacity
    Color adjustedColor = baseColor.withOpacity(percentage / 100.0);

    return adjustedColor;
  }

  List text = [
    "Present",
    "Absent",
    "Leave",
    "Working Days",
  ];
}

class CalendarDialog extends StatefulWidget {
  List holidays = [];

  CalendarDialog({super.key, required this.holidays});
  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: TableCalendar(
                firstDay:
                    DateTime(DateTime.now().year, DateTime.now().month, 1),
                lastDay:
                    DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
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
                onDaySelected: (selectedDay, focusedDay) {},
                enabledDayPredicate: (DateTime day) {
                  // Disable all past days except leave and absent days
                  if (day.isAfter(
                      DateTime.now().subtract(const Duration(days: 1)))) {
                    return true;
                  }
                  for (DateTime leaveDate in widget.holidays) {
                    if (_isSameDay(day, leaveDate)) {
                      return true;
                    }
                  }
                  return false;
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    for (DateTime highlightedDate in widget.holidays) {
                      if (_isSameDay(day, highlightedDate)) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(color: Colors.red, width: 2),
                              shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.black),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }
}
