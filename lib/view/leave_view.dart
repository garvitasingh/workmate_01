import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/controller/leave_controller.dart';
import 'package:workmate_01/utils/colors.dart';

class LeaveView extends StatefulWidget {
  const LeaveView({super.key});

  @override
  State<LeaveView> createState() => _LeaveViewState();
}

class _LeaveViewState extends State<LeaveView> {
  LeaveController controller = Get.put(LeaveController());
  
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Leave",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Leave Count Details",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() => controller.isLoading.isFalse?GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 130),
            children: [
              _leaveCard("Total Leave", controller.leaveData[0].leaves),
              _leaveCard("SL", controller.leaveData[0].sL),
              _leaveCard("PL", controller.leaveData[0].pL),
              _leaveCard("CL", controller.leaveData[0].cL),
              _leaveCard("Approve Leave", controller.leaveData[0].approved),
              _leaveCard("Pending Leave", controller.leaveData[0].pending),
              _leaveCard("Rejected Leave", controller.leaveData[0].rejected),
            ],
          ):Center(child: CircularProgressIndicator()))
        ]),
      ),
    );
  }

  Widget _leaveCard(String title, int? count){
    return InkWell(
      onTap: () {
        //
      },
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              count.toString()??"0",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
