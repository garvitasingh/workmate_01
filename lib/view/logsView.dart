import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/utils/constants.dart';
import 'package:workmate_01/view/today_visit.dart';

import '../controller/attendance_controller.dart';
import '../swimmer_widget/logs_swimmer.dart';
import '../utils/colors.dart';

class LogsView extends StatefulWidget {
  const LogsView({super.key});

  @override
  State<LogsView> createState() => _LogsViewState();
}

class _LogsViewState extends State<LogsView> {
  final controller = Get.put(AttendanceController());
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
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
            "Logs",
            style: TextStyle(color: secondaryColor),
          ),
        ),
        body: Obx(
          () {
            String formattedDate = DateFormat('dd MMM').format(currentDate);
            return controller.isLoading.isTrue
                ? const Center(child: SwimmerForLogs())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.green.shade400,
                                    Colors.green.shade700
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Today Logs : ($formattedDate)',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const Icon(Icons.calendar_today,
                                          color: Colors.white, size: 24),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const Icon(Icons.login,
                                          color: Colors.white, size: 20),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Check-in:  ${convertTimestampToTime(controller.todayInTime)}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.logout,
                                          color: Colors.white, size: 20),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Check-out:  ${convertTimestampToTime(controller.todayoutTime)}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (controller.todayoutTime == '') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const TodayVisit(),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.green.shade700,
                                        backgroundColor:
                                            Colors.white, // Text color
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Text(controller.todayInTime == ''
                                          ? 'Check In'
                                          : controller.todayoutTime == ''
                                              ? 'Check Out'
                                              : 'Done'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: primaryColor,
                            ),
                            Container(
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  _buildLog("Date"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  _buildLog("Check-In"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  _buildLog("Check-Out"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  _buildLog("Status "),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                            !controller.checkLog.value
                                ? const SizedBox()
                                : SizedBox(
                                    height: Get.height * 0.55,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          List<Color> colors =
                                              generateLightColors();
                                          final data = controller
                                              .attendanceLogModel!
                                              .data!
                                              .attendancelog![index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: colors[index],
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(12)),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    data.presentTimeIn == null
                                                        ? const SizedBox(
                                                            width: 60,
                                                            child: Card(
                                                              color:
                                                                  Colors.white,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Column(
                                                                  children: [
                                                                    Text("-:-")
                                                                  ],
                                                                ),
                                                              ),
                                                            ))
                                                        : DateHeader(controller
                                                            .attendanceLogModel!
                                                            .data!
                                                            .attendancelog![
                                                                index]
                                                            .presentTimeIn
                                                            .toString()),
                                                    data.presentTimeIn == null
                                                        ? const SizedBox(
                                                            width: 60,
                                                            child: Center(
                                                                child: Text(
                                                                    "-:-")))
                                                        : _buildLog1(convertTimestampToTime(
                                                            controller
                                                                .attendanceLogModel!
                                                                .data!
                                                                .attendancelog![
                                                                    index]
                                                                .presentTimeIn
                                                                .toString())),
                                                    data.presentTimeOut == null
                                                        ? const SizedBox(
                                                            width: 60,
                                                            child: Center(
                                                                child: Text(
                                                                    "-:-")))
                                                        : _buildLog1(convertTimestampToTime(
                                                            controller
                                                                .attendanceLogModel!
                                                                .data!
                                                                .attendancelog![
                                                                    index]
                                                                .presentTimeOut
                                                                .toString())),
                                                    _buildLog1(controller
                                                                .attendanceLogModel!
                                                                .data!
                                                                .attendancelog![
                                                                    index]
                                                                .checkOut ==
                                                            1
                                                        ? "Check-Out"
                                                        : "Check-In"),
                                                  ]),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              height: 3,
                                            ),
                                        itemCount: controller.attendanceLogModel
                                                ?.dataCount ??
                                            0),
                                  )
                          ],
                        ),
                      )
                    ],
                  );
          },
        ));
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
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
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

  List<Color> generateLightColors() {
    List<Color> lightColors = [];
    // Add all light shades of primary colors
    for (MaterialColor color in Colors.primaries) {
      lightColors.add(color.shade200);
    }

    return lightColors;
  }

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

  String _getDayName(DateTime date) {
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}
