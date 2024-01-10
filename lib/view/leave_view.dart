import 'package:flutter/material.dart';
import 'package:workmate_01/utils/colors.dart';

class LeaveView extends StatefulWidget {
  const LeaveView({super.key});

  @override
  State<LeaveView> createState() => _LeaveViewState();
}

class _LeaveViewState extends State<LeaveView> {
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
          GridView.builder(
            shrinkWrap: true,
            itemCount: text.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 130),
            itemBuilder: (context, index) {
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
                        text[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        data[index],
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
            },
          )
        ]),
      ),
    );
  }

  List data = ["10", "1", "2", "4", "3"];
  List text = [
    "Total Leave",
    "New Leave",
    "Approve Leave",
    "Pending Leave",
    "Rejected Leave"
  ];
}
