import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:workmate_01/view/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ForzaMedi',
      theme: ThemeData(
        fontFamily: 'Product Sans',
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreenView(),
    );
  }
}
