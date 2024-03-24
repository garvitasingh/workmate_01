import 'package:flutter/material.dart';
import 'package:workmate_01/utils/colors.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(child: Image.asset("assets/nodata.png")),
    );
  }
}
