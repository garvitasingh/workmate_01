import 'package:flutter/material.dart';
import 'package:workmate_01/utils/colors.dart';

class VisitScreen extends StatelessWidget {
  const VisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("Visit"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_rounded))
        ],
      ),
    );
  }
}
