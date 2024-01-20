import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmate_01/controller/home_controller.dart';
import 'package:workmate_01/utils/colors.dart';
import 'package:workmate_01/utils/local_data.dart';
import 'package:workmate_01/view/about_app.dart';
import 'package:workmate_01/view/expanse_management.dart';
import 'package:workmate_01/view/leave_view.dart';
import 'package:workmate_01/view/login_view.dart';
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
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => controller.onWillPop(context),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            child: Obx(() => controller.isLoading.isFalse
                ? ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        currentAccountPicture: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1485290334039-a3c69043e517?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTYyOTU3NDE0MQ&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300'),
                        ),
                        accountEmail: Text(
                          controller.userData!.data.mobileNo.toString(),
                          style: const TextStyle(color: secondaryColor),
                        ),
                        accountName: Text(
                          controller.userData!.data.name.toString(),
                          style: const TextStyle(
                              fontSize: 24.0, color: secondaryColor),
                        ),
                        decoration: const BoxDecoration(
                          color: darkColor,
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/emp_id.png",
                          height: 40,
                        ),
                        title: Text(
                          controller.userData!.data.empCode.toString(),
                          style: const TextStyle(
                              fontSize: 24.0, color: Colors.green),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/visits.png",
                          height: 40,
                        ),
                        title: const Text(
                          'Visits',
                          style: TextStyle(fontSize: 24.0, color: darkColor),
                        ),
                        onTap: () {
                          Get.to(const VisitScreen());
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/about_app.png",
                          height: 40,
                        ),
                        title: const Text(
                          'About App',
                          style: TextStyle(fontSize: 24.0, color: darkColor),
                        ),
                        onTap: () {
                          Get.to(const AboutAppPage());
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/log_out.png",
                          height: 40,
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(fontSize: 24.0, color: darkColor),
                        ),
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.rightSlide,
                            title: 'Logout Confirmation',
                            desc: 'Are you sure you want to logout?',
                            btnCancelOnPress: () {
                              Get.back();
                            },
                            btnOkOnPress: () async {
                              await GetStorage().erase();
                              Get.offAll(const LoginViewPage());
                            },
                          ).show();
                        },
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator()))),
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                    Icons.menu), // Replace 'Icons.menu' with your desired icon
                color:
                    secondaryColor, // Change this color to your desired color
                onPressed: () {
                  controller.menuData.isEmpty
                      ? ''
                      : _scaffoldKey.currentState!.openDrawer();
                },
              );
            },
          ),
          backgroundColor: darkColor,
          title: const Text(
            "Home",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: secondaryColor),
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
              Obx(() => controller.isLoading.isFalse
                  ? Text(
                      controller.aboutapp!.data.claimDetails[0].productName,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: darkColor),
                    )
                  : const Text("")),
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
                                  child: Image.network(
                                      controller.imgList[index],
                                      fit: BoxFit.cover,
                                      width: 500),
                                )),
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        controller.menuData.isEmpty
                            ? Text("")
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount: controller.menuData.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 1,
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
                                      color: getColorByIndex(index),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/${iconss[index]}.png",
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              controller.menuData[index].name ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: darkColor,
                                                  fontSize: 15,
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
      ),
    );
  }

  Color getColorByIndex(int index) {
    // Replace this logic with your own color assignment
    Color baseColor = Colors.redAccent; // Change this to your base color

    // Calculate the percentage based on the index (adjust the factor as needed)
    double percentage = (index + 1) * 10.0; // For example, 10% increments

    // Create a color with the adjusted opacity
    Color adjustedColor = baseColor.withOpacity(percentage / 100.0);

    return adjustedColor;
  }

  List routes = [
    const MarkAttendanceView(),
    const MyAttendanceView(),
    const VisitScreen(),
    const ExpanseManagementView(),
    const LeaveView(),
    const OthersView(),
  ];
  List iconss = [
    "my_att",
    "mark_atten",
    "visits",
    "expense_m",
    "leave",
    "others"
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
