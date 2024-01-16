import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/view/splash_view.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      title: 'ForzaMedi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreenView(),
    );
  }
}
