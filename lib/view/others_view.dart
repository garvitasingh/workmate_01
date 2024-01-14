import 'package:flutter/material.dart';

class OthersView extends StatefulWidget {
  const OthersView({super.key});

  @override
  State<OthersView> createState() => _OthersViewState();
}

class _OthersViewState extends State<OthersView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Comming Soon....."),
      ),
    );
  }
}
