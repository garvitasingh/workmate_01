import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/controller/login_controller.dart';

class VerificationUser extends StatefulWidget {
  const VerificationUser({super.key});

  @override
  State<VerificationUser> createState() => _VerificationUserState();
}

class _VerificationUserState extends State<VerificationUser> {
  final auth = Get.put(AuthController());
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 2), () {
      auth.userActivation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Verifying.....",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.green),
          ),
          Image.asset("assets/verif.gif"),
        ],
      )),
    );
  }
}
