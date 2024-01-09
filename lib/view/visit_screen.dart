import 'package:flutter/material.dart';
import 'package:workmate_01/utils/colors.dart';

class VisitScreen extends StatelessWidget {
  const VisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Visit> visits = [
      Visit("Meeting", "2024-01-05", "Pune", "Mumbai"),
      Visit("Conference", "2024-01-10", "Noida", "Delhi"),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text(
          "Visit",
          style: TextStyle(color: textColor),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_rounded,
                color: textColor,
              ))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: visits.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(0.2),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text('Purpose of Visit'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(':'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(visits[index].purpose),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text('Date'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(':'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(visits[index].date),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text('From'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(':'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Text(visits[index].from),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Text('To'),
                            ),
                            TableCell(
                              child: Text(':'),
                            ),
                            TableCell(
                              child: Text(visits[index].to),
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
      ),
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
