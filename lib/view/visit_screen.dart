import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmate_01/controller/visit_controller.dart';
import 'package:workmate_01/utils/colors.dart';

class VisitScreen extends StatelessWidget {
  const VisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VisitController controller = Get.put(VisitController());

    final List<Visit> visits = [
      Visit("Meeting", "2024-01-05", "Pune", "Mumbai"),
      Visit("Conference", "2024-01-10", "Noida", "Delhi"),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: const Text(
          "Visit",
          style: TextStyle(color: textColor),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: textColor,
              ))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Obx(() => controller.isLoading.isFalse?Padding(
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
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Table(
                      columnWidths: {
                        0: const FlexColumnWidth(1),
                        1: const FlexColumnWidth(0.2),
                        2: const FlexColumnWidth(1),
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
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(controller.visitData[index].visitPurpose??""),
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
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(controller.visitData[index].date??""),
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
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(controller.visitData[index].source??""),
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
                              child: Text(controller.visitData[index].destination??""),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ):Center(child: CircularProgressIndicator(),)),
    );
  }
}

class Visit {
  final String purpose;
  final String date;
  final String from;
  final String to;

  Visit(this.purpose, this.date, this.from, this.to);
}
