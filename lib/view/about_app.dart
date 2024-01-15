import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:workmate_01/controller/home_controller.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  late PackageInfo? _packageInfo;
  Future<void> _loadPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About App'),
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
                        controller.aboutapp!.data.claimDetails[0].productIcon)),
                    const SizedBox(height: 16.0),
                    Text(
                      controller.aboutapp!.data.claimDetails[0].appName,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Version: ${_packageInfo!.version}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                        'Client: ${controller.aboutapp!.data.claimDetails[0].clientName}'),
                    Text(
                        'Product: ${controller.aboutapp!.data.claimDetails[0].productName}'),
                    const SizedBox(height: 16.0),
                    Text(
                      'Copyright © ${DateTime.now().year} ${controller.aboutapp!.data.claimDetails[0].copyrightName}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
