import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/controller/home_controller.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:workmate_01/view/expanse_management.dart';
import 'package:workmate_01/view/leave_view.dart';
import 'package:workmate_01/view/mark_attendance.dart';
import 'package:workmate_01/view/my_attendance.dart';
import 'package:workmate_01/view/others_view.dart';
import 'package:workmate_01/view/visit_screen.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blueGrey),
              child: const Icon(Icons.person)),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Module Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => controller.isLoading.isFalse?GridView.builder(
              shrinkWrap: true,
              itemCount: controller.menuData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 100),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => routes[index],
                        ));
                  },
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icons[index],
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.menuData[index].name ?? "",                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ):Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
    );
  }

  List routes = [
    const OthersView(),
    const MarkAttendanceView(),
    const MyAttendanceView(),
    const ExpanseManagementView(),
    const LeaveView(),
    const VisitScreen(),
  ];
  List icons = [
    const Icon(Icons.calendar_month_rounded),
    const Icon(Icons.edit_calendar_outlined),
    const Icon(Icons.place),
    const Icon(Icons.data_exploration),
    const Icon(Icons.transfer_within_a_station_rounded),
    const Icon(Icons.help_outline_sharp)
  ];

  // List text = [
  //   "My Attendance",
  //   "Mark Attendance",
  //   "Visit",
  //   "Expense Manegemant",
  //   "Leave",
  //   "Others"
  // ];
}
