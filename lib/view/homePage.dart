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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final User user = User(
    name: "Ronny Rana",
    mobile: "7052452066",
    imageUrl: "https://example.com/avatar.jpg", // replace with actual image URL
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/applogo.png",
              color: Colors.blue,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    user.mobile,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_4,
                size: 30,
                color: Colors.black,
              ),
              title: const Text(
                'About App',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const AboutUsView(),
                //     ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30,
                color: Colors.black,
              ),
              title: const Text(
                'Exit',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // _onWillPop();
                // Handle exit item click
              },
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: false,
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //       decoration: const BoxDecoration(
        //           shape: BoxShape.circle, color: Colors.blueGrey),
        //       child: const Icon(Icons.person)),
        // ),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blueGrey),
                child: IconButton(
                  icon: const Icon(Icons
                      .person), // Replace 'Icons.menu' with your desired icon
                  color:
                      Colors.black, // Change this color to your desired color
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ),
            );
          },
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
            Obx(() => controller.isLoading.isFalse
                ? GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.menuData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                controller.menuData[index].name ?? "",
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
                    },
                  )
                : Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
    );
  }

  List routes = [
    const MarkAttendanceView(),
    const MyAttendanceView(),
    const VisitScreen(),
    const ExpanseManagementView(),
    const LeaveView(),
    const OthersView(),
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

class User {
  final String name;
  final String mobile;
  final String imageUrl;

  User({required this.name, required this.mobile, required this.imageUrl});
}
