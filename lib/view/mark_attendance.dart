import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workmate_01/swimmer_widget/my_attendance_swimmer.dart';
import 'package:workmate_01/utils/colors.dart';

import '../controller/attendance_controller.dart';

class MarkAttendanceView extends StatefulWidget {
  const MarkAttendanceView({super.key});

  @override
  State<MarkAttendanceView> createState() => _MarkAttendanceViewState();
}

class _MarkAttendanceViewState extends State<MarkAttendanceView> {
  AttendanceController controller = Get.put(AttendanceController());
  DateTime currentDate = DateTime.now();

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
        body: GetBuilder<AttendanceController>(
          builder: (controller) {
            return controller.isLoading.isTrue
                ? Center(child: MyAttendanceSwimmer())
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attendance Status (${formattedDate})",
                            style: TextStyle(
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
                                    controller.attendanceData!.data
                                        .claimDetails[0].present,
                                    "present",
                                    getColorByIndex(0)),
                                _iconCard(
                                    "Absent",
                                    controller.attendanceData!.data
                                        .claimDetails[0].absent,
                                    "absent",
                                    getColorByIndex(1)),
                                _iconCard(
                                    "Leaves",
                                    controller.attendanceData!.data
                                        .claimDetails[0].leave,
                                    "leave",
                                    getColorByIndex(2)),
                                _iconCard(
                                    "Working Days",
                                    controller.attendanceData!.data
                                        .claimDetails[0].workingDays,
                                    "my_att",
                                    getColorByIndex(3)),
                                _iconCard(
                                    "Holidays",
                                    controller.attendanceData!.data
                                        .claimDetails[0].holiday,
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
        //
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
