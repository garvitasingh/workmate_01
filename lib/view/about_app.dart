import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:workmate_01/controller/home_controller.dart';

import '../utils/colors.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  PackageInfo? _packageInfo;
  Future<void> _loadPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
    });
  }

  final controller = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

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
          "About App",
          style: TextStyle(color: secondaryColor),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.memory(base64Decode(
                      controller.aboutapp?.data.info[0].productIcon ?? '')),
                  const SizedBox(height: 16.0),
                  Text(
                    controller.aboutapp?.data.info[0].appName ?? '',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                      'Client: ${controller.aboutapp?.data.info[0].clientName}'),
                  Text(
                      'Product: ${controller.aboutapp?.data.info[0].productName}'),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Version: ${_packageInfo?.version} ( ${_packageInfo?.buildNumber} )',
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Text(
            'Copyright © ${DateTime.now().year} ${controller.aboutapp?.data.info[0].copyrightName}',
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
