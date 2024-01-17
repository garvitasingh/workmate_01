import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/controller/visit_controller.dart';
import 'package:workmate_01/utils/colors.dart';

class VisitScreen extends StatelessWidget {
  const VisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VisitController controller = Get.put(VisitController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: secondaryColor,
            )),
        backgroundColor: darkColor,
        title: const Text(
          "Visits",
          style: TextStyle(color: secondaryColor),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: secondaryColor,
              ))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Obx(() => controller.isLoading.isFalse
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.visitData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: getColorByIndex(index),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(0.2),
                                  2: FlexColumnWidth(1),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      const TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Text('Purpose of Visit'),
                                        ),
                                      ),
                                      const TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Text(':'),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(controller
                                                  .visitData[index]
                                                  .visitPurpose ??
                                              ""),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      const TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Text('Date'),
                                        ),
                                      ),
                                      const TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Text(':'),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(controller
                                                  .visitData[index].date ??
                                              ""),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      const TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Text('From'),
                                        ),
                                      ),
                                      const TableCell(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Text(':'),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(controller
                                                  .visitData[index].source ??
                                              ""),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      const TableCell(
                                        child: Text('To'),
                                      ),
                                      const TableCell(
                                        child: Text(':'),
                                      ),
                                      TableCell(
                                        child: Text(controller
                                                .visitData[index].destination ??
                                            ""),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(children: [
                                Expanded(child: Container(width: 150,child: Text(""),)),
                              ],)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            )),
    );
  }
}

Color getColorByIndex(int index) {
  // Replace this logic with your own color assignment
  Color baseColor = Colors.red; // Change this to your base color

  // Calculate the percentage based on the index (adjust the factor as needed)
  double percentage = (index + 1) * 30.0; // For example, 10% increments

  // Create a color with the adjusted opacity
  Color adjustedColor = baseColor.withOpacity(percentage / 100.0);

  return adjustedColor;
}

List<Color> colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.brown,
  Colors.teal,
  Colors.pink,
];

class Visit {
  final String purpose;
  final String date;
  final String from;
  final String to;

  Visit(this.purpose, this.date, this.from, this.to);
}
