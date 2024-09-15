import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/component/no_data_found.dart';
import 'package:workmate_01/utils/colors.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: appbarColor,
        title: const Text(
          "Notifications",
          style: TextStyle(color: secondaryColor),
        ),
        actions: const [],
      ),
      body: const NoDataFoundWidget(),
    );
  }
}
