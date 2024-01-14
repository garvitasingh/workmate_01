import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:workmate_01/controller/home_controller.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:workmate_01/utils/local_data.dart';
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
  final User = LocalData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1485290334039-a3c69043e517?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTYyOTU3NDE0MQ&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300'),
              ),
              accountEmail: Text(
                User.getMobileNo().toString(),
                style: const TextStyle(color: secondaryColor),
              ),
              accountName: Text(
                User.getname().toString(),
                style: const TextStyle(fontSize: 24.0, color: secondaryColor),
              ),
              decoration: const BoxDecoration(
                color: darkColor,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.perm_identity_rounded),
              title: Text(
                User.getEmpCode().toString(),
                style: const TextStyle(fontSize: 24.0, color: Colors.green),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.apartment),
              title: const Text(
                'Visits',
                style: TextStyle(fontSize: 24.0),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: const Text(
                'About App',
                style: TextStyle(fontSize: 24.0),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 24.0),
              ),
              onTap: () {},
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
        backgroundColor: darkColor,
        title: const Text(
          "Home",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: secondaryColor),
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sales Narrotr",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => controller.isLoading.isFalse
                ? Column(
                    children: [
                      CarouselSlider.builder(
                          itemCount: controller.imgList.length,
                          options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: false,
                              height: 150),
                          itemBuilder: (context, index, realIdx) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(controller.imgList[index],
                                    fit: BoxFit.cover, width: 500),
                              )),
                            );
                          }),
                          SizedBox(height: 20,),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.menuData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 120),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator()))
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
    const Icon(
      Icons.calendar_month_rounded,
      color: darkColor,
      size: 30,
    ),
    const Icon(
      Icons.edit_calendar_outlined,
      color: darkColor,
      size: 30,
    ),
    const Icon(
      Icons.place,
      color: darkColor,
      size: 30,
    ),
    const Icon(
      Icons.data_exploration,
      color: darkColor,
      size: 30,
    ),
    const Icon(
      Icons.transfer_within_a_station_rounded,
      color: darkColor,
      size: 30,
    ),
    const Icon(
      Icons.help_outline_sharp,
      color: darkColor,
      size: 30,
    )
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
