import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/utils/colors.dart';

import '../controller/attendance_controller.dart';

class MarkAttendanceView extends StatefulWidget {
  const MarkAttendanceView({super.key});

  @override
  State<MarkAttendanceView> createState() => _MarkAttendanceViewState();
}

class _MarkAttendanceViewState extends State<MarkAttendanceView> {
  AttendanceController controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: secondaryColor,
            )),
        centerTitle: false,
        backgroundColor: darkColor,
        title: const Text(
          "My Attendance",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: secondaryColor),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_rounded,
                color: secondaryColor,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Attendance Status",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() => controller.isLoading.isFalse
              ? Expanded(
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
                          controller
                              .attendanceData!.data.claimDetails[0].present),
                      _iconCard(
                          "Absent",
                          controller
                              .attendanceData!.data.claimDetails[0].absent),
                      _iconCard(
                          "Leave",
                          controller
                              .attendanceData!.data.claimDetails[0].leave),
                      _iconCard(
                          "WorkingDay",
                          controller.attendanceData!.data.claimDetails[0]
                              .workingDays),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator()))
        ]),
      ),
    );
  }

  Widget _iconCard(String title, int? count) {
    return InkWell(
      onTap: () {
        //
      },
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_month_rounded,
              size: 40,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              count.toString() ?? "0",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  List text = [
    "Present",
    "Absent",
    "Leave",
    "Working Days",
  ];
}
